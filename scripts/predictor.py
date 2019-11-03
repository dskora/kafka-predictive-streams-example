from confluent_kafka import Consumer, Producer, KafkaError

import time
import json
import pandas
import pandas as pd
import pickle
import numpy as np

from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn import metrics

c = Consumer({
    'bootstrap.servers': 'localhost',
    'group.id': 'mygroup',
    'auto.offset.reset': 'earliest'
})
p = Producer({'bootstrap.servers': 'localhost'})

c.subscribe(['SESSIONS_RATIO_PER_DATE_STUDENT'])

while True:
    msg = c.poll(1.0)

    if msg is None:
        continue
    if msg.error():
        print("Consumer error: {}".format(msg.error()))
        continue

    data = json.loads(msg.value().decode('utf-8'))

    # predict results
    col_names = ['avg_activities', 'avg_session_duration', 'sessions', 'withdrawn']

    # todo - replace path	
    pima = pd.read_csv("####path/sessions.csv####", header=None, names=col_names)

    feature_cols = ['avg_activities', 'avg_session_duration', 'sessions']

    X = pima[feature_cols]
    y = pima.withdrawn

    X_train,X_test,y_train,y_test=train_test_split(X,y,test_size=0.25,random_state=0)

    logreg = LogisticRegression()

    if data['AVG_DURATION'] is None:
        continue

    logreg.fit(X_train,y_train)
    y_pred = logreg.predict_proba([[data['COUNT'], data['AVG_DURATION'], data['AVG_ACTIVITIES']]])

    prediction = json.dumps({"STUNUMBER": data['STUNUMBER'], "PREDICTION": y_pred[0][1], "DATE": data['DATE']})
    print('Received message: {}', data, ', Withdrawal prediction: ', y_pred[0][1])

    p.produce('MOODLE_WITHDRAWAL_PREDICTIONS_PER_STUDENT', prediction)

c.close()

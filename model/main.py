import pandas
import pandas as pd
import pickle
import numpy as np

from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn import metrics

col_names = ['avg_activities', 'avg_session_duration', 'sessions', 'withdrawn']
pima = pd.read_csv("/Users/dskora/samples/kafka-moodle-activity/data/sessions.csv", header=None, names=col_names)

feature_cols = ['avg_activities', 'avg_session_duration', 'sessions']

X = pima[feature_cols]
y = pima.withdrawn

X_train,X_test,y_train,y_test=train_test_split(X,y,test_size=0.25,random_state=0)

logreg = LogisticRegression()

logreg.fit(X_train,y_train)

coefficients = pd.concat([pd.DataFrame(feature_cols),pd.DataFrame(np.transpose(logreg.coef_))], axis = 1)

y_pred = logreg.predict(X_test)

print("Accuracy:" , metrics.accuracy_score(y_test, y_pred))
print coefficients

# save model
filename = '/Users/danpas/samples/kafka-moodle-activity/model/model.pickle'
pickle.dump(logreg, open(filename, 'wb'))

import smtplib
import json
from confluent_kafka import Consumer, KafkaError

from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.mime.base import MIMEBase

gmail_user = 'daniel.sbuy@gmail.com'
gmail_password = 'fuxdnuafqhhwlcnj'

c = Consumer({
    'bootstrap.servers': 'localhost',
    'group.id': 'mygroup',
    'auto.offset.reset': 'earliest'
})

c.subscribe(['MOODLE_LOGS_PREDICTION_IN_RISK'])

while True:
    msg = c.poll(1.0)

    if msg is None:
        continue
    if msg.error():
        print("Consumer error: {}".format(msg.error()))
        continue

    data = json.loads(msg.value().decode('utf-8'))

    print('Received message: {}', data)

    msg = MIMEMultipart()
    msg['From'] = 'daniel.sbuy@gmail.com'
    msg['To'] = 'daniel.sbuy@gmail.com'
    msg['Subject'] = 'Withdrawal Risky Student'
    body = 'Dear Student Support,\nUser ' + str(data['USERID']) + ' has gone into withdrawal path with prediction score: ' + str(data['PREDICTION'])

    msg.attach(MIMEText(body, 'plain'))
    try:
        server = smtplib.SMTP_SSL('smtp.gmail.com', 465)
        server.ehlo()
        server.login(gmail_user, gmail_password)
        text = msg.as_string()
        server.sendmail("withdrawal-notifier@arden.com", "daniel.sbuy@gmail.com", text)
    except Exception as inst:
        print(inst)

c.close()

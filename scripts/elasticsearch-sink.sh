#!/bin/sh

curl -s \
     -X "POST" "http://localhost:18083/connectors/" \
     -H "Content-Type: application/json" \
     -d '{
  "name": "sink_elastic_logs",
  "config": {
    "topics": "MOODLE_LOGS_SESSIONS_PER_15MINS",
    "key.converter": "org.apache.kafka.connect.storage.StringConverter",
    "value.converter": "org.apache.kafka.connect.json.JsonConverter",
    "value.converter.schemas.enable": false,
    "connector.class": "io.confluent.connect.elasticsearch.ElasticsearchSinkConnector",
    "key.ignore": "true",
    "schema.ignore": "true",
    "type.name": "kafkaconnect",
    "connection.url": "http://elasticsearch:9200"
  }
}'

curl -s \
     -X "POST" "http://localhost:18083/connectors/" \
     -H "Content-Type: application/json" \
     -d '{
  "name": "sink_elastic_logs_prediction_in_risk",
  "config": {
    "topics": "MOODLE_LOGS_PREDICTION_IN_RISK",
    "key.converter": "org.apache.kafka.connect.storage.StringConverter",
    "value.converter": "org.apache.kafka.connect.json.JsonConverter",
    "value.converter.schemas.enable": false,
    "connector.class": "io.confluent.connect.elasticsearch.ElasticsearchSinkConnector",
    "key.ignore": "true",
    "schema.ignore": "true",
    "type.name": "kafkaconnect",
    "connection.url": "http://elasticsearch:9200"
  }
}'

curl -s \
     -X "POST" "http://localhost:18083/connectors/" \
     -H "Content-Type: application/json" \
     -d '{
  "name": "sessions_ratio_per_student",
  "config": {
    "topics": "SESSIONS_RATIO_PER_STUDENT",
    "key.converter": "org.apache.kafka.connect.storage.StringConverter",
    "value.converter": "org.apache.kafka.connect.json.JsonConverter",
    "value.converter.schemas.enable": false,
    "connector.class": "io.confluent.connect.elasticsearch.ElasticsearchSinkConnector",
    "key.ignore": "true",
    "schema.ignore": "true",
    "type.name": "kafkaconnect",
    "connection.url": "http://elasticsearch:9200"
  }
}'

curl -s \
     -X "POST" "http://localhost:18083/connectors/" \
     -H "Content-Type: application/json" \
     -d '{
  "name": "withdrawal_predictions_per_student",
  "config": {
    "topics": "MOODLE_WITHDRAWAL_PREDICTIONS_PER_STUDENT",
    "key.converter": "org.apache.kafka.connect.storage.StringConverter",
    "value.converter": "org.apache.kafka.connect.json.JsonConverter",
    "value.converter.schemas.enable": false,
    "connector.class": "io.confluent.connect.elasticsearch.ElasticsearchSinkConnector",
    "key.ignore": "true",
    "schema.ignore": "true",
    "type.name": "kafkaconnect",
    "connection.url": "http://elasticsearch:9200"
  }
}'

curl -s \
     -X "POST" "http://localhost:18083/connectors/" \
     -H "Content-Type: application/json" \
     -d '{
  "name": "sink_mysqdl6",
  "config": {
      "connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",
      "connection.url": "jdbc:mysql://mysql:3306/demo?user=root&password=debezium",
      "topics": "SESSIONS_RATIO_PER_STUDENT_AVRO",
      "key.converter.schemas.enable": false,
      "value.converter.schemas.enable": true,
      "key.converter": "org.apache.kafka.connect.storage.StringConverter",
      "key.converter.schema.registry.url": "http://schema-registry:8081",
      "value.converter": "io.confluent.connect.avro.AvroConverter",
      "value.converter.schema.registry.url": "http://schema-registry:8081",
      "auto.create": "true",
      "batch.size": "1",
      "auto.create": "true"
  }
}'
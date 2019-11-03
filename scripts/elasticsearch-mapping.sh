#!/bin/sh

curl -XPUT "http://localhost:9200/_template/kafkaconnect/" -H 'Content-Type: application/json' -d'
{
  "index_patterns": "*moodle*",
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  },
  "mappings": {
    "kafkaconnect": {
      "dynamic_templates": [
        {
          "dates": {
            "match": "*DATE",
            "mapping": {
              "type": "date"
            }
          }
        }
      ]
    }
  }
}'
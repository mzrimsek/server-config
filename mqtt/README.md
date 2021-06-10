# MQTT Options

MQTT Brokers are great for asynchronously communicating data between applications without tightly coupling them to each other.

## RabbitMQ

[RabbitMQ](https://www.rabbitmq.com/) is a widely used MQTT broker.

* Data: Must have a directory to persist the message data, mounted as a volume to `var/lib/rabbitmq`
* Log: Must have a directory to persist the log information, mounted as a volume to `var/log/rabbitmq`

Note: RabbitMQ apparently does not work with Home Assistant - prefer using Mosquitto if that is a use case for the MQTT Broker.

## Mosquitto

Mosquitto is a super lightweight MQTT broker. [Info on setup](https://blog.feabhas.com/2020/02/running-the-eclipse-mosquitto-mqtt-broker-in-a-docker-container/).

* Data: Must have a directory to persist data, mounted as a volume to `/mosquitto/data`
* Log: Must have a directory to persist log files, mounted as a volume to `/mosquitto/log`
* Config: Must have a directory to persist config files, mounted as a volume to `/mosquitto/config`
  * Place the config file provided in this directory to get started
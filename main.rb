#!/usr/bin/env ruby

require 'kafka'

kafka = Kafka.new([
    "kafka-node-01:9092", 
    "kafka-node-02:9092", 
    "kafka-node-03:9092"]
)

# Consumers with the same group id will form a Consumer Group together.
consumer = kafka.consumer(group_id: "my-consumer")

# It's possible to subscribe to multiple topics by calling `subscribe`
# repeatedly.
consumer.subscribe("hello-world")

# Stop the consumer when the SIGTERM signal is sent to the process.
# It's better to shut down gracefully than to kill the process.
trap("TERM") { consumer.stop }

# This will loop indefinitely, yielding each message in turn.
consumer.each_message do |message|
  puts message.topic, message.partition
  puts message.offset, message.key, message.value
end
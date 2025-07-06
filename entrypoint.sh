#!/bin/sh

# Jalankan default entrypoint dari image RabbitMQ
/entrypoint.sh rabbitmq-server &

# Tunggu RabbitMQ siap
sleep 10

# Membuat Exchange "order_created" dengan tipe "fanout"
curl -u ${RABBITMQ_DEFAULT_USER}:${RABBITMQ_DEFAULT_PASS} -X POST "http://localhost:15672/api/exchanges/%2f/order_created" \
  -H "Content-Type: application/json" \
  -d '{"type":"fanout","auto_delete":false,"durable":true}'

# Membuat Queue "order.process"
curl -u ${RABBITMQ_DEFAULT_USER}:${RABBITMQ_DEFAULT_PASS} -X POST "http://localhost:15672/api/queues/%2f/order.process" \
  -H "Content-Type: application/json" \
  -d '{"durable":true,"auto_delete":false}'

# Membuat Queue "order.confirmation"
curl -u ${RABBITMQ_DEFAULT_USER}:${RABBITMQ_DEFAULT_PASS} -X POST "http://localhost:15672/api/queues/%2f/order.confirmation" \
  -H "Content-Type: application/json" \
  -d '{"durable":true,"auto_delete":false}'

# Mengikat Queue "order.process" ke Exchange "order_created"
curl -u ${RABBITMQ_DEFAULT_USER}:${RABBITMQ_DEFAULT_PASS} -X POST "http://localhost:15672/api/bindings/%2f/order_created/order.process" \
  -H "Content-Type: application/json" \
  -d '{}'

# Mengikat Queue "order.confirmation" ke Exchange "order_created"
curl -u ${RABBITMQ_DEFAULT_USER}:${RABBITMQ_DEFAULT_PASS} -X POST "http://localhost:15672/api/bindings/%2f/order_created/order.confirmation" \
  -H "Content-Type: application/json" \
  -d '{}'

# Matikan proses background dan lanjutkan dengan default command
wait

#!/bin/bash

docker build -t docker-magento-ce .

echo To publish use:
echo docker tag docker-magento-ce alankent/docker-magento-ce
echo docker tag docker-magento-ce alankent/docker-magento-ce:1.9.0
echo docker push alankent/docker-magento-ce:1.9.0

#!/bin/bash

set -e

echo "Запускаем контейнеры"

docker run -dit --name centos7 centos:7 bash
docker run -dit --name ubuntu ubuntu:20.04 bash
docker run -dit --name fedora_os pycontribs/fedora

echo "Устанавливаем Python в контейнере с образом Ubuntu"
docker exec ubuntu bash -c "apt update && apt install -y python3"

echo "Запускаем Playbook"
ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass

echo "Оставливаем контейнеры"
docker stop centos7 ubuntu fedora_os
docker rm centos7 ubuntu fedora_os

echo "Готово"

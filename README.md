# Opção 1: Rodar local
go run kafka.go

# Opção 2: Rodar container local
docker build -t sascararquitetura/golang-docker-example-rest .

docker run -p 8000:8000 sascararquitetura/golang-docker-example-rest

# Testar local - Produzir mensagens
http://localhost:8000/kafka

# Para subir a imagem no docker repo
./buildPushImage.sh

# para subir no openshift
oc create -f ./etc/openshift/deployment.yaml
oc create -f ./etc/openshift/service.yaml
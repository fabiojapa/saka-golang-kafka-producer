# Opção 1: Rodar local
go run kafka.go

# Opção 2: Rodar container local
- Ajustar org xpto:

docker build -t xpto/golang-docker-example-rest .

docker run -p 8000:8000 xpto/golang-docker-example-rest

# Testar local - Produzir mensagens
http://localhost:8000/kafka
cp for-be/.dockerignore nestjs-rest-api/
cp for-be/Dockerfile nestjs-rest-api/
cp for-be/.env.prod nestjs-rest-api/
cd ./nestjs-rest-api

echo "Building docker image 'vladlanondocker/nestjs-rest-api' ..."
docker build -t vladlanondocker/nestjs-rest-api:1.0 .

echo "Pushing docker image 'vladlanondocker/nestjs-rest-api' ..."
docker push vladlanondocker/nestjs-rest-api:1.0

rm .dockerignore 
rm Dockerfile 
rm .env.prod

# To check it locally
# docker run --env-file .env.prod -p 80:4200 vladlanondocker/nestjs-rest-api:latest

# To check container files (should not have .envs)
# docker exec -it 515b8c896fe2 /bin/bash

# pgRoutingDigoG

sudo chown -R $USER:$USER .

rm -rf data

POSTGRES_PASSWORD=123 docker-compose up
POSTGRES_PASSWORD=123 docker-compose up -d
POSTGRES_PASSWORD=123 docker-compose down
# !/bin/bash
# Programa para ejecutar los contenedores

current_dir=$(pwd)/api

#Desplegar docker-compose
docker-compose down

# read -p "Ingrese el IP de la base de datos: " host
# read -p "Ingrese puerto: " port
# read -p "Ingrese el nombre de la base de datos: " database
# read -p "Ingrese su usuario: " username
# echo -n "Ingrese su contraseña: ";
# read -s password

# vhost=`cat $current_dir/.env.example`
# vhost=${vhost//@host@/$host}
# vhost=${vhost//@port@/$port}
# vhost=${vhost//@database@/$database}
# vhost=${vhost//@username@/$username}
# vhost=${vhost//@password@/$password}

# echo "$vhost" > "$current_dir/.env"

docker run --rm -v $current_dir:/app prooph/composer:7.2 install

docker run --rm -v $current_dir:/app php:7.2-alpine php /app/artisan key:generate;

sudo chown -R $(whoami):www-data $current_dir;
sudo chmod -R 775  $current_dir/storage/ $current_dir/bootstrap/cache;

docker-compose up --build
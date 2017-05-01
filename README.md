# pgRoutingDigoG

Antes de inicar el servicio con docker, necesitamos descomprimir el archivo de las vialidades.

```
# unzip sql_dump/003-red_vial.sql.zip -d sql_dump
```

Ya que se descomprimio el archivo podemos iniciar el serivio.

```
# POSTGRES_PASSWORD=<PASSWORD> docker-compose up
```

Para elimitar la carpeta `data` donde se encuentra los datos. Esto en el caso querer cargar los datos de nuevo.

Cambiar permisos

```
# sudo chown -R $USER:$USER .
```

Una vez que se cambiaron los permisos podemos borrar la carpeta.
```
# rm -rf data
```
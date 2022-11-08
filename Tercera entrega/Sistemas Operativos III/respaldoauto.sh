#!/bin/bash

mysqldump --opt --events --routines --triggers --default-character-set=utf8 -u root -pgrupogforze gforze > gforze.sql
mv gforze.sql /root/respaldos_database

echo "(date +%Y/%m/%d-%H:%M:%S)Se ah realizado el autorespaldo de la base de datos gforze correctamente" >> /root/logs_propios/respaldos.txt

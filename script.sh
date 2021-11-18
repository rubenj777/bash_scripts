#!/bin/bash


#ici on demande à l'user de nous donner son nom. s'il ne s'appelle pas Jo,
#le script est relancé.
echo "coucou"
echo "comment tu t'appelles ?"
read name

if [ $name = jo ]
then
    echo "bonjour $name !"
    

else
    echo "non tu mens"
    bash script.sh
fi
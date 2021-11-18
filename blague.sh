#!/bin/bash

#https://api.chucknorris.io/jokes/random
#ici on va chercher une blague random par l'API chuck norris et garder uniquement
#la .value

blagueRandom=$(curl -s https://api.chucknorris.io/jokes/random | jq -r '.value')
echo $blagueRandom
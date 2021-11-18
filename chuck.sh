#!/bin/bash

#importation d'une API JSon, utilisation de JQ afin de rendre lisible les
#données par bash
#on demande à l'user s'il veut une blague oui/non
#à la fin, la blague est enregistrée dans un .txt

declare -a postit=()
encore=true

debutPage="<html><head><title>lol</title></head><body>"

finPage="</body></html>"

baliseH2ouvrante="<h2>"
balideH2fermante="</h2"

while $encore;
    do
        echo "tu veux une blague au hasard ?"
        read reponse
        if [ $reponse = oui ]

        then
            blague=$(curl -s https://api.chucknorris.io/jokes/random | jq -r '.value')
    
        else
            echo "t'es sûr ? tiens, choisi dans cette catégorie :"
            categories=$(curl -s https://api.chucknorris.io/jokes/categories | jq -r '.[]')


        for categorie in ${categories[@]}
        do
            echo $categorie 
        done


        read quelleCategorie
        blague=$(curl -s https://api.chucknorris.io/jokes/random?category=$quelleCategorie | jq -r '.value')

        fi

        echo $blague

        echo "tu veux garder celle-ci ?"
        read ouiOuNon

        if [ $ouiOuNon = oui ]
            then
                postit+=("$blague")
        fi

        echo "tu en veux encore ?"
        read encoreUne
        if [ $encoreUne != oui ]
            then
                encore=false
        fi
    done

echo "tu veux voir le post it ?"
read ouiOuNon

if [ $ouiOuNon = oui ]
    then
        printf "%s\n" "${postit[@]}"
fi

echo "tu veux l'afficher sur une page web ?"
read ouiOuNon

if [ $ouiOuNon = oui ]
    then
        pageWeb=""
        pageWeb+=$debutPage

        for blagueChuck in "${postit[@]}"
            do
                blagueHtml=""
                blagueHtml+=$baliseH2ouvrante
                blagueHtml+="$blagueChuck"
                blagueHtml+=$baliseH2ouvrante

                pageWeb+=$blagueHtml
            done

        pageWeb+=$finPage

        echo $pageWeb > index.html
        cp index.html /var/www/html/index.html
        firefox localhost
fi
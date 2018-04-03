#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Usage:";
  echo "Search for domains - ./script.sh -d domain.com" 
  echo "Search for emails  - ./script.sh -e foo@bar.com"
  echo "General search     - ./script.sh -g foobar"
  exit 0;
fi

if [[ $1 == '-g' ]] && [[ $2 != '' ]] ; then
        mkdir ./output/general/$2/
        echo "Searching pastebin..."
        curl -s -X GET "https://psbdmp.ws/api/search/$2" | python -m json.tool > ./output/general/$2/output.json #Get search data
        cat ./output/general/$2/output.json | jq -r '.data[] | .id' | awk '{print "https://psbdmp.ws/" $1 }' > ./output/general/$2/urls.txt # Create urls.txt
        echo "Task completed. Output present in ./output/general/$2/"
        exit 0
        elif [[ $2 == '' ]]; then 
        echo "No input"
        exit 0
fi

if [[ $1 == '-e' ]] && [[ $2 != '' ]] ; then
        mkdir ./output/email/$2/
        echo "Searching pastebin..."
        curl -s -X GET "https://psbdmp.ws/api/search/email/$2" | python -m json.tool > ./output/email/$2/output.json #Get search data
        cat ./output/email/$2/output.json | jq -r '.data[] | .id' | awk '{print "https://psbdmp.ws/" $1 }' > ./output/email/$2/urls.txt # Create urls.txt
        echo "Task completed. Output present in ./output/email/$2/"
        exit 0
        elif [[ $2 == '' ]]; then 
        echo "No input"
        exit 0
fi

if [[ $1 == '-d' ]] && [[ $2 != '' ]] ; then
        mkdir ./output/domain/$2/
        echo "Searching pastebin..."
        curl -s -X GET "https://psbdmp.ws/api/search/domain/$2" | python -m json.tool > ./output/domain/$2/output.json #Get search data
        cat ./output/domain/$2/output.json | jq -r '.data[] | .id' | awk '{print "https://psbdmp.ws/" $1 }' > ./output/domain/$2/urls.txt # Create urls.txt
        echo "Task completed. Output present in ./output/domain/$2/"
        exit 0
        elif [[ $2 == '' ]]; then
        echo "No input"
        exit 0
fi




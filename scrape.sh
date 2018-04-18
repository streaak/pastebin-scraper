 echo -e "$(tput setaf 1)        ____  ____          _____   __  ____    ____  ____   ___  ____  
        |    \|    \        / ___/  /  ]|    \  /    ||    \ /  _]|    \ 
        |  o  )  o  ) _____(   \_  /  / |  D  )|  o  ||  o  )  [_ |  D  )
        |   _/|     ||     |\__  |/  /  |    / |     ||   _/    _]|    / 
        |  |  |  O  ||_____|/  \ /   \_ |    \ |  _  ||  | |   [_ |    \ 
        |  |  |     |       \    \     ||  .  \|  |  ||  | |     ||  .  \ 
        |__|  |_____|        \___|\____||__|\_||__|__||__| |_____||__|\_|$(tput sgr0)"

echo -e "\n\t\t\t\t By @Streaak"
if [ $# -eq 0 ] || [ $1 == '-h' ]; then
  echo -e "$(tput setaf 2)\nUsage:$(tput sgr0)" 
  echo "Search for domains - ./script.sh -d domain.com"
  echo "Search for emails  - ./script.sh -e foo@bar.com"
  echo "General search     - ./script.sh -g foobar"
  exit 0
fi

function scrape() {
        echo "Searching pastebin..."
        curl -s -X GET "$url" | python -m json.tool > ./output/$dir/output.json 
        cat ./output/$dir/output.json | jq -r '.data[] | .id' | awk '{print "https://psbdmp.ws/" $1 }' > ./output/$dir/urls.txt
        echo "Task completed. Output present in ./output/$dir/$2"
        exit 0
        return 0
}

if [[ $1 == '-g' ]] && [[ $2 != '' ]] ; then
dir=general/$2
url=https://psbdmp.ws/api/search/$2
mkdir -p ./output/$dir/
scrape
elif [[ $2 == '' ]]; then
        echo "Missing Value. Try to run ./script.sh -g <Term here>"
        exit 0
fi

if [[ $1 == '-e' ]] && [[ $2 != '' ]] ; then
dir=email/$2
url=https://psbdmp.ws/api/search/email/$2
mkdir -p ./output/$dir/
scrape
elif [[ $2 == '' ]]; then
        echo "Missing Value. Try to run ./script.sh -e <Term here>"
        exit 0
fi

if [[ $1 == '-d' ]] && [[ $2 != '' ]] ; then
dir=domain/$2
url=https://psbdmp.ws/api/search/domain/$2
mkdir -p ./output/$dir/
scrape
elif [[ $2 == '' ]]; then
        echo "Missing Value. Try to run ./script.sh -d <Term here>"
        exit 0
fi

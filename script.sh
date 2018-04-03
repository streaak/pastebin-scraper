if [ $# -eq 0 ] || [ $1 == '-h' ]; then
  echo "Usage:";
  echo "Search for domains - ./script.sh -d domain.com"
  echo "Search for emails  - ./script.sh -e foo@bar.com"
  echo "General search     - ./script.sh -g foobar"
  exit 0;
fi

function test() {
        echo "Searching pastebin..."
        curl -s -X GET "$url" | python -m json.tool > ./output/$dir/output.json 
        cat ./output/$dir/output.json | jq -r '.data[] | .id' | awk '{print "https://psbdmp.ws/" $1 }' > ./output/$dir/urls.txt
        echo "output present in ./output/$dir/$2"
        exit 0
        return 0
}

if [[ $1 == '-g' ]] && [[ $2 != '' ]] ; then
dir=general/$2
url=https://psbdmp.ws/api/search/$2
mkdir ./output/$dir/
test
elif [[ $2 == '' ]]; then
        echo "Missing Value. Try to run ./script.sh -g <Term here>"
        exit 0
fi

if [[ $1 == '-e' ]] && [[ $2 != '' ]] ; then
dir=email/$2
url=https://psbdmp.ws/api/search/email/$2
mkdir ./output/$dir/
test
elif [[ $2 == '' ]]; then
        echo "Missing Value. Try to run ./script.sh -e <Term here>"
        exit 0
fi

if [[ $1 == '-d' ]] && [[ $2 != '' ]] ; then
dir=domain/$2
url=https://psbdmp.ws/api/search/domain/$2
mkdir ./output/$dir/
test
elif [[ $2 == '' ]]; then
        echo "Missing Value. Try to run ./script.sh -d <Term here>"
        exit 0
fi

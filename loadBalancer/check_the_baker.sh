
COUNTER=0
while [  $COUNTER -eq 0 ]; do
    RESPONSE=$(curl -S -s -H "Content-Type: application/json"  -X POST -d '{ "username": "123456789012", "token": "-", "millis": "-", "gametype": "othello","reseller": "12345","clientversion":"ver01"}'     "http://${1}:${2}/generate" )
    ##echo ${RESPONSE}
    searchstring="baker"
    rest=${RESPONSE#*$searchstring}
    ##echo ${rest}
    mod=${rest//[:\}\"]/}
    echo ${mod}
done
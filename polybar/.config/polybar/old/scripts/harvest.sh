#!/usr/bin/env bash

ACCESS_TOKEN=1596442.pt.JW8_Zbphm_RWEe3Rj0nfeLHzRqil1TxoTYtM7qeNUu3l66kaThVHJ0HUQWA6Yvd0sQXwh3vIGr6DR6bJ3AA8kA
ACCOUNT_ID=929259
CRAYON=19456852
TE1=20884702
TE2=21404879
FROM=$(date +"%Y-%m-%d")
TO=$FROM

#CRAYON_ENTRIES=$(curl -s "https://api.harvestapp.com/v2/time_entries?project_id=$CRAYON&from=$FROM" \
  #-H "Authorization: Bearer $ACCESS_TOKEN" \
  #-H "Harvest-Account-Id: $ACCOUNT_ID" \
  #-H "User-Agent: Desklet (claude@dxt.rs)")

TOTAL_TIME=0
#for row in $(echo $CRAYON_ENTRIES | jq -c '.time_entries[] | .hours'); do
  #TOTAL_TIME=$(echo "$TOTAL_TIME + $row" | bc)
#done

CR_TOTAL_TIME=$TOTAL_TIME

TE_ENTRIES=$(curl -s "https://api.harvestapp.com/v2/time_entries?project_id=$TE1&from=$FROM" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H "Harvest-Account-Id: $ACCOUNT_ID" \
  -H "User-Agent: Desklet (claude@dxt.rs)")

TOTAL_TIME=0
for row in $(echo $TE_ENTRIES | jq -c '.time_entries[] | .hours'); do
  TOTAL_TIME=$(echo "$TOTAL_TIME + $row" | bc)
done

#TE_ENTRIES=$(curl -s "https://api.harvestapp.com/v2/time_entries?project_id=$TE2&from=$FROM" \
  #-H "Authorization: Bearer $ACCESS_TOKEN" \
  #-H "Harvest-Account-Id: $ACCOUNT_ID" \
  #-H "User-Agent: Desklet (claude@dxt.rs)")

#for row in $(echo $TE_ENTRIES | jq -c '.time_entries[] | .hours'); do
  #TOTAL_TIME=$(echo "$TOTAL_TIME + $row" | bc)
#done

echo 'TE:' $TOTAL_TIME; # ' | C:' $CR_TOTAL_TIME;

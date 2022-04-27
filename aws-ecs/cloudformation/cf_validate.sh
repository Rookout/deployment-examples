#!/bin/bash
ERROR_COUNT=0;
WHERE=${1:-'./templates'}

echo "Validating AWS CloudFormation templates..."

# Loop through the YAML templates in this repository
for TEMPLATE in $(find $WHERE -name '*.yaml'); do

    # Validate the template with CloudFormation
    ERRORS=$(aws cloudformation validate-template --template-body file://$TEMPLATE 2>&1 >/dev/null);
    EXIT_CODE=$?
    MD5=$(md5sum $TEMPLATE | awk '{print $1}')
    template_hash_file=/tmp/$(basename ${TEMPLATE}).md5sum
    if [[ "$EXIT_CODE" -gt "0" ]]; then
        ((ERROR_COUNT++));
        printf "%-50s %s" "[fail] $TEMPLATE: $ERRORS" $MD5;
    else
        printf "%-50s %s" "[pass] $TEMPLATE" $MD5;
    fi
    if [ -f $template_hash_file ]; then

        OLD_MD5="$(cat -s $template_hash_file)"
        if [ ! "$OLD_MD5" == "$MD5" ]; then
            printf "\x1b[31m %s\x1b[0m %s " "CHANGED" "was $OLD_MD5"
        fi
    fi
    printf "\n"
    echo $MD5 > $template_hash_file

done;

echo "$ERROR_COUNT template validation error(s)";
if [ "$ERROR_COUNT" -gt 0 ];
    then exit 1;
fi
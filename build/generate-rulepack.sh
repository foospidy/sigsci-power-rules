#!/usr/bin/env bash
# Generate rule pack from template

if [ -z $1 ];
then
    echo "Usage: generate.sh <name>"
    exit
fi

if [ ! -f "templates/${1}.json" ];
then
    echo "Template not found."
    exit
fi

POWER_RULES_DIR_PREFIX='../power-rules-'
SITE=`cat templates/${1}.json | jq .site | sed -e "s/\"//g"`
NAME=`cat templates/${1}.json | jq .name | sed -e "s/\"//g"`

echo "Generating rulepack from ${1} from ${SITE}..."

mkdir -p ${POWER_RULES_DIR_PREFIX}${NAME}

declare -a arr=("request-rules" "signal-rules" "templated-rules" "advanced-rules" "rule-lists" "site-lists" "corp-lists" "custom-signals" "site-signals" "corp-signals" "custom-alerts")

for type in "${arr[@]}";
do
    json_array=`echo ${type} | tr '-' '_'`

    rm -rf ${POWER_RULES_DIR_PREFIX}${NAME}/${type}*.json
    order=0
    for identifier in `cat templates/${1}.json | jq .${json_array}[] | sed -e "s/\"//g"`;
    do
        let order+=1
        file="${POWER_RULES_DIR_PREFIX}${NAME}/${type}-${order}.json"
        id_field=".id"

        if [ $type == "custom-signals" ];
        then
            id_field=".tagName"
        fi

        if [ $type == "site-signals" ];
        then
            id_field=".tagName"
        fi

        if [ $type == "corp-signals" ];
        then
            id_field=".tagName"
        fi

        JSON=`pysigsci --get ${type} --site ${SITE} | jq ".data[] | select(${id_field} == \"${identifier}\")"`
        echo ${JSON} | jq "del(.updated, .created, .createdBy, .id)" >> $file
    done
done

echo "Done!"

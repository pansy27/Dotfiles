#!/bin/sh

envFile=~/.scripts/env.sh
changeValue=300

changeMode() {
  sed -i "s/GAMMASTEP=$1/GAMMASTEP=$2/g" $envFile 
  GAMMASTEP=$2
  echo $GAMMASTEP
}

changeTemp() {
  if [ "$2" -gt 1000 ] && [ "$2" -lt 25000 ]
  then
    sed -i "s/GAMMASTEP_TEMP=$1/GAMMASTEP_TEMP=$2/g" $envFile 
    gammastep -P -O $((GAMMASTEP_TEMP+changeValue))
  fi
}

case $1 in 
  toggle) 
    if [ "$GAMMASTEP" = on ];
    then
      changeMode "$GAMMASTEP" off
      gammastep -x
    else
      changeMode "$GAMMASTEP" on
      gammastep -O "$GAMMASTEP_TEMP"
    fi
    ;;
  increase)
    changeTemp $((GAMMASTEP_TEMP)) $((GAMMASTEP_TEMP+changeValue))
    ;;
  decrease)
    changeTemp $((GAMMASTEP_TEMP)) $((GAMMASTEP_TEMP-changeValue));
    ;;
  temperature)
    case $GAMMASTEP in
      on)
        printf "%dK" "$GAMMASTEP_TEMP"
        ;;
      off)
        printf "off"
        ;;
    esac
    ;;
esac

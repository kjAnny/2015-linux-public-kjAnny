#!/bin/bash

function HELP
{
  echo "usage:[-a][-p][-n][-y]"
  echo "      [-a]    Statistics on players age scale"
  echo "      [-p]    Statistics on players at different position"
  echo "      [-n]    To find the longest name and the shortest name"
  echo "      [-y]    To find the oldest and yougest player"
}

function Age
{
  age=$(awk -F "\t" '{ print $6 }' worldcupplayerinfo.tsv)
  sum=0
  low_20=0
  up_30=0
  btw_20_30=0

  for n in $age;
  do
    if [ $n != 'Age' ]; then
      sum=$[$sum+1]
      if [ $n -lt 20 ]; then
        low_20=$[$low_20+1]
      elif [ $n -gt 30 ]; then
        up_30=$[$up_30+1]
      elif [ $n -ge 20 ] && [ $n -le 30 ]; then
        btw_20_30=$[$btw_20_30+1]
      fi
    fi
  done

  echo "$low_20 players age under 20,account for $(echo "scale=3;$low_20*100/$sum" | bc) %"

  echo "$btw_20_30 players age between 20 and 30,account for $(echo "scale=3;$btw_20_30*100/$sum" | bc) %"

  echo "$up_30 players age over 30,acount for $(echo "scale=3;$up_30*100/$sum" | bc) %"

}

function Age_cmp
{
  age=$(awk -F "\t" '{ print $6 }' worldcupplayerinfo.tsv)
  sum=0
  young=200
  old=0

  for n in $age
  do
    if [ $n != "Age" ]; then
      sum=$[$sum+1]

      if [ $young -gt $n ]; then
        young=$n
      fi

      if [ $old -lt $n ]; then
        old=$n
      fi
    fi
  done

  awk=$(awk -F '\t' '{if($6=='$young') {print $9}}' worldcupplayerinfo.tsv);
  for i in $awk;
  do
    echo "$i is the youngest player, at the age of $young"
  done

  awk=$(awk -F '\t' '{if($6=='$old') {print $9}}' worldcupplayerinfo.tsv);
  for j in $awk;
  do
    echo "$j is the oldest player,at the age of $old"
  done
}

function Name
{
  name=$(awk -F "\t" '{ print length($9) }' worldcupplayerinfo.tsv)
  max=0
  min=100

  for i in $name
  do
    if [ $max -lt $i ]; then
      max=$i
    fi
    if [ $min -gt $i ]; then
      min=$i
    fi
  done

  awk=$(awk -F '\t' '{if (length($9)=='$max'){print $9}}' worldcupplayerinfo.tsv)
  echo "The longest player name is $awk and the length is $max"

  awk=$(awk -F '\t' '{if (length($9)=='$min'){print $9}}' worldcupplayerinfo.tsv)
  echo "The shortest player name is $awk and the length is $min"

}

function Position
{
  posi=$(sed -n '2, $ p' worldcupplayerinfo.tsv | awk -F '\t' '{print $5}'|sort -u);
  total=$(sed -n '2, $ p' worldcupplayerinfo.tsv | awk -F '\t' '{print $5}');

  pos=($posi)
  all=($total)

  ans=0
  for j in "${pos[@]}"
  do
    count[$ans]=0
    ans=$((ans+1))
  done

  for i in "${all[@]}"
  do
    ans=0
    for j in "${pos[@]}"
    do
      if [[ ${pos[$ans]} == $i ]]; then
        count["$ans"]=$[${count[$ans]}+1]
      fi
      ans=$((ans+1))
    done
  done

  ans=0
  for j in "${pos[@]}"
  do
    echo "Position:"${pos[$ans]}"   Players Number:"${count[$ans]}",Account for:$(echo "scale=3;${count[$ans]}*100/${#all[@]}" | bc) %"
    ans=$((ans+1))
  done

}

function main()
{
  if [ $# -ge 1 ] ;
  then
    for i in $*
    do
      case $i in
        -a) Age;;
       -p) Position;;
       -n) Name;;
       -y) Age_cmp;;
       -h) HELP;;
       --help) HELP;;
     esac
    done
  else
    HELP
  fi
}

main $1 $2 $3 $4 $5 $6

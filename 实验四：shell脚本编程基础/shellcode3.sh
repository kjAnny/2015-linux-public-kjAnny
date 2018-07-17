#!/bin/bash

function HELP
{
  echo "usage:[-s][-i][-u][-c][-e][-o][-h]"
  echo "      -s          统计访问来源主机TOP 100和分别对应出现的总次数"
  echo "      -i          统计访问来源主机TOP 100 IP和分别对应出现的总次数"
  echo "      -u          统计最频繁被访问的URL TOP 100"
  echo "      -c          统计不同响应状态码的出现次数和对应百分比"
  echo "      -e          分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数"
  echo "      -o [url]    给定URL输出TOP 100访问来源主机"
  echo "      -h          查看帮助文档"
}

function Operate
{
  case $1 in
    1) sed -n '2, $ p' web_log.tsv | awk -F '\t' '{a[$1]++} END{for(i in a) {print (i,a[i])}}' | sort -nr -k2 | head -n 100
       ;;
    2) sed -n '2, $ p' web_log.tsv | awk '{if ($1~/^([0-2]*[0-9]*[0-9])\.([0-2]*[0-9]*[0-9])\.([0-2]*[0-9]*[0-9])\.([0-2]*[0-9]*[0-9])$/){print $1}}' | awk -F '\t' '{a[$1]++} END{for(i in a) {print (i,a[i])}}' | sort -nr -k2 | head -n 100
       ;;
    3) sed -n '2, $ p' web_log.tsv | awk -F '\t' '{a[$5]++} END{for(i in a) {print (i,a[i])}}' | sort -nr -k2 | head -n 100
       ;;
    4) sed -n '2, $ p' web_log.tsv | awk -F '\t' 'BEGIN{ans=0}{a[$6]++;ans++} END{for(i in a) {printf ("%-5s %-8d %.3f%\n",i,a[i],a[i]*100/ans)}}'
       ;;
    5) sed -n '2, $ p' web_log.tsv | awk -F '\t' '{if($6~/^4+[0-9]*[0-9]$/) {a[$5]++}} END{for (i in a) {print i,a[i]}}' | sort -nr -k2 | head -n 10
       ;;
    6) sed -n '2, $ p' web_log.tsv | awk -F '\t' '{if($5=="'$2'") {a[$1]++}} END{for (i in a) {print i,a[i]}}' | sort -nr -k2 | head -n 100
       ;;
     esac
}

function main
{
  ans=0
  var=($*)

  if [ ${#var[@]} -ge 1 ];then
    for j in "${var[@]}";
    do
      case $j in
        "-o") ans=$((ans+1))
              Operate 6 "${var["$ans"]}"
              ;;
        "-s") Operate 1
              ;;
        "-i") Operate 2
              ;;
        "-u") Operate 3
              ;;
        "-c") Operate 4
              ;;
        "-e") Operate 5
              ;;
        "-h") HELP
              ;;
            esac
    ans=$((ans+1))
    done
  else
    HELP
  fi
}

main $1 $2 $3 $4 $5 $6 $7

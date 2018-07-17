#!/bin/bash

function HELP
{
  echo "usage:[-i][-q|-c|-w|-n|-r]"
  echo "      -q [quality]    Compress quality on jpeg (eg. '-q 40')"
  echo "      -c [percent]    Compress images by giving percent (eg. '-q 50%')"
  echo "      -w [text]       Add watermark to the pictures (eg. '-w haha')"
  echo "      -n [text]       Add text before the original name (eg. '-n haha'--If original name is pic.png, then it'll be haha_pic.png)"
  echo "      -r [name]       Change png/svg to jpg and rename it(eg. '-r haha'--If original name is pic.png, then it'll be pic_haha.jpg)"
  echo "      -i [input]      Directory(eg. '-i workplace/')"
}

function Operate
{
  if [ $# != 4 ];then
    HELP
    exit 1
  fi
  echo $3$4":"
  case $1 in
    1) if [[ "$(file --mime-type -b $3$4)" == "image/jpeg" ]];
       then
         $(convert $3$4 -quality $2 QualityCompress_$4)
         if [ $? == 0 ];then
           echo "Successful"
         else
           echo "Unsuccessful"
         fi
       else
         echo "Format error"
       fi
       ;;
    2) if [[ "$(file --mime-type -b "$3$4")" == "image/jpeg" || "$(file --mime-type -b "$3$4")" == "image/png" || "$(file --mime-type -b "$3$4")" == "image/svg+xml" ]];
       then
         $(convert $3$4 -resize $2 "Compress"$4)
         if [ $? == 0 ];then
           echo "Successful"
         else
           echo "Unsuccessful"
         fi
       else
         echo "Format error"
       fi
       ;;
    3) if [[ $(file --mime-type -b "$3$4") == "image/jpeg" || $(file --mime-type -b "$3$4") == "image/png" ]];
       then
         $(mogrify -gravity SouthEast -fill yellow -draw 'text 4,5 '$2'' $3$4)
         if [ $? == 0 ];then
           echo "Successful"
         else
           echo "Unsuccessful"
         fi
       else
         echo "Format error"
       fi
       ;;
    4) $(mv "$3$4" "$3$2_$4")
       if [ $? == 0 ];then
         echo "Successful"
       else echo "Format error"
       fi
       ;;
    5) if [[ $(file --mime-type -b "$3$4") == "image/svg+xml" || $(file --mime-type -b "$3$4") == "image/png" ]];
       then
         $(convert $3$4 "$3${4%.*}$2.jpg")
         if [ $? == 0 ];then
           echo "Successful"
         else
           echo "Unsuccessful"
         fi
       else
         echo "Format error"
       fi
       ;;
     esac
}

function main
{
  if [ $# == 4 ];then
    if [ $1 == "-i" ];
    then
      img=($(ls $2))
      for j in ${img[@]};
      do
        case $3 in
          -q) Operate 1 $4 $2 $j;;
          -c) Operate 2 $4 $2 $j;;
          -w) Operate 3 $4 $2 $j;;
          -n) Operate 4 $4 $2 $j;;
          -r) Operate 5 $4 $2 $j;;
        esac
      done
    fi
  else
    HELP
  fi
}

main $1 $2 $3 $4

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
  if [ $# != 3 ];then
    HELP
    exit 1
  fi
  case $1 in
    1) if [ $(file --mime-type -b "$3") == "image/jpge" ];
       then
         $(convert -quality $2 $3 "QualityCompress"$3)
         if [ $? == 0 ];then
           echo "Successful"
         else
           echo "Unsuccessful"
         fi
       else
         echo "Format error"
       fi
       ;;
    2) if [[ $(file --mime-type -b "$3") == "image/jpge" || $(file --mime-type -b "$3") == "image/png" || $(file --mime-type -b "$3") == "image/svg+xml"] ];
       then
         $(convert $3 -resize $2 "Compress"$3)
         if [ $? == 0 ];then
           echo "Successful"
         else
           echo "Unsuccessful"
         fi
       else
         echo "Format error"
       fi
       ;;
    3) if [ $(file --mime-type -b "$3") == "image/jpge" || $(file --mime-type -b "$3") == "image/png" ];
       then
         $(mogrify -gravity SouthEast -fill black -draw 'text 0,0 '$2'' $3)
         if [ $? == 0 ];then
           echo "Successful"
         else
           echo "Unsuccessful"
         fi
       else
         echo "Format error"
       fi
       ;;
    4) $(mv "$3" "$2_$3")
       if [ $? == 0 ];then
         echo "Successful"
       else echo "Format error"
       fi
       ;;
    5) if [[ $(file --mime-type -b "$3") == "image/svg+xml" ||$(file --mime-type -b "$3") == "image/png" ]];
       then
         $(convert $3 "${3%.*}$2.jpg")
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
  input=("-q" "-c" "-w" "-n" "-r")
  directory=""

  if [ $# == 4 ];then
    if [ $1 == "-i" ];then
      directory=$2
      num=1
      for i in ${input[@]};
      do
        if [ $3 == $i ];then
          for file in $(ls $directory);
          do
            Operate $num $4 $file
          done
        fi
        num=$((num+1))
      done
    fi
  else
    HELP
  fi
}

main $1 $2 $3 $4

#! /bin/bash


allMails=allMails.txt

touch $allMails

OIFS="$IFS"
IFS=$'\n'
for file in `find . -type f -name "m*"`  
do
    while read key; do

       IFS=' ' read -r -a emailArray <<< $key
        for email in "${emailArray[@]}"    
        do  
            if [[ $email == *"@"* && $email != *"telenity"* && $email != "@"* && $email == "<"* && $email != *".prod."* &&  $email != *".PROD."* && $email != *".jpg"* && $email != *".pdf"* && $email != *".docx"* && $email != *".jpeg"* && $email != *".csv"* && $email !=  *".xslx"* && $email != *".png"* && $email != *"&"* && $email != *"="* ]]; then
            	email=${email:1}
           
              email=$(echo "$email" | sed 's/<.*//')
              email=$(echo "$email" | sed 's/>.*//')
              
              if [[ $email == *"mailto:"* ]]; then
              email=${email#*:}
              fi
              
            	length=`expr "$email" : '.*'`
               
               if [[ $length < 40 && $email == *"@"* ]]; then
                	echo $email
                	echo $email >> $allMails
               
                fi
              
              
              
	      fi
		

        done

    done  < $file

done
IFS="$OIFS"

sort $allMails | uniq  > Mails.txt
sed 's/ \+/,/g' Mails.txt > Mails.csv
rm -r  $allMails

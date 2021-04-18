#! /bin/bash

var1=`find $1 -type f -name "*" 2>/dev/null`  # variable that stores found files (unless the second parametr was entered)
var2=`find $1 -type f -name "$2" 2>/dev/null` # variable that stores found files (if second parametr was entered)

clear
########################## No parametrs ####################################

if   [ "$1" == "$NULL" ]; then # if first parametr doesn't exist
	echo -e "\e[41mYou did not enter parametrs!\e[0m\n"
	echo -e "Directory: \e[31mnot set\e[0m \nTemplate: \e[35mnot set\e[0m\n\n" # display the directory name and the template that the user entered
	echo -e  "Correct input should be like this:\n"
	echo -e '\e[33m<scriptName> <directoryName>  ["searchTemplate"]\e[0m\n'

########################## One parametr #####################################

elif [ "$2" == "$NULL" ]; then # if second parametr doesn't exist
	echo -e "Directory: \e[32m$1\e[0m \nTemplate: \e[35mnot set\e[0m\n"

	if ! [ -d "$1" ];  then # if the directory does not exist
		echo -e  "\e[31mNo such directory!\e[0m"
	elif ! [ -r "$1" ]; then   # if there is no permission to read the directory, then we inform about it
		echo -e "\e[31mNo rights to this directory!\e[0m"

	else
		numbers=`find $1 -type f -name "*" 2>>/dev/null | wc -l` # the variable stores the number of found files
		echo -e "\e[34mFiles found:\e[0m \e[32m$numbers\e[0m\n"
		echo -e "\n\e[36m--------------------------------------------------------\e[0m\n"

for items in $var1
do
  if ! [ -r $items ]
  then   echo -e "\e[31mNo rights to the file $items\e[0m"
	 echo -e "\n\e[36m--------------------------------------------------------\e[0m\n"

  else
name=`find $items -printf "%f\n"` # display only the name of the files
path=`realpath -e $items` # full path to the files
type=`file $items | cut -d" " -f2`  # file type (cut out the second field, to display only the file type)
size=`wc -c $items | cut -d" " -f1`  # file size in bytes
md5=`md5sum $items | cut -d" " -f1` # hash MD5
	echo -e "\e[33mFile name:\e[0m $name"
	echo -e "\e[33mFull path:\e[0m $path"
	echo -e "\e[33mFile type:\e[0m $type"
	echo -e "\e[33mFile size:\e[0m $size bytes"
	echo -e "\e[33mHash MD5:\e[0m  $md5"
	echo -e "\n\e[36m--------------------------------------------------------\e[0m\n"
  fi
done

fi

######################### Two parametrs ####################################

else
	echo -e "Directory: \e[32m$1\e[0m \nTemplate: \e[32m$2\e[0m\n"

	if ! [ -d "$1" ]; then
		echo -e  "\e[31mNo such directory\e[0m"
	elif ! [ -r "$1" ]; then
		echo -e "\e[31mNo rights to this directory!\e[0m"

	elif ! [ "$var2" ]; then # if no files were found with given template
        echo -e "\e[31mNo files with this template\e[0m"


	else
		numbers=`find $1 -type f -name "$2" 2>>/dev/null | wc -l`
		echo -e "\e[34mFiles found:\e[0m \e[32m$numbers\e[0m\n"
		echo -e "\n\e[36m--------------------------------------------------------\e[0m\n"

for items in $var2
do
  if ! [ -r $items ]
  then   echo -e "\e[31mNo rights to the file $items\e[0m"
         echo -e "\n\e[36m--------------------------------------------------------\e[0m\n"

  else
name=`find $items -printf "%f\n"`
path=`realpath -e $items`
type=`file $items | cut -d" " -f2`
size=`wc -c $items | cut -d" " -f1`
md5=`md5sum $items | cut -d" " -f1`
        echo -e "\e[33mFile name:\e[0m $name"
        echo -e "\e[33mFull path:\e[0m $path"
        echo -e "\e[33mFile type:\e[0m $type"
        echo -e "\e[33mFile size:\e[0m $size байт"
        echo -e "\e[33mHash MD5:\e[0m  $md5"
        echo -e "\n\e[36m--------------------------------------------------------\e[0m\n"
  fi
done

	fi
fi

echo ""

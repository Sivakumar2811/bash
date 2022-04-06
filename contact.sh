#!/bin/bash

echo -e "Contact Mangement\n"
s=y

while [[ $s == y || $s == Y ]]
do
	echo "1.Add Contact"
    echo "2.Search Contact"
    echo "3.Delete Contact"
    echo "4.Print Register"

    read -p "Enter the option :" n
    case $n in
    	1)
            echo
            echo "Add contact"
            read -p  "Name :" name
            read -p "Number :" number

            if ! [[ `echo $number | grep "^[0-9]*$"` ]]
            then
        	    echo "invalid number so please re-enter"
        	    read -p "Number :" number
            fi

            if [[ `awk '{print $2}' contacts.txt | grep -i "$name"` ]]
            then
            	change=`grep -i "$name" contacts.txt` 
        	    sed -i "s/$change/Name: $name Number: $number/" contacts.txt
            else
        	    echo "Name: $name Number: $number" >> contacts.txt
        	    echo "Successfully add contact"
            fi
            ;;
        2)
            echo
            echo "Search contact"
            echo "1.Name"
            echo "2.Number"
            echo
            read -p "Enter the option :" n1
            case $n1 in
        	    1)
                    echo
                    read -p "Enter the Name :" name

                    if [[ `awk '{print $2}' contacts.txt | grep -i "^$name"` ]]
                    then
                    	echo hai
        	            awk '{ if (tolower($2) ~ "^'$name'") print $0;}' contacts.txt | sort -k 2
                    else
        	            echo "No contacts in this $name"
                    fi
                    ;;
                2)
                    echo
                    read -p "Enter the Number :" number

                    if ! [[ `echo $number | grep "^[0-9]*$"` ]]
                    then
        	            echo "invalid number so please re-enter"
        	            read -p "Number :" number
                    fi

                    if [[ `awk '{print $4}' contacts.txt | grep -i "^$number"` ]]
                    then
        	            awk '{ if (tolower($4) ~ "^'$number'") print $0;}' contacts.txt | sort -k 2
                    else
        	            echo "No contacts in this $number"
                    fi
                    ;;
                    *)
                    echo "Option is invalid"
                    ;;
            esac
            ;;
        3)
            echo
            echo "Delete contact"
            read -p "Enter the input :" name

            if ! [[ `echo $name | grep -i "^[a-z]*$"` ]]
            then
        	    echo "invalid input so please re-enter correct name only"
        	    read -p "Enter the input :" name
            fi

            if  [[ `awk '{print $2}' contacts.txt | grep -iw "$name"` ]]
            then
        	    sed -i "/$name/Id" contacts.txt
            else
        	    echo "Contact is invalid"
            fi
            ;;
        4)
            echo
            echo "print contact details"
            sort -k 2 contacts.txt 
            ;;
        *)
            echo "Option is invalid"
            ;;
    esac

    echo 
    read -p "If you want to continue y or n :" s
done
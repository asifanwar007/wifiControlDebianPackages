#!/bin/bash
echo "Running script"
declare -i limit=$(zenity --entry --text="Set Limit in Mb" --entry-text="50")
sleep 1
usage=1
before_point_data=$( vnstat | tail -n -2 | cut -c  47-51)
check=$(vnstat | tail -n -2 | cut -c  53)
# echo "check: $check"
if [[ $check -eq 0 ]]; then
	after_point_data=$( vnstat | tail -n -2 | cut -c  54-55)
else
	after_point_data=$( vnstat | tail -n -2 | cut -c  53-55)
fi
char=$(vnstat | tail -n -2 | cut -c 56-57)
# echo "char: $char"
if [[ $char=='Gi' ]] 
then
	#statements
	# echo $char
	diff_data=$(($before_point_data*1024 + $after_point_data*10))
	# echo "here: $diff_data"
else
	diff_data=$(($before_point_data))
	# echo "h: diff_data"
fi
# echo "diff_data: $diff_data limit: $limit"
# echo "after_point_data: $after_point_data before_point_data: $before_point_data"
#dchar=$(vnstat | tail -n -2 | cut -c 40-41)

#while [$usage -lt 50]; do
while (( $(echo "$usage <  $limit" |bc -l) )); do
	before_point_now=$( vnstat | tail -n -2 | cut -c  47-51)
	check=$(vnstat | tail -n -2 | cut -c  53)
	if [[ $check -eq 0 ]]; then
		after_point_now=$( vnstat | tail -n -2 | cut -c  54-55)
	else
		after_point_now=$( vnstat | tail -n -2 | cut -c  53-55)
	fi
	# after_point_now=$( vnstat | tail -n -2 | cut -c  53-55)
	char_now=$(vnstat | tail -n -2 | cut -c 56-57)
	if [[ $char_now=="Gi" ]]; then
		#statements
		diff_now=$(($before_point_now*1024 + $after_point_now*10))
	else
		diff_now=$(($before_point_now))
	fi
	usage=$(($diff_now - $diff_data + 1))
done
#echo 'message:50 mb data used reached' | zenity --question --text="message:50 mb data used reached"
if zenity --question --text="50 mb data used reached\nwould u like to continue?" --ellipsize
    then
        # nmcli c up id "netflix&chill"
        echo "Still connecting"
    else
        nmcli c down id "Netflix&Chill"
fi
echo "$usage"
#use up for again activate connection
echo 'Thank You'
#if (( $(echo "$d-$v <  50" |bc -l) ));
#if [echo $d-$v '<' 50 | bc -l] 
#    then
#        $(bash wifiusage.sh )
#    else
#        $(echo 'message:50 mb data used reached' | zenity --notification --listen)
#    fi

#for as in $(vnstat)
#    do
#        echo "$as"
#    done

#echo "data used: $data"

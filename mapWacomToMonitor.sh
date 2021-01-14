input=$(xsetwacom --list devices | sed 's/.*id: //' | sed 's/type.*//')
output=$(xrandr --query | grep ' connected' | sed 's/connected.*//')
declare c=0
for i in $output
	do
		c=$(($c+1))
		#options=$( $(echo $options) $(echo $c $i "off") )
		options=$(echo $options $c $i "off")
	done
echo $options
map=$( dialog --title "Display Map" --radiolist "Select display to map Wacom tablet to" 0 0 3 $options --output-fd 1)
clear
output=$( echo $output | cut -d " " -f $map )
for i in $input
	do
		xinput map-to-output $i $output
	done

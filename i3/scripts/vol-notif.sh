#close all notifications with dunst, change this to an apropriate command if using a different notif daemon
dunstctl close-all

volume=$(amixer -D pulse get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1)
muted=$(amixer -D pulse get Master | grep '%' | head -n 1 | cut -d ']' -f 2 | cut -d '[' -f 2)

#imma leave these lines in cause there useful for debugging sometimes
#echo $volume
echo $muted

bar=$(seq -s "─" $(($volume / 5)) | sed 's/[0-9]//g')
if [[ $muted = "off" ]]; then
 #use the muted icon
 notify-send "muted" -i "/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-muted.svg"
elif [[ $volume > "20" ]]; then
 #use the high volume icon
 notify-send "$volume  $bar" -i "/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-high.svg"
else
 #use the low volume icon
 notify-send "$volume  $bar" -i "/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-low.svg"
fi

#sleep 5 &
#xrandr --addmode VGA-1 1600x900 &
#xrandr --output HDMI-1 --primary --mode 1920x1080 --output VGA-1 --mode 1600x900 --pos 1920x180 &

exec ./monitores.sh &
exec picom -f &
exec udiskie -a &
#exec pulseaudio --daemonize=no --exit-idle-time=-1 &
exec dbus-launch --sh-syntax &
exec /home/woolean/dwmscripts/dwmbar &
exec setxkbmap es &

# Evitar que se apague la pantalla despues de 10 minutos (?)
exec xset dpms 0 0 0 &
exec xset s reset &
exec xset s off & # Disables screen saver
exec xset -dpms & # Disables Energy Star features

feh --bg-fill /home/woolean/Imágenes/Wallpapers/Actuales/1.jpg /home/woolean/Imágenes/Wallpapers/Actuales/2.jpg &

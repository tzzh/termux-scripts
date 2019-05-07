# basic script to backup phone pictures via rsync if connected to a wifi and send a notification once done
# the script can then scheduled to eg run nightly
# BACKUP_DIR needs to be set eg user@machine:/something/something

set -u
FAILED_TITLE="Backup Failed"

if termux-wifi-connectioninfo | jq -e .bssid ; then
    rsync -av /sdcard/DCIM/Camera/ "$BACKUP_DIR"/Camera && 
    rsync -av /sdcard/WhatsApp/Media/WhatsApp\ Images/ "$BACKUP_DIR"/Whatsapp && 
    termux-notification --content "Backup Successful" ||
    termux-notification --title "$FAILED_TITLE" --content "rsync failed";
else
    termux-notification --title "$FAILED_TITLE" --content "Not connected to a wifi";
fi

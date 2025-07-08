SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
source "$PROJECT_ROOT/config/config.env"

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

LOG_FILE="$PROJECT_ROOT/logs/disk_monitor.log"

check_disk_usage() {
  ALERT_TRIGGERED=0
  ALERT_MESSAGE="Disk Usage Alert - $TIMESTAMP\n\n"

  
  echo "Filesystem      Size  Used Avail Use% Mounted on
  /dev/fake         100G   95G   5G   95% /fake" | awk 'NR>1' | while read -r line; do

  usage_percent=$(echo "$line" | awk '{print $5}' | tr -d '%')
    mount_point=$(echo "$line" | awk '{print $6}')

    if [ "$usage_percent" -ge "$THRESHOLD_PERCENT" ]; then
      ALERT_TRIGGERED=1
      ALERT_MESSAGE+="Mount Point: $mount_point\nUsage: $usage_percent%\n\n"
    fi
  done 

  if [ "$ALERT_TRIGGERED" -eq 1 ]; then
    echo -e "$ALERT_MESSAGE" | mail -s "⚠️ Disk Usage Alert" "$EMAIL_RECIPIENT"
    echo "$TIMESTAMP - ALERT sent to $EMAIL_RECIPIENT" >> "$LOG_FILE"
  else
    echo "$TIMESTAMP - All usage within limits." >> "$LOG_FILE"
  fi
}

check_disk_usage

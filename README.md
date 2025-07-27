# 🧠 Disk Usage Monitor

A simple Bash script to check disk usage on `/`, log the results, and send email alerts when usage exceeds a given threshold.

---

## 🚀 Features

- ✅ Checks all mounted partitions with `df`
- ✅ Sends email alerts using `msmtp`
- ✅ Customizable threshold and recipient via `.env`
- ✅ Logs every run to `logs/disk_monitor.log`
- ✅ Includes `--test` flag to simulate high usage
- ✅ Cron-compatible

---

## 📁 Project Structure
```
disk-usage-monitor/
├── bin/
│   └── monitor.sh
├── config/
│   └── config.env.example
├── logs/
│   └── .gitkeep  
├── .gitignore
├── README.md
└── cronjob.txt  
```
## ⚙️ Setup

1. **Clone the repo**  
   ```bash
   git clone https://github.com/ghostoptimizer/disk-usage-monitor.git
   cd disk-usage-monitor

   Copy & edit config
   ------------------
   - cp config/config.env.example config/config.env

   Then in config/config.env set:

   THRESHOLD=80
   EMAIL="your.email@example.com"
   LOG_FILE="/full/path/to/disk-usage-monitor/logs/disk_monitor.log"

   Install Dependencies:
   ---------------------
    •	Bash (macOS/Linux)
	•	msmtp (for sending mail)
	•	cron (for scheduling)

    Configure msmtp
    ---------------

    First create ~/.msmtprc with you SMTP settings and:
    chmod 600 ~/.msmtprc

    Make it executable:
    chmod +x bin/monitor.sh


   Running Manually

   ./bin/monitor.sh
   tail -n5 logs/disk_monitor.log

   Automated (Cron):
   Paste the line from cronjob.txt into crontab -e:

   */30 * * * * /full/path/to/bin/monitor.sh

```
📬 Alerting

When disk usage ≥ THRESHOLD, the script logs an alert and sends an email via msmtp.

📝 .gitignore
--------------
logs/
config/config.env
.DS_Store
```

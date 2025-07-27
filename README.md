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

## ⚙️ Setup

1. **Clone the repo**  
   ```bash
   git clone https://github.com/ghostoptimizer/disk-usage-monitor.git
   cd disk-usage-monitor

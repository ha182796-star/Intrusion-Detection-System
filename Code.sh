#!/bin/bash
# Intrusion Detection System
# Developed by: Hasnain Ali

# Single log file where everything gets stored
LOG_FILE="ids_log.txt"

while true
do
    clear

    # Time and timeframe details
    NOW=$(date)
    HOUR=$(date +%H:00)
    DAY=$(date +%Y-%m-%d)
    MONTH=$(date +%Y-%m)

    # 1. Collect security data into simple variables
    FAILED=$(journalctl -g "Failed password" -n 10 2>/dev/null)
    RECENT=$(last | head -n 10)
    PORTS=$(sudo ss -tulpn | grep LISTEN)
    PROCESSES=$(ps aux | head -n 10)
    CHANGED=$(find /etc -type f -mtime -1 2>/dev/null | head -n 10)

    # 2. Display on screen
    echo "=================================================="
    echo "          SIMPLE INTRUSION DETECTION             "
    echo "=================================================="
    echo "Time:     $NOW"
    echo "Log File: $LOG_FILE"
    echo "=================================================="
    echo
    echo "[1] Failed Login Attempts:"
    echo "$FAILED"
    echo
    echo "[2] Recent Logins:"
    echo "$RECENT"
    echo
    echo "[3] Open Network Ports:"
    echo "$PORTS"
    echo
    echo "[4] Top Running Processes:"
    echo "$PROCESSES"
    echo
    echo "[5] Changed Files in /etc:"
    echo "$CHANGED"

    # 3. Save timeframe details and full output into single log file
    echo "==================================================" >> "$LOG_FILE"
    echo "TIMEFRAME: [MONTH: \(MONTH | DAY:\)DAY | HOUR: \(HOUR]" >> "\)LOG_FILE"
    echo "RECORDED : \(NOW" >> "\)LOG_FILE"
    echo "==================================================" >> "$LOG_FILE"
    echo >> "$LOG_FILE"
    echo "[1] Failed Logins:" >> "$LOG_FILE"
    echo "\(FAILED" >> "\)LOG_FILE"
    echo >> "$LOG_FILE"
    echo "[2] Recent Logins:" >> "$LOG_FILE"
    echo "\(RECENT" >> "\)LOG_FILE"
    echo >> "$LOG_FILE"
    echo "[3] Open Network Ports:" >> "$LOG_FILE"
    echo "\(PORTS" >> "\)LOG_FILE"
    echo >> "$LOG_FILE"
    echo "[4] Top Running Processes:" >> "$LOG_FILE"
    echo "\(PROCESSES" >> "\)LOG_FILE"
    echo >> "$LOG_FILE"
    echo "[5] Changed Files in /etc:" >> "$LOG_FILE"
    echo "\(CHANGED" >> "\)LOG_FILE"
    echo "==================================================" >> "$LOG_FILE"
    echo >> "$LOG_FILE"

    echo
    echo "=================================================="
    echo "Refreshing in 5 seconds... (Press Ctrl + C to stop)"
    sleep 5
done

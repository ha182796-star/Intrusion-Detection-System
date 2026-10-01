Intrusion Detection System (IDS): Security Monitoring Tool

**Program:** GLAXIT Internship Program — Advanced Cyber Security

**Developed By:** Hasnain Ali 

**Environment:** Kali Linux (Bash Shell Scripting)

**Date:** August 23, 2026

**Submitted To:** Sir Saifullah  
1. IntroductionThis project presents a lightweight Intrusion Detection System (IDS) built entirely using Bash shell scripting on Kali Linux. The tool continuously monitors a system for signs of unauthorized access or suspicious activity, displaying findings in a live, auto-refreshing terminal dashboard while simultaneously logging every scan cycle to a persistent text file (ids_log.txt) for auditing.
2.  ObjectivesDetect and report failed login attempts on the host system.   Track recent and active user login sessions.   Identify open network ports that may indicate unauthorized services.   Monitor top running processes for unusual resource consumption or activity.   Detect recently modified configuration files under the /etc directory.   Present all findings on-screen in real time while persisting records in a single log file.
3.   Tools & EnvironmentOperating System: Kali Linux   Scripting Language: Bash   Text Editor: GNU nano   Core CLI Utilities: journalctl, last, ss, ps, find, date, clear, sleep   4. Script Architecture (ids4.sh)The script executes an infinite loop that refreshes every 5 seconds, collecting live security data, displaying it on the screen, and appending the results to ids_log.txt.   Bash#!/bin/bash
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
   5. Security Inspection Modules & Dashboard Findings
   5.1 Failed Login AttemptsCommand Used: journalctl -g "Failed password" -n 10   
   Objective: Queries systemd journal logs for failed password attempts and authentication failures.   
   Observed Data: Captured timestamps, process IDs, and pseudo-terminal IDs (tty/pts/2) associated with recent failed sudo attempts.  
   5.2 Recent LoginsCommand Used: last | head -n 10   
   
   Objective: Audits session histories for interactive user logins, terminal locations (tty7), and session durations.
   
   Observed Data: Tracked active and past sessions for default user kali and display manager lightdm.  
   
   5.3 Open Network PortsCommand Used: sudo ss -tulpn | grep LISTEN  
   
   Objective: Enumerates active listening TCP/UDP sockets to identify running daemons and exposed entry points.  
   Observed Data: Identified a single active TCP socket listening on loopback 127.0.0.1:36767 bound to containerd (PID 1116).  
   5.4 Top Running ProcessesCommand Used: ps aux | head -n 10   Objective: Monitors process trees sorted by resource usage (%CPU and %MEM).  
   Observed Data: Showed standard core system daemons (/sbin/init splash) and kernel threads (kworker, kthreadd). 
   5.5 Changed Files in /etcCommand Used: find /etc -type f -mtime -1  
   
   Objective: Detects unauthorized configuration edits by flagging files modified within the past 24 hours. 
   
   Observed Data: Flagged recent modification activity on /etc/resolv.conf. 
   
   6. Conclusion This project demonstrates that a functional, lightweight security monitoring tool can be constructed using native Linux system commands and Bash shell scripting. By aggregating journalctl, last, ss, ps, and find, ids4.sh provides continuous operational security visibility on-screen while writing persistent audit records to ids_log.txt.

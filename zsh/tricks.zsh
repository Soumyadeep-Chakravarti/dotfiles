##################################
# Busywork: Fun + Functional Shell Utility
##################################

busywork() {
    local scenarios=(
        "Monitoring top CPU & memory processes..."
        "Scanning system logs for warnings/errors..."
        "Showing disk and memory usage trends..."
        "Simulating lightweight backup of ~/inference_engine..."
        "Running resource stats comparison..."
    )

    local commands=(
        # 1. Monitor top CPU & Memory
        'while true; do
            echo -e "\n$(date) — Top CPU processes:"
            ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
            echo -e "\n$(date) — Top Memory processes:"
            ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
            sleep 5
        done'

        # 2. Scan system logs
        'while true; do
            echo -e "\n$(date) — Recent Errors/Warnings:"
            grep -Ei "error|fail|warn" /var/log/syslog /var/log/auth.log 2>/dev/null | tail -n 10
            sleep 5
        done'

        # 3. Disk & memory trends
        'while true; do
            echo -e "\n$(date) — Disk usage:"
            df -h | grep -v tmpfs
            echo -e "\n$(date) — Memory usage:"
            free -h
            sleep 5
        done'

        # 4. Lightweight backup simulation
        'while true; do
            echo -e "\n$(date) — Simulating backup of ~/inference_engine..."
            mkdir -p ~/inference_engine_backup
            rsync -ah --info=progress2 --dry-run ~/inference_engine/ ~/inference_engine_backup/
            echo "$(date) — Dry-run backup complete."
            sleep 10
        done'

        # 5. System stats
        'while true; do
            echo -e "\n$(date) — CPU Load:"
            mpstat -P ALL 1 1
            echo -e "\n$(date) — Top 5 processes by CPU:"
            ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
            sleep 5
        done'
    )

    local index=$((RANDOM % ${#commands[@]}))
    local desc="${scenarios[$index]}"
    local cmd="${commands[$index]}"

    echo -e "\033[0;32m$desc\033[0m"
    eval "$cmd"
}

alias abusy="busywork"


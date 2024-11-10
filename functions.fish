function mkcd
    mkdir -p $argv[1]
    cd $argv[1]
end

function countdown
    set date1 (math (date +%s) + $argv[1] \* 60)
    while test $date1 -ge (date +%s)
        printf "\r%s" (date -u --date @(math $date1 - (date +%s)) +%H:%M:%S)
        sleep 0.1
    end
    notify-send "Timer finished"
end

function stopwatch
    set date1 (date +%s)
    while true
        printf "\r%s" (date -u --date @(math (date +%s) - $date1) +%H:%M:%S)
        sleep 0.1
    end
end

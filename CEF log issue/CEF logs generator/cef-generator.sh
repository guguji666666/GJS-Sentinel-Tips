# !/bin/bash

# CEF Log Test Commands (Different Facilities and Levels)

# List commands for all facilities and log levels
for facility in {1..20}; do
    case $facility in
        1) fac="ALERT";;
        2) fac="AUDIT";;
        3) fac="AUTH";;
        4) fac="AUTHPRIV";;
        5) fac="CRON";;
        6) fac="DAEMON";;
        7) fac="USER";;
        8) fac="SYSLOG";;
        9) fac="PRINT";;
        10) fac="NEWS";;
        11) fac="UUCP";;
        12) fac="NTP";;
        13) fac="AUDIT_MAIL";;
        14) fac="CONSOLE";;
        15) fac="RPCAUTH";;
        16) fac="AUTISM";;
        17) fac="KERN";;
        18) fac="LPR";;
        19) fac="MAIL";;
        20) fac="NEWS";;
    esac

    for level in {0..6}; do
        case $level in
            0) lev="Debug";;
            1) lev="Info";;
            2) lev="Notice";;
            3) lev="Warning";;
            4) lev="Error";;
            5) lev="Critical";;
            6) lev="Alert";;
        esac

        echo "<164>CEF:0|Mock-$fac-$lev     |$fac" \
                "|common=event-format-test|end|TRAFFIC|1|rt=$fac-$lev|" \
                "proto=TCP|src_ip=192.168.1.100|dst_ip=8.8.8.8|" \
                "user_id=12345|event_type=connection-establishment|" \
                "event_data='Connection established from 192.168.1.100 to 8.8.8.8'|" \
                "|device_id=my-device|os=Linux|x86_64" | nc -u -w3 localhost 514
    done
done

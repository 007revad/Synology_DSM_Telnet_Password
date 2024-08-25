#!/bin/bash
#----------------------------------------------------------------------------
# Default DSM telnet password used to be blank.
#
# Generate DSM telnet 'password of the day' if 101-0101 does not work.
#
# https://blog.thomasmarcussen.com/synology-nas-recovery-password-telnet/
# 
# In case you don't want to contact Synology here is how it's generated
# 
# 1st char = month in hexadecimal, lower case (1=Jan, … , a=Oct, b=Nov, c=Dec)
# 2-3 = month in decimal, zero padded and starting in 1 (01, 02, 03, …, 11, 12)
# 4 = dash
# 5-6 = day of the month in hex (01, 02 .., 0A, .., 1F)
# 7-8 = greatest common divisor between month and day, zero padded. This is always a number between 01 and 12.
#
# If today is Oct 15, the password would be: a10-0f05
#    a = month in hex
#   10 = month in decimal
#   0f = day in hex
#   05 = greatest divisor between 10 and 15
#
# https://servicemax.com.au/tips/synology-recovery-mode-telnet/
# https://github.com/adamphetamine/synology/blob/main/telnet-password
#----------------------------------------------------------------------------

script="Synology_DSM_Telnet_Password"
scriptver="1.0.2"
repo="007revad/Synology_DSM_Telnet_Password"

usage(){ 
    cat <<EOF
$script $scriptver - by 007revad

Usage: $(basename "$0") [options]

Options:
      --day=      Set the day to calculate password from
                  If --day= is used you must also use --month=
                  Day must be numeric. e.g. --day=24
      --month=    Set the month to calculate password from
                  If --month= is used you must also use --day=
                  Month must be numeric. e.g. --month=09
  -h, --help      Show this help message
  -v, --version   Show the script version

EOF
    exit 0
}


scriptversion(){ 
    cat <<EOF
$script $scriptver - by 007revad

See https://github.com/$repo
EOF
    exit 0
}


# Save options used
args=("$@")


# Check for flags with getopt
if options="$(getopt -o abcdefghijklmnopqrstuvwxyz0123456789 -l \
    day:,month:,help,version --  "${args[@]}")"; then
    eval set -- "$options"
    while true; do
        case "${1,,}" in
            -h|--help)          # Show usage options
                usage
                ;;
            -v|--version)       # Show script version
                scriptversion
                ;;
            -d|--day)              # Set day variable
                if [[ $2 =~ ^0[1-9]?$ ]]; then
                    # Day is 01 to 09
                    day="${2#?}"
                    shift
                elif [[ $2 =~ ^[1-3][0-9]?$ ]]; then
                    # Day is 1 to 31
                    day="$2"
                    shift
                fi
                ;;
            -m|--month)            # Set month variable
                if [[ $2 =~ ^0[1-9]?$ ]]; then
                    # Month is 01 to 09
                    month="${2#?}"
                    shift
                elif [[ $2 =~ ^[1-9][0-9]?$ ]]; then
                    # Month is 1 to 12
                    month="$2"
                    shift
                fi
                ;;
            --)
                shift
                break
                ;;
            *)                  # Show usage options
                echo -e "Invalid option '$1'\n"
                usage "$1"
                ;;
        esac
        shift
    done
else
    echo
    usage
fi


# Show script name and version
echo -e "$script $scriptver - by 007revad \n"


if [[ -z $month ]] && [[ -z $day ]]; then
    # Get current month and day
    month=$(date +%-m) # Month (1 to 12)
    day=$(date +%-d) # Day of the month (1 to 31)

    echo "Today's Day:   $day"
    echo -e "Today's Month: $month \n"
else
    echo "Day:   $day"
    echo -e "Month: $month \n"
fi

# Validate day and month
if [[ ! $day -gt "0" ]] || [[ ! $day -lt "32" ]]; then
    echo "Day is invalid!" && exit
elif [[ ! $month -gt "0" ]] || [[ ! $month -lt "13" ]]; then
    echo "Month is invalid!" && exit
fi

# Function to calculate greatest common divisor in Bash
gcd(){ 
    # $1 decimal month as decimal
    # $2 decimal day as decimal
    if [[ $2 -eq 0 ]]; then
        echo "$1"
    else
        gcd "$2" $(($1 % $2))
    fi
}

# Calculate greatest common divisor between month and day
gcd_result=$(gcd "$month" "$day")

# Format and print the password
printf "DSM Telnet Password for today is: %x%02d-%02x%02d\n\n" "$month" "$month" "$day" "$gcd_result"


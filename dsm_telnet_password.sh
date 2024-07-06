#!/bin/bash
#
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

# Get current month and day
month=$(date +%m) # Month (01 to 12)
day=$(date +%d) # Day of the month (01 to 31)

echo "Today's Day:   $day"
echo -e "Today's Month: $month \n"

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


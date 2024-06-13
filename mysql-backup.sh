#!/bin/sh

excludes=' information_schema mysql performance_schema sys test '

for DB in $(mysql -u root -proot -e 'show databases' -s --skip-column-names); do
   if [[ ! "$excludes" =~ .*\ $DB\ .* ]]; then
     mysqldump $DB > "/root/backup/$DB.sql";
   fi
done

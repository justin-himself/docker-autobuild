
                                 
echo " _____ _____ _____             _ "
echo "|   __|   __|  _  |___ ___ ___| |"
echo "|__   |__   |   __| .'|   | -_| |"
echo "|_____|_____|__|  |__,|_|_|___|_|"
                                 
                   
echo -n "\nChecking environment..."

if [ -z "$SSPANEL_KEY" ]; then
    echo >&2 "SSPANEL_KEY not set!"
    exit
fi
if [ -z "$SSPANEL_BASEURL" ];then
    echo >&2 "SSPANEL_BASEURL not set!"
    exit
fi
if [ -z "$SSPANEL_MUKEY" ];then
    echo >&2 "SSPANEL_MUKEY not set!"
    exit
fi
if [ -z "$DB_HOST" ] && [ -z "$DB_SOCKET" ];then
    echo >&2 "DB_HOST or DB_SOCKET not set!"
    exit
fi
if [ -z "$DB_PASSWORD" ];then
    echo >&2 "DB_PASSWORD not set!"
    exit
fi

echo "Pass"
echo -n "\nChecking if installation exists..."

if [ ! -e public/index.php ]; then
    echo "Not found"
    echo -n "\nCopying new files to directory..."

    if [ -n "$(find -mindepth 1 -maxdepth 1)" ]; then
			echo >&2 "Directory not empty!"
            exit 
	fi

    cp -r /usr/src/sspanel/. .

    echo "Done"
else
    echo "Found"
fi

echo -n "\nChecking connection to database..."

if [ -z "$DB_HOST" ]; then
    if ! mysql -S $DB_SOCKET -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "SELECT VERSION()" > /dev/null; then
        echo >&2 "Cannot connect to database!"
    fi
else
    if ! mysql -h $DB_HOST -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "SELECT VERSION()" > /dev/null; then
        echo >&2 "Cannot connect to database!"
        exit
    fi
fi

echo "Good"
echo -n "\nChecking if database exists..."

if [ -z "$DB_HOST" ]; then
    if ! mysql -S $DB_SOCKET -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "USE $DB_DATABASE" > /dev/null; then
        echo -n "\nInitialize database..."

        mysql -S $DB_SOCKET -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "CREATE DATABASE $DB_DATABASE CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
        mysql -S $DB_SOCKET -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD $DB_DATABASE < sql/glzjin_all.sql

	echo "Done"
    else
        echo "Found"
    fi
else
    if ! mysql -h $DB_HOST -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "USE $DB_DATABASE" > /dev/null; then
        echo -n "\nInitialize database..."

        mysql -h $DB_HOST -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "CREATE DATABASE $DB_DATABASE CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
        mysql -h $DB_HOST -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD $DB_DATABASE < sql/glzjin_all.sql
	
	echo "Done"
    else
        echo "Found"
    fi
fi

echo -n "\nApplying permissions..."

chmod -R 777 storage

echo "Done"

echo -n "\nChecking if admin account exists..."

if [ -z "$DB_HOST" ]; then
	temp_sql_result=$(mysql -S $DB_SOCKET -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "SELECT user_name FROM $DB_DATABASE.user WHERE user_name = 'admin';")
else
	temp_sql_result=$(mysql -h $DB_HOST -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD -e "SELECT user_name FROM $DB_DATABASE.user WHERE user_name = 'admin';")
fi

if [ -z "$temp_sql_result" ]; then
	echo "Not found"
	echo -n "\nAttemping to create admin account..."
	if [ -z "$SSPANEL_ADMIN_EMAIL" ] || [ -z "$SSPANEL_ADMIN_PASSWORD" ];then
		echo "SSPANEL_ADMIN_EMAIL or SSPANEL_ADMIN_PASSWORD not set!"
	else
    echo -n "\n" 
		printf $SSPANEL_ADMIN_EMAIL'\n'$SSPANEL_ADMIN_PASSWORD'\ny\n' | php xcat User createAdmin
	fi
fi

echo -n "\nChecking if client binaries exist..."

if [ ! -d "public/clients" ]; then
	echo "Not found"
	echo -n "\nDownloading client binaries...\n\n"
	php xcat ClientDownload
else
	echo "Found"
fi

echo -n "\nUpdating ip database...\n\n"

php xcat Update


echo "\nAll set, please enjoy!\n\n"

exec "apache2-foreground"

#!/bin/bash
COMMAND=$1
HOST=$2
ID=$3
FLAG=$4
COOKIE=tmp/cookies_$HOST.txt
TMPPAGE=tmp/page_$HOST.txt

# exit(104) Host unreachable
# exit(103) "Welcome message not found"
# exit(103) Bad Answer
# exit(101) good

if [ -f "$COOKIE" ]; then 
	rm $COOKIE
fi

if [ -f "$TMPPAGE" ]; then 
	rm $TMPPAGE
fi

if [ ! -d tmp ]; then 
	mkdir tmp
fi

if [ "$1" == "put" ]; then

	echo "$HOST	FALSE	/	FALSE	0	PHPSESSID	$ID" > $COOKIE
	curl --silent -L -b $COOKIE -c $COOKIE "http://$HOST/crychat/index.php" > $TMPPAGE
	LINES=$(cat $TMPPAGE | wc -l)
	if [ $LINES -lt 1 ]; then 
		echo "ERROR(put): Host unreachable";
		exit 104;
	fi
	
	sleep 0.7s	
	LINES=$(grep "var session_id = \"$ID\"" $TMPPAGE | wc -l)
	if [ $LINES -lt 1 ]; then 
		echo "ERROR(put): Service is broken 1 ";
		exit 103;
	fi

	curl  --silent -L -b $COOKIE -c $COOKIE "http://$HOST/crychat/index.php?action=addmsg&msg=hello%20Kitty!%20;)%20I%20have%20something%20for%20you%20*kiss*" > $TMPPAGE
	sleep 1s
	curl  --silent -L -b $COOKIE -c $COOKIE "http://$HOST/crychat/index.php?action=addmsg&msg=$FLAG" > $TMPPAGE
	curl  --silent -L -b $COOKIE -c $COOKIE "http://$HOST/crychat/index.php?action=messages" > $TMPPAGE

	LINES=$(grep "$FLAG" $TMPPAGE | wc -l)
	if [ $LINES -lt 1 ]; then 
		echo "ERROR(put): Service is broken 2";
		exit 103;
	fi
	exit 101;

elif [ "$1" == "get" ]; then
	
	echo "$HOST	FALSE	/	FALSE	0	PHPSESSID	$ID" > $COOKIE
	curl --silent -L -b $COOKIE -c $COOKIE "http://$HOST/crychat/index.php" > $TMPPAGE
	LINES=$(cat $TMPPAGE | wc -l)
	if [ $LINES -lt 1 ]; then 
		echo "ERROR(put): Host unreachable";
		exit 104;
	fi
	LINES=$(grep "var session_id = \"$ID\"" $TMPPAGE | wc -l)
	if [ $LINES -lt 1 ]; then 
		echo "ERROR(get): Service is broken 1 ";
		exit 103;
	fi
	curl  --silent -L -b $COOKIE -c $COOKIE "http://$HOST/crychat/index.php?action=messages" > $TMPPAGE
	LINES=$(grep "$FLAG" $TMPPAGE | wc -l)
	if [ $LINES -lt 1 ]; then 
		echo "ERROR(put): Service is broken 2";
		exit 103;
	fi
	exit 101
elif [ "$1" == "check" ]; then
	echo "$HOST	FALSE	/	FALSE	0	PHPSESSID	$ID" > $COOKIE
	curl --silent -L -b $COOKIE -c $COOKIE "http://$HOST/crychat/index.php" > $TMPPAGE
	LINES=$(cat $TMPPAGE | wc -l)
	if [ $LINES -lt 1 ]; then 
		echo "ERROR(put): Host unreachable";
		exit 104;
	fi
	exit 101
else
	echo "$1 - unknown command"
	exit 103
fi

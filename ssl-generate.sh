#!/bin/sh

NIFI_TOOLKIT_HOME=/opt/nifi-toolkit
NIFI_SSL_HOME=/opt/nifi/security

CA_HOSTNAME=host1
PASSWD=@123qwe@123qwe
HOSTS=host1,host2

if [ ! -d "${NIFI_SSL_HOME}" ]; then
  echo "${NIFI_SSL_HOME} does not exist."
  mkdir ${NIFI_SSL_HOME}
fi

rm -rf ${NIFI_SSL_HOME}/*


HOST_STRING=""
for HOST in ${HOSTS//,/ }; do
    HOST_STRING=${HOST_STRING}" -n '${HOST}'"
done

echo ${HOST_STRING}

sh ${NIFI_TOOLKIT_HOME}/bin/tls-toolkit.sh standalone \
${HOST_STRING} --days 3650 -c '$CA_HOSTNAME' \
--keyPassword ${PASSWD}  --trustStorePassword ${PASSWD}  --keyStorePassword ${PASSWD} \
-C 'CN=admin' --clientCertPassword ${PASSWD} \
-o ${NIFI_SSL_HOME}

ls -lsa ${NIFI_SSL_HOME}

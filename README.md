# Docker Containers for Tomcat7, using Java7 and PostgreSQL

Infra as Code Tomcat7, Java 7, Postgresql with App in Docker 


### Restore DB

- [x] ``docker exec -i container_name pg_restore -U postgres_user -v -d database_name < /dir_backup_outside_container/file_name.tar``
- [x] **Script run-restoredb.sh**: ``sudo ./run-restoredb.sh PATH/dbacme.backup``


### Backup DB

- [x] ``docker exec -i container_name pg_dump -h postgres_host --clean --format=c --file=/tmp/filename --username=postgres_user postgres_database``
- [x] **Script run-backup.sh**: ``sudo ./run-backup.sh``, the backup file will be in the folder ``postgres_tmp``


### SSL Certificate in Tomcat using KeyTool

1. Generating the file ``.jks`` - **SAVE THIS PASSWORD, IT IS VERY IMPORTANT**:
````
keytool -genkey -keysize 2048 -keyalg RSA -alias dominio -keystore dominio.keystore.jks
````

2. Updating the keystore to an updated default:

````
keytool -importkeystore -srckeystore dominio.keystore.jks -destkeystore dominio.keystore.jks -deststoretype pkcs12
````

3. Generating public key for certificate - file ``.pfx``:

````
keytool -importkeystore -srckeystore dominio.keystore.jks -srcstoretype JKS -destkeystore dominio.keystore.pfx -deststoretype PKCS12
````

4. The file you will need to use in Tomcat is the last one - file ``.pfx``


### Certificate validation request

1. Requesting certificate validation request: 
``keytool -certreq -alias server -file csr.txt -keystore your_site_name.jks``

2. Rename the csr.txt file to csr.csr


### Tomcat configuration

1. In the ``server.xml`` file, insert this snippet, update the information;

````
<Connector port="443" maxHttpHeaderSize="8192" maxThreads="150"
           minSpareThreads="25" maxSpareThreads="75"
           enableLookups="false" disableUploadTimeout="true"
           acceptCount="100" scheme="https" secure="true"
           SSLEnabled="true" clientAuth="false"
           sslProtocol="TLS" keyAlias="dominio"
           keystoreFile="conf/dominio.keystore.pfx"
           keystorePass="pass-keystore" keystoreType="PKCS12"/>
````

2. Comment out the line referring to the APR feature for SSL:

``<Listener className="org.apache.catalina.core.AprLifecycleListener" SSLEngine="on" />``

4. Make sure the keystore file is in the ``conf`` folder of tomcat


### Steps for SSL/Nginx

1. The certificate must be generated using the Java tool ``keytool`` - see step by step above.
2. Redirect from server without SSL to server SSL in nginx:
````
    server {
      listen 80 default_server;
      server_name www.example.com;
      return 301 https://$server_name$request_uri;
    }
````
3. Restart nginx



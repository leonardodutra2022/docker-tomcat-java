FROM tomcat:7.0-jre7 as tomcat

ENV CATALINA_OPTS="-Dkey=value"

ENV JAVA_OPTS="-Djava.awt.headless=true -Xmx2048M -Xms512M -XX:PermSize=256M -XX:MaxPermSize=256M"

EXPOSE 8888/tcp

EXPOSE 80/tcp

EXPOSE 443/tcp

EXPOSE 5432/tcp

COPY ./infra/tomcat/tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml

COPY ./infra/tomcat/server.xml /usr/local/tomcat/conf/server.xml

COPY ./infra/ssl/*.pfx /usr/local/tomcat/conf/

# COPY ./context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml

CMD ["catalina.sh", "run"]
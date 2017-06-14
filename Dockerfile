FROM sonarqube:5.6.6

MAINTAINER Robert Northard, <robert.a.northard>

ENV SONARQUBE_SERVER_BASE="http://localhost:9000" \
    SONARQUBE_WEB_CONTEXT="/sonar" \
    SONARQUBE_FORCE_AUTHENTICATION=true \
    ADOP_LDAP_ENABLED=true \
    SONARQUBE_JMX_ENABLED=false 

#COPY resources/plugins.txt ${SONARQUBE_PLUGINS_DIR}/
COPY resources/sonar.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/* 


VOLUME ["/opt/sonarqube/logs/"]

ENTRYPOINT ["/usr/local/bin/sonar.sh"]

FROM sonarqube:5.6.6

MAINTAINER Robert Northard, <robert.a.northard>

ENV SONARQUBE_PLUGINS_DIR=/opt/sonarqube/default/extensions/plugins \
    SONARQUBE_SERVER_BASE="http://localhost:9000" \
    SONARQUBE_WEB_CONTEXT="/sonar" \
    SONARQUBE_FORCE_AUTHENTICATION=true \
    ADOP_LDAP_ENABLED=true \
    SONARQUBE_JMX_ENABLED=false 

COPY resources/plugins.txt ${SONARQUBE_PLUGINS_DIR}/
COPY resources/sonar.sh resources/plugins.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/* && cd $SONARQUBE_HOME/lib/bundled-plugins/ \
  && curl -sSOL https://sonarsource.bintray.com/Distribution/sonar-ldap-plugin/sonar-ldap-plugin-2.1.0.507.jar 
RUN /usr/local/bin/plugins.sh ${SONARQUBE_PLUGINS_DIR}/plugins.txt

VOLUME ["/opt/sonarqube/logs/"]

ENTRYPOINT ["/usr/local/bin/sonar.sh"]
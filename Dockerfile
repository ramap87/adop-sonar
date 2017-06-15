FROM sonarqube:5.6.6

MAINTAINER Robert Northard, <robert.a.northard>

ENV SONARQUBE_PLUGINS_DIR=/opt/sonarqube/default/extensions/plugins \
    SONARQUBE_SERVER_BASE="http://localhost:9000" \
    SONARQUBE_WEB_CONTEXT="/sonar" \
    SONARQUBE_FORCE_AUTHENTICATION=true \
    ADOP_LDAP_ENABLED=true  

  # clean remove all plugins
RUN rm -rf $SONARQUBE_HOME/lib/bundled-plugins/*.jar \

  # install plugins
  && cd $SONARQUBE_HOME/lib/bundled-plugins/ \
  && curl -sSOL https://sonarsource.bintray.com/Distribution/sonar-ldap-plugin/sonar-ldap-plugin-2.1.0.507.jar \
  && curl -sSOL https://sonarsource.bintray.com/Distribution/sonar-php-plugin/sonar-php-plugin-2.9.0.1664.jar \
  && curl -sSOL https://sonarsource.bintray.com/Distribution/sonar-scm-git-plugin/sonar-scm-git-plugin-1.2.jar \
  && curl -sSOL https://sonarsource.bintray.com/Distribution/sonar-javascript-plugin/sonar-javascript-plugin-2.17.0.3154.jar \
  && curl -sSOL https://github.com/SonarQubeCommunity/sonar-l10n-de/releases/download/1.2/sonar-l10n-de-plugin-1.2.jar \
  && curl -sSOL https://github.com/SonarQubeCommunity/sonar-sonargraph/releases/download/sonar-sonargraph-plugin-3.5/sonar-sonargraph-plugin-3.5.jar \
  && curl -sSOL https://github.com/sonargraph/sonar-sonargraph-integration/releases/download/Release-1.1.4/sonar-sonargraph-integration-1.1.4.jar \
  && curl -sSOL https://github.com/stefanrinderle/softvis3d/releases/download/softvis3d-0.6.0/sonar-softvis3d-plugin-0.6.0.jar \
  && curl -sSOL https://github.com/racodond/sonar-json-plugin/releases/download/2.1/sonar-json-plugin-2.1.jar \
  && curl -sSOL https://github.com/groupe-sii/sonar-web-frontend-plugin/releases/download/v2.1.0/sonar-web-frontend-plugin-2.1.0.jar \
  && curl -sSOL http://nexus.talanlabs.com/content/groups/public_release/com/synaptix/sonar-gitlab-plugin/1.7.0/sonar-gitlab-plugin-1.7.0.jar \
  && sed -i '/exec java.*/a\
    -Dsonar.security.realm="$SONAR_SECURITY_REALM" \
    -Dsonar.security.savePassword="$SONAR_SECURITY_SAVEPASSWORD" \
    -Dldap.authentication="$LDAP_AUTHENTICATION" \
    -Dldap.StartTLS="$LDAP_STARTTLS" \
    -Dldap.bindDn="$LDAP_BINDDN" \
    -Dldap.bindPassword="$LDAP_BINDPASSWORD" \
    -Dldap.url="$LDAP_URL" \
    -Dldap.user.baseDn="$LDAP_USER_BASEDN" \
    -Dldap.user.request="$LDAP_USER_REQUEST" \
    -Dldap.user.realNameAttribute="$LDAP_USER_REALNAMEATTRIBUTE" \
    -Dldap.user.emailAttribute="$LDAP_USER_EMAILATTRIBUTE" \
    -Dldap.group.baseDn="$LDAP_GROUP_BASEDN" \
    -Dldap.group.request="$LDAP_GROUP_REQUEST" \\' $SONARQUBE_HOME/bin/run.sh
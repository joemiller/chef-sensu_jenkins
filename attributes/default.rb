# IMPORTANT! This cookbook does not put the SSL key/cert into place, you need
# to do that manually or add to a private copy of this cookbook!
node.default.sensu_jenkins.ssl_cert_file = "/etc/apache2/ssl/ssl-cert-snakeoil.pem"
node.default.sensu_jenkins.ssl_key_file = "/etc/apache2/ssl/ssl-cert-snakeoil.key"
node.default.sensu_jenkins.ssl_ca_file = "/etc/ssl/certs/cacert.org.pem"

# disable jenkins on http port (non-ssl) ?
node.default.sensu_jenkins.disable_non_ssl = true
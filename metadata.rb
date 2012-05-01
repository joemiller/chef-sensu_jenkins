maintainer        "Joe Miller"
maintainer_email  "joeym@joeym.net"
license           "Apache 2.0"
description       "configures jenkins and apache2 for SSL only"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.0.1"

# available @ http://community.opscode.com/cookbooks/apache2
depends "apache2"

# available @ http://community.opscode.com/cookbooks/jenkins
depends "jenkins"

%w{ ubuntu debian }.each do |os|
  supports os
end

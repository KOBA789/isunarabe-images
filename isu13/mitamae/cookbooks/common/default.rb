execute "apt update"
%w[
  acl
  build-essential
  libxml2-dev
  pkg-config
  libsqlite3-dev
  libbz2-dev
  libcurl4-openssl-dev
  libpng-dev
  libjpeg-dev
  libonig-dev
  libreadline-dev
  libtidy-dev
  libxslt-dev
  libzip-dev
  autoconf
  bison
  dpkg-dev
  libgdbm-dev
  libssl-dev
  libreadline-dev
  libffi-dev
  zlib1g-dev
  libyaml-dev
  libmysqlclient-dev
].each do |pkg|
  package pkg
end

file "/etc/ssh/sshd_config.d/pubkey.conf" do
  owner "root"
  group "root"
  mode "0644"
  content "PubkeyAcceptedAlgorithms=+ssh-rsa\n"
end

execute "sysctl --system" do
  command "sysctl --system"
  action :nothing
end

file "/etc/sysctl.d/99-isu.conf" do
  owner "root"
  group "root"
  mode "0644"
  content "net.ipv4.ip_local_port_range = 10000 65535\n"
  notifies :run, "execute[sysctl --system]"
end

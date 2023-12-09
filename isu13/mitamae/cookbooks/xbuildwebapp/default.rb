remote_file "/home/isucon/local/rustup-init.sh" do
  group "isucon"
  owner "isucon"
  mode "0755"
end

execute "/usr/bin/sh -x /home/isucon/local/rustup-init.sh -y --no-modify-path --profile default --default-toolchain 1.74.0 -c rustfmt" do
  user "isucon"
  cwd "/home/isucon"
end

directory "/opt/xbuild/var" do
  group "root"
  owner "root"
  mode "0777"
end

directory "/opt/xbuild/bin" do
  group "root"
  owner "root"
  mode "0777"
end

execute "install node" do
  user "isucon"
  command "/opt/xbuild/node-install v20.10.0 /home/isucon/local/node"
end

execute "install perl" do
  user "isucon"
  command "/opt/xbuild/perl-install 5.38.0 /home/isucon/local/perl -- -Duselongdouble -j $(nproc)"
end

remote_file "/home/isucon/local/perl/bin/cpm" do
  group "isucon"
  owner "isucon"
  mode "0755"
end

execute "install ruby" do
  user "isucon"
  command "MAKE_OPTS=-j$(nproc) /opt/xbuild/ruby-install 3.2.2 /home/isucon/local/ruby"
end

execute "install php" do
  user "isucon"
  command %q{/opt/xbuild/php-install 8.2.11 /home/isucon/local/php -- \
    --with-pcre-regex --with-zlib --enable-fpm --enable-pdo --with-pear \
    --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-openssl \
    --with-pcre-regex --with-pcre-dir --with-libxml-dir --enable-opcache \
    --enable-bcmath --with-bz2 --enable-calendar --enable-cli --enable-shmop \
    --enable-sysvsem --enable-sysvshm --enable-sysvmsg --enable-mbregex \
    --enable-mbstring --enable-pcntl --enable-sockets --with-curl --enable-zip}
end

execute "install python" do
  user "isucon"
  command "/opt/xbuild/python-install 3.12.0 /home/isucon/local/python"
end

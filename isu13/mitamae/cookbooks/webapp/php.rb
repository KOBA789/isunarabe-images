remote_file "/home/isucon/local/php/etc/isupipe.php-fpm.conf" do
  group "isucon"
  owner "isucon"
  mode "0644"
end

execute "build php app" do
  user "isucon"
  command "/home/isucon/.x ./composer.phar install"
  cwd "/home/isucon/webapp/php"
end

remote_file "/etc/systemd/system/isupipe-php.service" do
  mode "0644"
end

service "isupipe-php" do
  action [:disable, :stop]
end

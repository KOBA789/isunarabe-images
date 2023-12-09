package "nginx"

remote_file "/etc/nginx/sites-available/isupipe.conf" do
  owner "root"
  group "root"
  mode "0644"
end

remote_file "/etc/nginx/sites-available/isupipe-php.conf" do
  owner "root"
  group "root"
  mode "0644"
end

link "/etc/nginx/sites-enabled/isupipe.conf" do
  to "/etc/nginx/sites-available/isupipe.conf"
end

file "/etc/nginx/sites-enabled/default" do
  action :delete
end

remote_directory "/etc/nginx/tls" do
  owner "root"
  group "root"
  mode "0755"
  source "files/etc/nginx/tls"
end

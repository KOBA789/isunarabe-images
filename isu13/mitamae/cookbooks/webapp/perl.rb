execute "build perl app" do
  user "isucon"
  command "/home/isucon/.x cpm install --show-build-log-on-failure"
  cwd "/home/isucon/webapp/perl"
end

remote_file "/etc/systemd/system/isupipe-perl.service" do
  mode "0644"
end

service "isupipe-perl" do
  action [:disable, :stop]
end

execute "build ruby app" do
  user "isucon"
  command "/home/isucon/.x bundle install"
  cwd "/home/isucon/webapp/ruby"
end

remote_file "/etc/systemd/system/isupipe-ruby.service" do
  mode "0644"
end

service "isupipe-ruby" do
  action [:enable, :stop]
end

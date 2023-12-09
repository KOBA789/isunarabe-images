execute "build node app" do
  user "isucon"
  command "/home/isucon/.x npm install"
  cwd "/home/isucon/webapp/node"
end

remote_file "/etc/systemd/system/isupipe-node.service" do
  mode "0644"
end

service "isupipe-node" do
  action [:disable, :stop]
end

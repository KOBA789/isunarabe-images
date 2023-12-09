execute "build go app" do
  user "isucon"
  command '/home/isucon/local/golang/bin/go build -o /home/isucon/webapp/go/isupipe -ldflags "-s -w"'
  cwd "/home/isucon/webapp/go"
end

remote_file "/etc/systemd/system/isupipe-go.service" do
  mode "0644"
end

service "isupipe-go" do
  action [:enable, :restart]
end

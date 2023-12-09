execute "install pipenv" do
  user "isucon"
  command "/home/isucon/.x pip install pipenv"
  cwd "/home/isucon/webapp/python"
end

execute "build python app" do
  user "isucon"
  command "/home/isucon/.x pipenv install"
  cwd "/home/isucon/webapp/python"
end

remote_file "/etc/systemd/system/isupipe-python.service" do
  mode "0644"
end

service "isupipe-python" do
  action [:disable, :stop]
end

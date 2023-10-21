package 'mysql-server'
service 'mysql' do
  action [:enable, :start]
end

execute "mysql -u root -e \"ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';\""

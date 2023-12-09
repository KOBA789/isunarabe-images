package 'mysql-server'
service 'mysql' do
  action [:enable, :start]
end

execute "create user" do
  command %q{mysql -uroot -e "
    CREATE USER IF NOT EXISTS 'isucon'@'localhost' IDENTIFIED BY 'isucon';
    GRANT ALL PRIVILEGES ON *.* TO 'isucon'@'localhost' WITH GRANT OPTION;
    CREATE USER IF NOT EXISTS 'isudns'@'localhost' IDENTIFIED BY 'isudns';
    GRANT ALL PRIVILEGES ON *.* TO 'isudns'@'localhost' WITH GRANT OPTION;
    FLUSH PRIVILEGES;
  "}
end

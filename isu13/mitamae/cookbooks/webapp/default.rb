remote_directory '/home/isucon/webapp' do
  group 'isucon'
  owner 'isucon'
  source 'files/home/isucon/webapp'
end
execute 'chown -R isucon:isucon /home/isucon/webapp'

execute "create isudns db" do
  command %q{mysql -uroot -e "
    DROP DATABASE IF EXISTS isupipe;
    CREATE DATABASE IF NOT EXISTS isupipe;
  "}
end

execute "create tables on isudns" do
  command "cat /home/isucon/webapp/sql/initdb.d/10_schema.sql | mysql -uisucon -pisucon"
end

include_recipe "./go"
include_recipe "./node"
include_recipe "./perl"
include_recipe "./php"
include_recipe "./python"
include_recipe "./ruby"
include_recipe "./rust"

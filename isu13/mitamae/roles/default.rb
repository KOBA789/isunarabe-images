ENV['DEBIAN_FRONTEND'] = 'noninteractive'
include_recipe '../cookbooks/common/default.rb'
include_recipe '../cookbooks/users/isucon.rb'
include_recipe '../cookbooks/ipaddr/default.rb'
include_recipe '../cookbooks/xbuild/default.rb'
include_recipe '../cookbooks/xbuildwebapp/default.rb'
include_recipe '../cookbooks/mysql/default.rb'
include_recipe '../cookbooks/powerdns/default.rb'
include_recipe '../cookbooks/nginx/default.rb'
include_recipe '../cookbooks/webapp/default.rb'
include_recipe '../cookbooks/bench/default.rb'

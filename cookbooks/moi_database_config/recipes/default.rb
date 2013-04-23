#
# Cookbook Name:: moi_database_config
# Recipe:: default
#
# Creates a database.yml file that contains both the generated EY DB info
# as well as the internal MOI database stuff.

if ['solo'].include?(node[:instance_role])
  # for each application
  node.engineyard.apps.each do |app|
    log_msg = "MOI - Replacing database.yml for #{app.name}"

    ey_cloud_report "MOI Database Config Update" do
      message log_msg
    end

    Chef::Log.info log_msg

    # create new database.yml with attributes
    template "/data/#{app.name}/shared/config/database.yml" do
      owner node[:owner_name]
      group node[:owner_name]
      backup false
      mode 0644
      source 'database.yml.erb'
      variables({
                    # These are the variables for the main prod database, everything else
                    # is hardcoded in the erb file itself.
                    :environment => node[:environment][:framework_env],
                    :database => app.name,
                    :username => node[:users].first[:username],
                    :password => node[:users].first[:password],
                    :host => node[:db_host]
                })
    end

    Chef::Log.info "Replaced database.yml without issues!"
  end
end

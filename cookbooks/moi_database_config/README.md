ey-cloud-recipes/moi_database_config
------------------------------------------------------------------------------

A chef recipe for creating a database.yml file that includes the generated EY
instance, DB, and password info but also includes the static MOI databases back
in our systems.

Dependencies
--------------------------

Requires that the MOI firewall for the internal DB server is set up to allow
the connection.

Enabling this recipe
---------------------------

* Edit main/recipes/default.rb and comment out the line shown below.
``require_recipe "moi_database_config"``

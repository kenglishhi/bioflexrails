 #NOTE: Using postgresql, not setting sequence name, system will discover the name by default.
      #NOTE: this class will not establish the connection automatically
#      self.abstract_class = true
class ActiveRecord::Base
      self.pluralize_table_names = false
      #prepend table name to the usual id, avoid to specify primary id for every table
      self.primary_key_prefix_type = :table_name_with_underscore
      #biosql_configurations=YAML::load(ERB.new(IO.read(File.join(File.dirname(__FILE__),'../config', 'database.yml'))).result)
      #self.configurations=biosql_configurations
      #self.establish_connection "development"
end
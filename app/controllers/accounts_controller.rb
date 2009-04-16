class AccountsController < ApplicationController
  active_scaffold :users do |config|
     config.list.label = "Databases"
     config.list.columns = [:login, :name, :email, :activated_at ]
     config.actions.exclude :nested
     config.actions.exclude  :create
  end
end


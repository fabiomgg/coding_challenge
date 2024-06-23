class UsersController < ApplicationController
  require 'csv'

  def index; end

  def create
    @results = []

    CSV.foreach(params[:file].path, headers: true, row_sep: "\r\r\n") do |row|
      user = User.new(name: row['name'], password: row['password'])
      if user.save
        @results << "User #{user.name} was successfully created"
      else
        @results << "User #{row['name']} was not created. Errors: #{user.errors.full_messages.join(', ')}"
      end
    end
  end
end

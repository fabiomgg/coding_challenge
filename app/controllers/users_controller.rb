class UsersController < ApplicationController

  def index; end

  def create
    service = CsvUserImportService.new(params[:file])
    @results = service.process
  end
end

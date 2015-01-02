class BoxesController < ApplicationController
  layout 'box'
  before_filter :find_box, only: %w(show download)

  def create
    box = Box.create params: params
    redirect_to box_url(box)
  end

  def show
  end

  def download
    configurator = Configurator.from_params(@box.params)
    builder = ConfigurationBuilder.new(configurator)
    zip_path = builder.build
    send_file zip_path, filename: configurator.file_name
  end

  private

  def find_box
    @box = Box.where(secure_id: params[:id]).first!
  end
end

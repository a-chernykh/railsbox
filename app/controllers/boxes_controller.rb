class BoxesController < ApplicationController
  layout 'box', except: %w(edit)
  before_filter :find_box, except: %w(create default)

  def create
    box = Box.create! params: typecasted_box_params
    redirect_to box_url(box)
  end

  def default
    render json: DefaultConfiguration.get(browser.platform)
  end

  def show
    @box = Decorators::BoxDecorator.decorate @box
    respond_to do |format|
      format.html
      format.json { render json: @box }
    end
  end

  def edit
  end

  def update
    @box.update_attributes params: typecasted_box_params
    redirect_to box_url(@box), notice: t('updated')
  end

  def download
    download = Services::Download.new(@box)
    result = download.call
    send_file result.path, filename: result.file_name
  end

  def destroy
    @box.destroy
    redirect_to root_url, notice: t('deleted')
  end

  private

  def find_box
    @box = Box.where(secure_id: params[:id]).first!
  end

  def typecasted_box_params
    Typecaster.new(params[:box]).typecasted
  end
end

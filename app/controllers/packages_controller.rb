class PackagesController < ApplicationController
  def index
    @packages = Package.all
  end

  def show
    @package = Package.find(params[:id])
  end

  def new
    @package = Package.new
    @package.to_address = Address.new
    @package.from_address = Address.new
  end

  def create
    upsert :new, "Package #{params[:package][:name]} created"
  end

  def edit
    @package = Package.find(params[:id])
  end

  def update
    upsert :edit
  end

  def upsert(after, notice = nil)
    params = package_params

    to_address = Address.find_or_initialize_by(params.delete(:to_address_attributes))
    from_address = Address.find_or_initialize_by(params.delete(:from_address_attributes))

    @package = Package.find_or_initialize_by(params)
    @package.to_address = to_address
    @package.from_address = from_address

    if @package.save
      redirect_to @package, notice: notice
    else
      render after, status: :unprocessable_entity
    end
  end

  def destroy
    flash[:notice] = "Package #{params[:id]} deleted"
    @package = Package.find(params[:id])
    @package.destroy
    redirect_to packages_path
  end

  private

  # The accepted parameters for creating a package
  def package_params
    params.require(:package).permit(
      :name,
      :state,
      from_address_attributes: address_params,
      to_address_attributes: address_params
    )
  end

  def address_params
    %i[line_one line_two city country region postal_code]
  end
end

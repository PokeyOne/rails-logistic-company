class PackagesController < ApplicationController
  def index
    @packages = Package.all
  end

  def show
    @package = Package.find(params[:id])
  end

  def new
    @package = Package.new
  end

  def create
    params = package_params

    to_address = Address.new(
      line_one: params.delete(:to_address_line_one),
      line_two: params.delete(:to_address_line_two),
      city: params.delete(:to_address_city),
      country: params.delete(:to_address_country),
      region: params.delete(:to_address_region),
      postal_code: params.delete(:to_address_postal_code)
    )
    unless to_address.save
      render :new, status: :unprocessable_entity
      return
    end

    from_address = Address.new(
      line_one: params.delete(:from_address_line_one),
      line_two: params.delete(:from_address_line_two),
      city: params.delete(:from_address_city),
      country: params.delete(:from_address_country),
      region: params.delete(:from_address_region),
      postal_code: params.delete(:from_address_postal_code)
    )
    unless from_address.save
      render :new, status: :unprocessable_entity
      return
    end

    @package = Package.new(params.merge(to_address_id: to_address.id, from_address_id: from_address.id))

    if @package.save
      redirect_to @package
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @package = Package.find(params[:id])
  end

  def update
    @package = Package.find(params[:id])

    params = package_params

    unless @package.to_address.update(
      line_one: params.delete(:to_address_line_one),
      line_two: params.delete(:to_address_line_two),
      city: params.delete(:to_address_city),
      country: params.delete(:to_address_country),
      region: params.delete(:to_address_region),
      postal_code: params.delete(:to_address_postal_code)
    )
      render :edit, status: :unprocessable_entity
      return
    end

    unless @package.from_address.update(
      line_one: params.delete(:from_address_line_one),
      line_two: params.delete(:from_address_line_two),
      city: params.delete(:from_address_city),
      country: params.delete(:from_address_country),
      region: params.delete(:from_address_region),
      postal_code: params.delete(:from_address_postal_code)
    )
      render :edit, status: :unprocessable_entity
      return
    end

    if @package.update(params)
      redirect_to @package
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
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
      :from_address_line_one,
      :from_address_line_two,
      :from_address_city,
      :from_address_country,
      :from_address_region,
      :from_address_postal_code,
      :to_address_line_one,
      :to_address_line_two,
      :to_address_city,
      :to_address_country,
      :to_address_region,
      :to_address_postal_code
    )
  end
end

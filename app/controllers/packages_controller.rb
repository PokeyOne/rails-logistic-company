# typed: strict
# frozen_string_literal: true

class PackagesController < ApplicationController
  extend T::Sig

  sig { void }
  def initialize
    @package = T.let(nil, T.nilable(Package))
    @packages = T.let(nil, T.nilable(ActiveRecord::Relation))
  end

  sig { void }
  def index
    @packages = Package.all
  end

  sig { void }
  def show
    @package = Package.find(params[:id])
  end

  sig { void }
  def new
    @package = Package.new
    @package.to_address = Address.new
    @package.from_address = Address.new
  end

  sig { void }
  def create
    upsert :new, "Package #{package_params[:name]} created"
  end

  sig { void }
  def edit
    @package = Package.find(params[:id])
  end

  sig { void }
  def update
    upsert :edit, "Package #{package_params[:name]} updated"
  end

  sig { params(after: Symbol, notice: T.nilable(String)).void }
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
      flash[:error] = "Could not create a package with the information supplied."
      render after, status: :unprocessable_entity
    end
  end

  sig { void }
  def destroy
    flash[:notice] = "Package #{params[:id]} deleted"
    @package = Package.find(params[:id])
    @package.destroy
    redirect_to packages_path
  end

  private

  # The accepted parameters for creating a package
  sig { returns(ActionController::Parameters) }
  def package_params
    T.cast(params.require(:package), ActionController::Parameters).permit(
      :name,
      :state,
      from_address_attributes: address_params,
      to_address_attributes: address_params
    )
  end

  sig { returns(T::Array[Symbol]) }
  def address_params
    %i[line_one line_two city country region postal_code]
  end
end

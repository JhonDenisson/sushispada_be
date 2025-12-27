module Customers
  class AddressesController < ApplicationController
    before_action :set_address, only: [ :show, :update, :destroy ]

    def index
      addresses = policy_scope(Address)
      render json: addresses
    end

    def show
      render json: @address
    end

    def create
      address = current_user.addresses.build(address_params)
      authorize address

      if address.save
        render json: address, status: :created
      else
        render json: { errors: address.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @address.update(address_params)
        render json: @address
      else
        render json: { errors: @address.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      @address.soft_delete!
      head :no_content
    end

    private

    def set_address
      @address = current_user.addresses.find(params[:id])
      authorize @address
    end

    def address_params
      params.require(:address).permit(
        :label, :street, :number, :complement,
        :neighborhood, :city, :reference
      )
    end
  end
end

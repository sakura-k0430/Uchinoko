class Admin::HospitalsController < ApplicationController
  def new
    @hospital = Hospital.new
  end

  def create
    @hospital = Hospital.new(hospital_params)
    if @hospital.save
      redirect_to  admin_hospital_path(@hospital)
    else
      render :new
    end
  end

  def index
    @hospitals = Hospital.all
  end

  def show
    @hospital = Hospital.find(params[:id])
  end

  def edit
    @hospital = Hospital.find(params[:id])
  end

  def update
    hospital = Hospital.find(params[:id])
    hospital.update(hospital_params)
    redirect_to admin_hospital_path(hospital.id)
  end

  def destroy
    hospital = Hospital.find(params[:id])
    hospital.destroy
    redirect_to admin_hospitals_path
  end

  private
  def hospital_params
    # ジャンルは、チェックボックスによって複数渡される場合があるため、配列形式であることを記載
    params.require(:hospital).permit(:name, :phone_number, :explanation, :address, :hospital_image, genre_ids: [])
  end

end

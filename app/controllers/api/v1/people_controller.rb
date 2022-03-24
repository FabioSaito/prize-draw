class Api::V1::PeopleController < Api::BaseController
  def index 
    @people = Person.order(created_at: :desc)

    render json: @people, each_serializer: PersonSerializer, status: :ok
  end

  def show 
    @person = Person.find(params[:id])
    
    render json: @person, serializer: PersonSerializer, status: :ok
  end

  def create
    @person = Person.new(person_params)

    if @person.save
      render json: @person, serializer: PersonSerializer, status: :ok
    else
      render json: @person, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer , status: :unprocessable_entity
    end
  end

  def destroy 
    @person = Person.find(params[:id])
    @person.destroy

    render json: @person, serializer: PersonSerializer, status: :ok
  end

  def update 
    @person = Person.find(params[:id])
    
    if @person.update(person_params)
      render json: @person, serializer: PersonSerializer, status: :ok
    else
      render json: @person, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer , status: :unprocessable_entity
    end
  end

  private
  def person_params
    params.require(:person).permit(:name, :cpf, :born_on)
  end
end

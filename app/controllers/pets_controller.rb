class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do

      ####### bug fix
     if !params[:owner].keys.include?("owner_id")
     params[:owner]["pet_ids"] = []
     end
     #######

     # Active Record was smart enough to allow us to use mass assignment to not only create a new owner but to associate that owner to the pets whose IDs were contained in the "pet_ids" array, it is also smart enough to allow us to update an owner in the same way.

     @pet = Pet.find(params[:id])
     @pet.update(params["pet"])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
   end


end

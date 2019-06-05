require 'pry'

class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index'
  end

  get '/owners/new' do
    @pets = Pet.all
    erb :'/owners/new'
  end

  post '/owners' do
    # Active Record was smart enough to allow us to use mass assignment to not only create a new owner but to associate that owner to the pets whose IDs were contained in the "pet_ids" array, it is also smart enough to allow us to update an owner in the same way.
    @owner = Owner.create(params[:owner])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
     redirect "owners/#{@owner.id}"

  end

  get '/owners/:id/edit' do
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'
  end

  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id' do
    ####### bug fix
   if !params[:owner].keys.include?("pet_ids")
   params[:owner]["pet_ids"] = []
   end
   #######

   # Active Record was smart enough to allow us to use mass assignment to not only create a new owner but to associate that owner to the pets whose IDs were contained in the "pet_ids" array, it is also smart enough to allow us to update an owner in the same way. 

   @owner = Owner.find(params[:id])
    @owner.update(params["owner"])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect "owners/#{@owner.id}"
  end
end

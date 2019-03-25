class MoviesController < ApplicationController
  def index
    @movies = JSON.parse(HTTParty.get('https://swapi.co/api/films').body)["results"]
  end

  def show
    @movie = JSON.parse(HTTParty.get(params['movie_url']).body)
    threads = []
    @characters = []
    @starships = []
    @planets = []
    @movie['characters'].each do |character_url|
      threads << Thread.new do
        @characters << JSON.parse(HTTParty.get(character_url).body)
      end
    end
    @movie['starships'].each do |starship_url|
      threads << Thread.new do
        @starships << JSON.parse(HTTParty.get(starship_url).body)
      end
    end
    @movie['planets'].each do |planet_url|
      threads << Thread.new do
        @planets << JSON.parse(HTTParty.get(planet_url).body)
      end
    end
    threads.each &:join
  end

  def character
    @character = JSON.parse(HTTParty.get(params['character_url']).body)
    @home_planet = JSON.parse(HTTParty.get(@character['homeworld']).body)
    threads = []
    @starships = []
    @movies = []
    @character['starships'].each do |starship_url|
      threads << Thread.new do
        @starships << JSON.parse(HTTParty.get(starship_url).body)
      end
    end
    @character['films'].each do |film_url|
      threads << Thread.new do
        @movies << JSON.parse(HTTParty.get(film_url).body)
      end
    end
    threads.each &:join
  end

  def starship
    @starship = JSON.parse(HTTParty.get(params['starship_url']).body)
    threads = []
    @characters = []
    @movies = []
    @starship['pilots'].each do |pilot_url|
      threads << Thread.new do
        @characters << JSON.parse(HTTParty.get(pilot_url).body)
      end
    end
    @starship['films'].each do |film_url|
      threads << Thread.new do
        @movies << JSON.parse(HTTParty.get(film_url).body)
      end
    end
    threads.each &:join
  end

  def planet
    @planet = JSON.parse(HTTParty.get(params['planet_url']).body)
    threads = []
    @characters = []
    @movies = []
    @planet['residents'].each do |pilot_url|
      threads << Thread.new do
        @characters << JSON.parse(HTTParty.get(pilot_url).body)
      end
    end
    @planet['films'].each do |film_url|
      threads << Thread.new do
        @movies << JSON.parse(HTTParty.get(film_url).body)
      end
    end
    threads.each &:join
  end
end

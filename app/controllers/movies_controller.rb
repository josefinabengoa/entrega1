class MoviesController < ApplicationController
  def index
    @movieshttp = JSON.parse(HTTParty.get('https://swapi.co/api/films').body)["results"]
    @movies = (HTTParty.get('https://swapi-graphql-integracion-t3.herokuapp.com/',
    :body => { "query": "{
  allFilms {
    edges {
      node {
        title
        episodeID
        openingCrawl
        director
        producers
        releaseDate
      }
    }
  }
}
"}.to_json, :headers => { 'Content-Type' => 'application/json' }))
    @movies = @movies["data"]["allFilms"]["edges"]
  end



  def show
    @movieshttp = JSON.parse(HTTParty.get('https://swapi.co/api/films').body)["results"]
    @movies = (HTTParty.get('https://swapi-graphql-integracion-t3.herokuapp.com/',
    :body => { "query": "{
  allFilms {
    edges {
      node {
        title
        openingCrawl
        director
        producers
        releaseDate
        starshipConnection {
          edges {
            node {
              name
            }
          }
        }
        characterConnection {
          edges {
            node {
              name
            }
          }
        }
        planetConnection {
          edges {
            node {
              name
            }
          }
        }
      }
    }
  }
}
"}.to_json, :headers => { 'Content-Type' => 'application/json' }))
  @movies = @movies["data"]["allFilms"]["edges"]
  @movies.each do |dic|
    char = dic["node"]
    if char['title'] == params['movie_title']
      @movie = char
  @characters = @movie["characterConnection"]['edges']
  @starships = @movie["starshipConnection"]['edges']
  @planets = @movie["planetConnection"]["edges"]
  end
  end
  end



  def character
    @movieshttp = JSON.parse(HTTParty.get('https://swapi.co/api/films').body)["results"]
    @character = (HTTParty.get('https://swapi-graphql-integracion-t3.herokuapp.com/',
    :body => { "query": "{
  allPeople {
    edges {
      node {
        name
    	birthYear
    eyeColor
    gender
    hairColor
    height
    mass
    homeworld {
      name
    }
    filmConnection{
      edges{
        node{
          title
        }
      }
    }
    starshipConnection
    {
      edges{
        node{
          name
        }
      }
    }
      }
    }
  }
}
"}.to_json, :headers => { 'Content-Type' => 'application/json' }))
    @characters = @character["data"]["allPeople"]["edges"]
    @characters.each do |dic|
      char = dic["node"]
      if char['name'] == params['character_name']
        @character = char
    @home_planet = @character['homeworld']
    @starships = @character["starshipConnection"]['edges']
    @movies = @character["filmConnection"]["edges"]
    end
  end
  end

  def starship
    @movieshttp = JSON.parse(HTTParty.get('https://swapi.co/api/films').body)["results"]
    @starships = (HTTParty.get('https://swapi-graphql-integracion-t3.herokuapp.com/',
    :body => { "query": "{
  allStarships {
    edges {
      node {
        name
        model
        starshipClass
        manufacturers
        costInCredits
        length
   			 crew
        passengers
        maxAtmospheringSpeed
        hyperdriveRating
        MGLT
        cargoCapacity
        consumables
    filmConnection{
      edges{
        node{
          title
        }
      }
    }
    pilotConnection
    {
      edges{
        node{
          name
        }
      }
    }
      }
    }
  }
}
    "}.to_json, :headers => { 'Content-Type' => 'application/json' }))
    @starships = @starships["data"]["allStarships"]["edges"]
    @starships.each do |dic|
      char = dic["node"]
      if char['name'] == params['starship_name']
        @starship = char
    puts "STARSHIP"
    puts @starship
    @characters = @starship["pilotConnection"]['edges']
    @movies = @starship["filmConnection"]["edges"]
    end
    end
  end




  def planet
    @movieshttp = JSON.parse(HTTParty.get('https://swapi.co/api/films').body)["results"]
    @planets = (HTTParty.get('https://swapi-graphql-integracion-t3.herokuapp.com/',
    :body => { "query": "{
  allPlanets {
    edges {
      node {
        name
        diameter
        rotationPeriod
        orbitalPeriod
        gravity
        population
        climates
        terrains
        surfaceWater
        residentConnection {
          edges {
            node {
              name
            }
          }
        }
        filmConnection {
          edges {
            node {
              title
            }
          }
        }
      }
    }
  }
}

"}.to_json, :headers => { 'Content-Type' => 'application/json' }))
    @planets = @planets["data"]["allPlanets"]["edges"]
    @planets.each do |dic|
      char = dic["node"]
      if char['name'] == params['planet_name']
        @planet = char
    @characters = @planet['residentConnection']['edges']
    @movies = @planet["filmConnection"]["edges"]
    end
  end
end
end

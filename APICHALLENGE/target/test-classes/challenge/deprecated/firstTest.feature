# new feature
# Tags: optional

Feature: First challenge test: Use Nasa API

  Scenario: Retrieve the first 10 Mars photos made by "Curiosity" on 1000 Martian sol
    Given url "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY&page=1"
    When method GET
    Then status 200
    * def all_photos = response.photos
    * assert all_photos.length > 10
    * def photos = []
    * def fun = function(i){ karate.appendTo(photos, response.photos[i].img_src) }
    * karate.repeat(10, fun)
    Then print photos
    * assert photos.length == 10


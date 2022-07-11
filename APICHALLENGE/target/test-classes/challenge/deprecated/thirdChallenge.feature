# new feature
# Tags: optional

@ignore
Feature: First challenge test: Use Nasa API

  Background:
    * url 'https://api.nasa.gov/mars-photos/api/v1/rovers'

  Scenario: Retrieve the first 10 Mars photos made by "Curiosity" on 1000 Martian sol
    * def query = {sol: '1000', api_key: '3URwAWOHjeJxgDD6Dt94WfSXs3chWqfNHBb9aBp4'}
    Given path  '/curiosity/photos'
    And params query
    When method GET
    Then status 200
    Then print 'Endpoint hit!'
    * def first = response.photos
    * def photos1 = []
    * def fun = function(i){ karate.appendTo(photos1, response.photos[i].img_src) }
    * karate.repeat(10, fun)
    Then print photos1

    Given url "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2015-5-30&api_key=3URwAWOHjeJxgDD6Dt94WfSXs3chWqfNHBb9aBp4"
    When method GET
    Then status 200
    Then print 'Endpoint hit!'
    * def second = response.photos
    * def photos2 = []
    * def fun = function(i){ karate.appendTo(photos2, response.photos[i].img_src) }
    * karate.repeat(10, fun)
    Then print photos2
    * match first contains deep second
    * match photos1 contains photos2




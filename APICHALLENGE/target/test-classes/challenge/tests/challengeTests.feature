# new feature
# Tags: optional

Feature: NASA Challenge test: Use Nasa API

  Background:
    * url 'https://api.nasa.gov/mars-photos/api/v1/rovers'
    * def combinations = read('classpath:challenge/data/cameracombinations.json')

  Scenario Outline: Retrieve photos of camera <camera> for <rover1>, <rover2> and <rover3>) and compare

    * def query = {sol: '1000', api_key: <key>, camera: <camera>}
    * def rover = '<rover1>'
    * def mission_path = Java.type('challenge.util.Utils').createPath(rover)
    Given path  mission_path
    And params query
    When method GET
    Then status 200
    Then print 'Endpoint hit!'
    * def ids1 = response.photos
    * print 'amount of items:' + ids1.length
    Given path  '/<rover2>/photos'
    And params query
    When method GET
    Then status 200
    Then print 'Endpoint hit!'
    * def ids2 = response.photos
    * print 'amount of items:' + ids2.length
    Given path  '/<rover3>/photos'
    And params query
    When method GET
    Then status 200
    Then print 'Endpoint hit!'
    * def ids3 = response.photos
    * print 'amount of items:' + ids3.length
    * assert ids1.length > 10 * ids2.length
    * assert ids1.length > 10 * ids3.length
    Examples:
      | combinations |

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

  Scenario: Retrieve the first 10 Mars photos made by "Curiosity" on 1000 Martian sol
    Given url "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2015-5-30&api_key=DEMO_KEY&page=1"
    When method GET
    Then status 200
    * def all_photos = response.photos
    * assert all_photos.length > 10
    * def photos = []
    * def fun = function(i){ karate.appendTo(photos, response.photos[i].img_src) }
    * karate.repeat(10, fun)
    Then print photos
    * assert photos.length == 10

  Scenario: Retrieve and compare the first 10 Mars photos made by "Curiosity"
            on 1000 sol and on Earth date equal to 1000 Martian sol.
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
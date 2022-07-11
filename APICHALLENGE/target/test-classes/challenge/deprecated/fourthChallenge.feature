# new feature
# Tags: optional
@ignore
Feature: First challenge test: Use Nasa API

  Background:
    * url 'https://api.nasa.gov/mars-photos/api/v1/rovers'
    * def combinations = read('classpath:challenge/data/cameracombinations.json')
    * def key = "3URwAWOHjeJxgDD6Dt94WfSXs3chWqfNHBb9aBp4"

  Scenario Outline: Retrieve photos of camera <camera> for <rover1>, <rover2> and <rover3>) and compare
    * def query = {sol: '1000', api_key: "3URwAWOHjeJxgDD6Dt94WfSXs3chWqfNHBb9aBp4", camera: <camera>}
    * def rover = '<rover1>'
    * def mission_path = Java.type('challenge.util.Utils').createPath(rover)
    Given path  mission_path
    And params query
    When method GET
    Then status 200
    Then print 'Endpoint hit!'
    * print response.photos
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
Feature: Check returned countries by API

Background:
  * url 'https://restcountries.eu'
  * header Accept = 'application/json'


  @id:1 @CasoPositivo
  Scenario: get list of all countries
    Given path '/v3.1/all'
    When method GET
    Then status 200
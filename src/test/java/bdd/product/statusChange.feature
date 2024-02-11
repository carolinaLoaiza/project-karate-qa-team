@sample-automation-api
Feature: Cambiar estado producto

  Background:
    * def responseLogin = call read('classpath:bdd/auth/loginAuth.feature@loginBackground')
    * def token = responseLogin.token
    Given header Authorization = 'Bearer ' + token
    And url urlBase
  Scenario Outline: cambiar estado con csv
    * def id = 10
    And path 'api/v1/producto/' + id
    And request {estado:<estado>}
    When method patch
    Then status 200
    And match response.estado == '<estado>'

    Examples:
    | read('classpath:resources/csv/product/dataStatus.csv')|
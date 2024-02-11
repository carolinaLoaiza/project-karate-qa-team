@automation-api
Feature: Get products

  Background:
    * def responseLogin = call read('classpath:bdd/auth/loginAuth.feature@loginBackground')
    * def token = responseLogin.token
    Given header Authorization = 'Bearer ' + token
    And url urlBase

  @getProduct1
  Scenario Outline: Get by product
    Given url urlBase
    And path '/api/v1/producto/' + <id>
    When method get
    Then status 200
    And match response.id == <id>
    Examples:
      | read('classpath:resources/csv/product/products.csv')|

  @getProduct2
  Scenario: Get by product not successful
    * def id = 25000
    Given url urlBase
    And path '/api/v1/producto/' + id
    When method get
    Then status 404
    And match response.error == "Producto no encontrado"

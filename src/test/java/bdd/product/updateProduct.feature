@automation-api
Feature: Update products

  Background:
    * def responseLogin = call read('classpath:bdd/auth/loginAuth.feature@loginBackground')
    * def token = responseLogin.token
    Given header Authorization = 'Bearer ' + token
    And url urlBase

  @updateProduct1
  Scenario: Update a product
    * def id = 647
    * def body = read('classpath:resources/json/product/bodyUpdateProduct.json')
    Given url urlBase
    And path '/api/v1/producto/' + id
    And request body
    When method put
    Then status 200
    And match response.id == id
    And match response.updated_at == "#string"
    And match response.description == body.description

  @updateProduct2
  Scenario: Not successful updating a product
    * def id = 2700
    * def body = read('classpath:resources/json/product/bodyUpdateProduct.json')
    Given url urlBase
    And path '/api/v1/producto/' + id
    And request body
    When method put
    Then status 500
    And match response.error == "Call to a member function update() on null"

  @updateProduct3
  Scenario Outline: Not successful updating a product - errors
    * def id = 647
    Given url urlBase
    And path '/api/v1/producto/' + id
    And request body
    When method put
    Then status 500
    And match response.error == "#notnull"

    Examples:
      | read('classpath:resources/json/product/bodyUpdateProductErrors.json')|

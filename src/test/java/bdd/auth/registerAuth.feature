@automation-api
Feature: Register user

  @register1
  Scenario: Register user successful
    * def body = read('classpath:resources/json/auth/bodyRegister.json')
    * print body.nombre
    Given url urlBase
    And path '/api/register'
    And request body
    When method post
    Then status 200
    And match response.access_token == "#string"
    And match response.data.nombre == body.nombre
    And match response.data.email == body.email

  @register2
  Scenario: Register user not successful - incomplete
    Given url urlBase
    And path '/api/register'
    And form field nombre = 'Carolina'
    And form field tipo_usuario_id = 1
    And form field estado = 1
    When method post
    Then status 500
    And match response.email[0] == "The email field is required."
    And match response.password[0] == "The password field is required."

  @register3
  Scenario: Register user not successful - duplicate
    * def body =
    """
      {
          "email": "carotesting@gmail.com",
          "password": "12345678",
          "nombre": "Carolina",
          "tipo_usuario_id": 1,
          "estado": 1
      }
    """
    Given url urlBase
    And path '/api/register'
    And request body
    When method post
    Then status 500
    And match response.email[0] == "The email has already been taken."
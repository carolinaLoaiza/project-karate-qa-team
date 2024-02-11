@automation-api
Feature: Login

  @login1
  Scenario: Successful login
    Given url urlBase
    And path 'api/login'
    And request {email:"carotesting@gmail.com", password:"12345678"}
    When method post
    Then status 200
    And match response.access_token == "#string"
    And match response.user.email == "carotesting@gmail.com"

  @login2
  Scenario Outline: Successful login several users
    Given url urlBase
    And path 'api/login'
    And request {email:<email>, password:<password>}
    When method post
    Then status 200
    And match response.access_token == "#string"
    And match response.user.email == "<email>"

    Examples:
      | email                 | password |
      | carlosz@gmail.com     | 12345678 |
      | carotesting@gmail.com | 12345678 |

  @login3
  Scenario Outline: Not successful login several users
    Given url urlBase
    And path 'api/login'
    And form field email = '<email>'
    And form field password = '<password>'
    When method post
    Then status 401
    And match responseType == 'json'
    * print response
    And match response.message == "Datos incorrectos"

    Examples:
      | email                 | password |
      | carlosz@gmail.com     |          |
      | carotesting@gmail.com | 1234567  |

  @loginBackground
  Scenario: Successful login to use in the Background
    Given url urlBase
    And path 'api/login'
    And request {email:"carotesting@gmail.com", password:"12345678"}
    When method post
    Then status 200
    * def token = response.access_token

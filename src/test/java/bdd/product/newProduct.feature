@automation-api
Feature: Add new products

  Background:
    * def responseLogin = call read('classpath:bdd/auth/loginAuth.feature@loginBackground')
    * def token = responseLogin.token
    Given header Authorization = 'Bearer ' + token
    And url urlBase


  @newProduct1
  Scenario: Add a new product
    * def body = read('classpath:resources/json/product/bodyNewProduct.json')
    * print body.nombre
    Given url urlBase
    And path '/api/v1/producto'
    And request body
    When method post
    Then status 200
    And match response.nombre == body.nombre
    And match response.created_at == "#string"
    And match response.id == "#notnull"

  @newProduct2
  Scenario: Not successful adding a new product - duplicate
    * def body =
    """
      {
        "codigo": "CL0002",
        "nombre": "ALTERNADOR PL200NS - 2",
        "medida": "UND ",
        "marca": "Generico",
        "categoria": "Repuestos",
        "precio": "35.00",
        "stock": "48",
        "estado": "4",
        "descripcion": "ALTERNADOR PL200NS  - 2"
      }
    """
    * print body.nombre
    Given url urlBase
    And path '/api/v1/producto'
    And request body
    When method post
    Then status 500
    And match response.error contains "Duplicate entry"

  @newProduct3
  Scenario: Not successful adding a new product - long
    * def body =
    """
     {
      "codigo": "vcl0001",
      "nombre": "ALTERNADOR PL200NS - 2",
      "medida": "UND ",
      "marca": "Generico",
      "categoria": "Repuestos",
      "precio": "35.00",
      "stock": "48",
      "estado": "4",
      "descripcion": "ALTERNADOR PL200NS  - 2"
    }
    """
    * print body.nombre
    Given url urlBase
    And path '/api/v1/producto'
    And request body
    When method post
    Then status 500
    And match response.error contains "Data too long"

  @newProduct4
  Scenario: Not successful adding a new product - missing fields
    Given url urlBase
    And path '/api/v1/producto'
    And request  {"codigo": "CL0002"}
    When method post
    Then status 500
    And match response.nombre[0] == "The nombre field is required."
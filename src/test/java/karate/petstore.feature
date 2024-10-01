Feature: PetStore API Testing

  Background:
    * def baseUrl = 'https://petstore.swagger.io/v2/pet'
    * def petIdFilePath = 'test-classes/karate/petId.txt'

  Scenario: Add a pet to the store
    Given url baseUrl
    And request {"id": 0,"category": { "id": 0, "name": "string" },"name": "Fluffy","photoUrls": ["string"],"tags": [{ "id": 0, "name": "string" }],"status": "available"}
    When method post
    Then status 200
    # Guardar el ID de la respuesta
   * def petId = response.id
   * karate.write(petId, petIdFilePath)


  Scenario: Retrieve the pet by ID
   * def petId = karate.read('petId.txt')
    Given url baseUrl + '/' + petId
    When method get
    Then status 200
    And match response.name == 'Fluffy'
    And match response.status == 'available'

  Scenario: Update the pet's name and status to "sold"
  * def petId = karate.read('petId.txt')
     Given url baseUrl
        And request { "id": petId, "category": { "id": 0, "name": "string" }, "name": "FluffyUpdated", "photoUrls": ["string"], "tags": [{ "id": 0, "name": "string" }], "status": "sold" }
        When method put
        Then status 200

 Scenario: Find pet's status to "sold"
   Given url baseUrl + '/findByStatus'
   And param status = 'sold'
    When method get
    Then status 200
    And match response[0].name == 'FluffyUpdated'
    And match response[0].status == 'sold'
@REQ_TPSREM-435 @crearClienteTest @CrearClienteV5
Feature: Creacion de Nuevos Clientes

  Background:
    * url 'https://serviciosexternostest.pichincha.com:8080/api'
    * callonce read('Auth.feature@BasicAuth')
    * def body = read('classpath:../data/ejemplo/crearClienteBody.json')
    * def generarNuevoId = call read('classpath:../data/ejemplo/crearIDNuevoCliente2.js')

  @id:1 @CasoPositivo
  Scenario Outline: T-API-TPSREM-435-CA1-Crear un Usuario con <tipo_Id>
    Given path 'ORQClientes0038'
    * def IdGenerado = generarNuevoId('<tipo_Id>')
    * set body.CrearCliente23.bodyIn.usuario.identificacion = IdGenerado.identificacion
    * set body.CrearCliente23.bodyIn.usuario.tipoIdentificacion = IdGenerado.tipoIdentificacion
    * print body
    And request body
    When method post
    Then status 200
    * print response
    And match response.CrearCliente23Response.error.codigo == '0'
    And match response.CrearCliente23Response.error.mensaje == '#regex ^TCSBRKR[24]_BP:ISClientes:(2000|4000)-OK$'
    * def nuevoCIF = response.CrearCliente23Response.bodyOut.CIF
    Examples:
        | read('classpath:../data/ejemplo/data.csv') |

  @id:1 @CasoNegativo
  Scenario: T-API-TPSREM-435-CA1-Crear un Usuario con Cedula Existente
    Given path 'ORQClientes0038'
    And request body
    When method post
    Then status 200
    And match response.CrearCliente23Response.error.codigo == '3656'
    And match response.CrearCliente23Response.error.mensaje contains 'LA ID YA EXISTE EN EL ARCHIVO'
#Etiqueta que identifica el propósito general de esta feature
#En este caso para autenticaciones genéricas
@AuthenticationGeneric
  #Titulo descriptivo de la feature, implementar una auth basica
  Feature: Basic Auth

  #Etiqueta adicional para identificar este tipo especifico de autenticación
  @BasicAuth
  #Descripción del escenario
  Scenario: Basic Authentication
    #Definimos una variable headers como un objeto json donde insertamos dinámicamente el token
    #obtenido del entorno usando la sintaxis especial '#(token)' evitando que el valor este quemado en el script
    * def headers = { "Content-Type": 'application/json', "Authorization": '#(token)' }
    #Aplicamos globalmente el objeto headers como configuracion para que todos los requests que se envien despues
    #usen automaticamente el content type y authorization definidos
    * configure headers = headers
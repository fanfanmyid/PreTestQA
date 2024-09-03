*** Settings ***
Library    RequestsLibrary
Library    Collections
Suite Setup    Create API Session
Suite Teardown    Delete All Sessions

*** Variables ***
${BASE_URL}    https://reqres.in/api

*** Keywords ***
Create API Session
    Create Session    reqres    ${BASE_URL}    verify=False

    

*** Test Cases ***
Get Single User
    [Tags]    GetUser
    Given I have the endpoint /users/2
    When I send a GET request to the endpoint
    Then the status code should be 200
    And the response should contain the user's details

Create User
    [Tags]    CreateUser
    Given I have the endpoint /users
    And I have the user data with name "Fandly" and job "QA Engineer"
    When I send a POST request to the endpoint with the user data
    Then the status code should be 201
    And the response should contain the user id and createdAt


*** Keywords ***
Given I have the endpoint /users/2
    Set Test Variable    ${ENDPOINT}    /users/2

When I send a GET request to the endpoint
    ${response}=    GET On Session    reqres    ${ENDPOINT}
    Set Test Variable    ${RESPONSE}    ${response}

Then the status code should be 200
    Log    ${RESPONSE.status_code}
    Should Be Equal As Numbers    ${RESPONSE.status_code}    200

And the response should contain the user's details
    ${user}=    Get From Dictionary    ${RESPONSE.json()}    data
    Should Not Be Empty    ${user}
    Log    User Details: ${user}

Given I have the endpoint /users
    Set Test Variable    ${ENDPOINT}    /users

And I have the user data with name "Fandly" and job "QA Engineer"
    ${user_data}=    Create Dictionary    name=Fandly    job=QA Engineer
    Set Test Variable    ${USER_DATA}    ${user_data}

When I send a POST request to the endpoint with the user data
    ${response}=    POST On Session   reqres    ${ENDPOINT}    json=${USER_DATA}
    Set Test Variable    ${RESPONSE}    ${response}

Then the status code should be 201
    Log    ${RESPONSE.status_code}
    Should Be Equal As Numbers    ${RESPONSE.status_code}    201

And the response should contain the user id and createdAt
    ${id}=    Get From Dictionary    ${RESPONSE.json()}    id
    ${createdAt}=    Get From Dictionary    ${RESPONSE.json()}    createdAt
    Should Not Be Empty    ${id}
    Should Not Be Empty    ${createdAt}
    Log    Created User ID: ${id}
    Log    Created At: ${createdAt}

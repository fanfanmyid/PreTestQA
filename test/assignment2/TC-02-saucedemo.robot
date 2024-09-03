*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}          https://www.saucedemo.com
${BROWSER}      Chrome
${USERNAME}     standard_user
${PASSWORD}     secret_sauce

*** Test Cases ***
User Checkout Journey
    [Tags]    SmokeTest    Checkout
    Given The user is on the login page
    When The user logs in with valid credentials
    Then The user adds an item to the cart
    And The user proceeds to checkout
    And The user fills in the checkout information
    And The user completes the purchase
    Then The user should see the order confirmation

*** Keywords ***
The user is on the login page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

The user logs in with valid credentials
    Input Text    id:user-name    ${USERNAME}
    Input Text    id:password     ${PASSWORD}
    Click Button  id:login-button
    Wait Until Page Contains Element    id:inventory_container

The user adds an item to the cart
    Click Button    id:add-to-cart-sauce-labs-backpack
    Click Element   id:shopping_cart_container
    Wait Until Page Contains Element    class:cart_item

The user proceeds to checkout
    Click Button    id:checkout
    Wait Until Page Contains Element    id:checkout_info_container

The user fills in the checkout information
    Input Text    id:first-name    Fandly
    Input Text    id:last-name     Fr
    Input Text    id:postal-code   12345
    Click Button  id:continue
    Wait Until Page Contains Element    class:summary_info

The user completes the purchase
    Click Button    id:finish
    Wait Until Page Contains Element    id:checkout_complete_container

The user should see the order confirmation
    Page Should Contain Element    xpath://h2[text()='Thank you for your order!']
    Capture Page Screenshot
    Close Browser

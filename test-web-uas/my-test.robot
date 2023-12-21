*** Settings ***
Library            SeleniumLibrary
#Suite Setup        Open Browser        ${URL}    ${BROWSER}
#Suite Teardown     Close All Browsers


*** Variables ***
${URL}          https://www.saucedemo.com/
${BROWSER}      headlessfirefox

${USERNAME}     standard_user
${PASSWORD}     secret_sauce
${PASSWORD2}    abcde12345


*** Keywords ***
Login
    Open Browser                      ${URL}    ${BROWSER}
    Wait Until Element Is Visible     xpath://input[@name='user-name']
    Input Text    name:user-name      ${USERNAME}
    Input Text    name:password       ${PASSWORD}
    Submit Form
    Page Should Contain Element       xpath://div[@id="shopping_cart_container"]
    Sleep         2    

# Logout
#     Click Button                   id:react-burger-menu-btn
#     Click Link                     id:logout_sidebar_link
#     Page Should Contain Element    xpath://div[@id="login_button_container"]

Cart
    Login    
    Click Button    id:add-to-cart-sauce-labs-bike-light
    Click Button    id:add-to-cart-sauce-labs-fleece-jacket
    Click Element   class:shopping_cart_link
    Sleep           2

*** Test Cases ***
# Login
# Positif Test
login-success
    Login
    Close Browser
    

# Negatif Test
login-fail
    Open Browser                      ${URL}    ${BROWSER}
    Wait Until Element Is Visible     xpath://input[@name='user-name']
    Input Text    name:user-name      ${USERNAME}
    Input Text    name:password       ${PASSWORD2}
    Submit Form
    Page Should Not Contain Element   xpath://div[@id="shopping_cart_container"]
    Close Browser

# Logout
logout
    Login
    Click Button                   id:react-burger-menu-btn
    Click Link                     id:logout_sidebar_link
    Page Should Contain Element    xpath://div[@id="login_button_container"]
    Close Browser
    

# Add to Cart
add-cart
    Cart
    Close Browser

# Delete Cart
delete-cart
    Cart
    Click Element   class:shopping_cart_link
    Click Button    id:remove-sauce-labs-bike-light
    Click Button    id:remove-sauce-labs-fleece-jacket
    Close Browser

# Checkout
checkout
    Cart
    Click Button                   id:checkout
    Page Should Contain Element    xpath://div[@id="checkout_info_container"]
    Sleep         2
    Input Text    id:first-name    demo123
    Input Text    id:last-name     demo123
    Input Text    id:postal-code   112233
    Submit Form
    Page Should Contain Element    xpath://div[@id="checkout_summary_container"]
    Sleep         2
    Execute JavaScript             window.scrollTo(0, document.body.scrollHeight)
    Click Button                   id:finish
    Page Should Contain Element    xpath://div[@id="checkout_complete_container"]
    Sleep         2
    Close Browser
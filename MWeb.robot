
*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}  Chrome
${URL}  https://www.practo.com
${SEARCH_BOX}  //div[@class='search-bar-text']
${DOCSEARCH_BOX}   //input[@data-qa-id='omni-searchbox-keyword']
${LOCATION_SELECTION}  //input[@data-qa-id='omni-searchbox-locality']
${SEARCH_TERM}  dentist
${LOCATION}  (//div[@data-qa-id="omni-suggestion-city"])[1]
${DOC_SEARCH_SUGGESTION}   (//div[@data-qa-id='omni-suggestion-listing'])[1]
${DOCTOR_LIST}  (//h2[@data-qa-id='doctor_name'])[1]
${TIME_SLOT}  (//span[@class="slot offline-book"])[1]
${TOMORROW_TAB}  //span[contains(text(),'tomorrow')]

*** Test Cases ***
Booking appointment of Third doctor
    [Documentation]  This test searches for a dentist in Practo's mobile web version and books an available appointment with the third listed doctor.
    [Tags]  Practo  Booking  Dentist  MobileTest
    Open Browser  ${URL}  ${BROWSER}  options=add_experimental_option("mobileEmulation", {"deviceName": "iPhone X"})

    Wait Until Element Is Visible  ${SEARCH_BOX}  timeout=15s
    Click Element  ${SEARCH_BOX}

    Wait Until Element Is Visible  ${LOCATION}  timeout=10s
    Click Element  ${LOCATION}

    Wait Until Element Is Visible  ${DOCSEARCH_BOX}  timeout=10s
    Click Element  ${DOCSEARCH_BOX}
    Input Text  ${DOCSEARCH_BOX}  ${SEARCH_TERM}
    Wait Until Element Is Visible  ${DOC_SEARCH_SUGGESTION}  timeout=10s
    Click Element  ${DOC_SEARCH_SUGGESTION}

    Scroll Element Into View  ${DOCTOR_LIST}
    Wait Until Element Is Visible  ${DOCTOR_LIST}  timeout=10s
    Click Element  ${DOCTOR_LIST}

    Wait Until Element Is Visible  ${TIME_SLOT}  timeout=5s
    ${is_slot_available}  Run Keyword And Return Status  Element Should Be Visible  ${TIME_SLOT}  timeout=10s
    IF  '${is_slot_available}' == 'False'
        Click Element  ${TOMORROW_TAB}
        Wait Until Element Is Visible  ${TIME_SLOT}  timeout=5s
    END
    Click Element  ${TIME_SLOT}

    Sleep  5
    Close Browser

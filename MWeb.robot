MWEB Code:

*** Settings ***
Library    SeleniumLibrary
*** Variables ***
${BROWSER}             Chrome
${URL}                 https://www.practo.com
${SEARCH_TERM}         Dentist
${SEARCH_BOX}          //div[@class='search-bar-text']
${LOCSEARCH_BOX}       //input[@data-qa-id='omni-searchbox-locality']
${LOC_SUGGESTION}      (//div[@data-qa-id='omni-suggestion-main'])[1]
${DOCSEARCH_BOX}       //input[@data-qa-id='omni-searchbox-keyword']
${DOC_SEARCH_SUGGESTION}  //div[@data-qa-id='omni-suggestion-listing']//div[@data-qa-id='omni-suggestion-main' and text()='Dentist']
${DOCTOR_LIST}         (//h2[@data-qa-id='doctor_name'])[2]
${BOOK_BUTTON}         (//div[@data-qa-id='cta_offline_book' and text()='Book Clinic Visit'])
${TIME_SLOT}           (//span[@data-qa-id='timeslot_available'])[1]
${TOMORROW_TAB}        (//div[@class="c-appointment-slots__day-selector__list"]/div[2])
*** Test Cases ***
Booking appointment of Third doctor
    Open Browser    ${URL}    ${BROWSER}    options=add_experimental_option("mobileEmulation", {"deviceName": "iPhone X"})
    Wait Until Element Is Visible    ${SEARCH_BOX}    timeout=15s
    Click Element   ${SEARCH_BOX}
    Wait Until Element Is Visible    ${LOCSEARCH_BOX}    timeout=15s
    Click Element  ${LOCSEARCH_BOX}
    Wait Until Element Is Visible    ${LOC_SUGGESTION}    timeout=5s
    Click Element  ${LOC_SUGGESTION}
    Wait Until Element Is Visible    ${DOCSEARCH_BOX}    timeout=5s
    Click Element  ${DOCSEARCH_BOX}
    Sleep  3
    Input Text    ${DOCSEARCH_BOX}    ${SEARCH_TERM}
    Click Element  ${DOC_SEARCH_SUGGESTION}
    Sleep  5
    Scroll Element Into View    ${DOCTOR_LIST}
    Wait Until Element Is Visible    ${DOCTOR_LIST}    timeout=10s
    Click Element    ${DOCTOR_LIST}
    Sleep  2
    Wait Until Element Is Visible    ${BOOK_BUTTON}    timeout=10s
    Click Element    ${BOOK_BUTTON}
    Sleep  5
    ${is_slot_available}    Run Keyword And Return Status    Element Should Be Visible    ${TIME_SLOT}    timeout=5s
    IF    '${is_slot_available}' == 'False'
        Click Element    ${TOMORROW_TAB}
        Wait Until Element Is Visible    ${TIME_SLOT}    timeout=5s
    END
    Click Element    ${TIME_SLOT}
    Sleep  5
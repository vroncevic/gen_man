#!/bin/bash
#
# @brief   Generate and install man page
# @version ver.2.0
# @date    Sun 05 Dec 2021 06:09:13 PM CET
# @company None, free software to use 2021
# @author  Vladimir Roncevic <elektron.ronca@gmail.com>
#

#
# @brief  Display logo
# @param  Additional shifter - new tab which should be added
# @retval None
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# center 0
#
function center {
    local ADDITIONAL_SHIFTER=$1
    local START_POSITION=$((${CONSOLE_WIDTH} / 2 - 21))
    local NUMBER_OF_TABS=$((
        ${START_POSITION} / 4 - 1 + ${ADDITIONAL_SHIFTER}
    ))
    local TAB="$(printf '\011')"
    for ((I = 0; I <= ${NUMBER_OF_TABS}; I++))
    do
        printf "${TAB}"
    done
}

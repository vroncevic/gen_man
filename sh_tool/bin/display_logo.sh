#!/bin/bash
#
# @brief   Apache Tomcat Server Manager
# @version ver.2.0
# @date    Sat Nov 20 11:40:40 CET 2021
# @company None, free software to use 2021
# @author  Vladimir Roncevic <elektron.ronca@gmail.com>
#

#
# @brief  Display logo
# @param  None
# @retval None
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# display_logo
#
function display_logo {
    local info_url='https://vroncevic.github.io/atmanager'
    local info_txt='github.io/atmanager'
    local issue_url='https://github.com/vroncevic/atmanager/issues/new/choose'
    local issue_txt='github.io/issue'
    local author_url='https://vroncevic.github.io/bio/'
    local author_txt='vroncevic.github.io'
    while IFS= read -r line
    do
        center 0
        printf "%s\n" "$line"
    done < ${ATMANAGER_LOGO}
    center 2
    printf "Info   "
    printf "\e]8;;${info_url}\a${info_txt}\e]8;;\a"
    printf " ${ATMANAGER_VERSION} \n"
    center 2
    printf "Issue  "
    printf "\e]8;;${issue_url}\a${issue_txt}\e]8;;\a"
    printf "\n"
    center 2
    printf "Author "
    printf "\e]8;;${author_url}\a${author_txt}\e]8;;\a"
    printf "\n\n"
}
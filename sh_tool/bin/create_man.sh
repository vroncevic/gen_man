#!/bin/bash
#
# @brief   Creating Man Page
# @version ver.4.0
# @date    Tue Feb  7 08:49:43 CET 2017
# @company None, free software to use 2017
# @author  Vladimir Roncevic <elektron.ronca@gmail.com>
#
UTIL_ROOT=/root/scripts
UTIL_VERSION=ver.1.0
UTIL=${UTIL_ROOT}/sh_util/${UTIL_VERSION}
UTIL_LOG=${UTIL}/log

.    ${UTIL}/bin/usage.sh

GEN_MAN_TOOL=gen_man
GEN_MAN_VERSION=ver.4.0
GEN_MAN_HOME=${UTIL_ROOT}/${GEN_MAN_TOOL}/${GEN_MAN_VERSION}

declare -A GEN_MAN_CREATE_USAGE=(
    [USAGE_TOOL]="${GEN_MAN_TOOL}"
    [USAGE_ARG1]="[TOOL NAME] Tool name"
    [USAGE_ARG2]="[TEMPLATE PATH] Template file path"
    [USAGE_ARG3]="[AUTHOR EMAIL] Author's email"
    [USAGE_EX_PRE]="# Example create new man page for ldap script"
    [USAGE_EX]="$ __create_man mytool man.template john.doe@example.org"
)

#
# @brief  Creating Man Page
# @params Name of man page file, without, template file name and author's email
# @retval Success return $SUCCESS (0), else return $NOT_SUCCESS (1)
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# local MAN_NAME="mytool"
# local TEMPLATE_PATH="man.template"
# local AUTHOR_EMAIL="john.doe@example.org"
#
# __create_man "$MAN_NAME" "$TEMPLATE_PATH" "$AUTHOR_EMAIL"
# local STATUS=$?
#
# if [ $STATUS -eq $SUCCESS ]; then
#    echo "Man page created successfully: ${MAN_NAME}.1"
# else
#    echo "Failed to create man page."
# fi
#
function __create_man {
    local MFILE=$1 MT=$2 AUTHOR=$3
    local FUNC=${FUNCNAME[0]} MSG="None" DATE=`date` ML
    if [[ -z "${MFILE}" || -z "${MT}" || -z "${AUTHOR}" ]]; then
        usage GEN_MAN_CREATE_USAGE
        return $NOT_SUCCESS
    fi
    MSG="Creating man page!"
    info_debug_message "$MSG" "$FUNC" "$GEN_MAN_TOOL"
    local MTF="${GEN_MAN_HOME}/conf/${MT}"
    MSG="Generating file [${MFILE}.1]"
    info_debug_message "$MSG" "$FUNC" "$GEN_MAN_TOOL"
    while read ML
    do
        eval echo "${ML}" >> ${MFILE}.1
    done < ${MTF}
    MSG="Set permission!"
    info_debug_message "$MSG" "$FUNC" "$GEN_MAN_TOOL"
    eval "chmod 755 ${MFILE}.1"
    info_debug_message_end "Done" "$FUNC" "$GEN_MAN_TOOL"
    return $SUCCESS
}


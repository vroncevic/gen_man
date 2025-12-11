#!/bin/bash
#
# @brief   Install Man Page
# @version ver.4.0
# @date    Tue Feb  7 08:49:43 CET 2017
# @company None, free software to use 2017
# @author  Vladimir Roncevic <elektron.ronca@gmail.com>
#
UTIL_ROOT=/root/scripts
UTIL_VERSION=ver.1.0
UTIL=${UTIL_ROOT}/sh_util/${UTIL_VERSION}
UTIL_LOG=${UTIL}/log

.    ${UTIL}/bin/check_tool.sh

GEN_MAN_TOOL=gen_man

declare -A GEN_MAN_INSTALL_USAGE=(
    [USAGE_TOOL]="${GEN_MAN_TOOL}"
    [USAGE_ARG1]="[TOOL NAME] Tool name"
    [USAGE_ARG2]="[INSTALL TOOL] Install tool path"
    [USAGE_ARG3]="[]HOME PAGES] Home pages path"
    [USAGE_EX_PRE]="# Example install new man page for ldap script"
    [USAGE_EX]="__install_man ldapaddman.1 /usr/bin/install /usr/share"
)

#
# @brief  Install Man page
# @params Name of man page file, install tool path and home pages path
# @retval Success return $SUCCESS (0), else return $NOT_SUCCESS (1)
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __install_man "ldapaddman.1" "/usr/bin/install" "/usr/share/man/man1"
# local STATUS=$?
#
# if [ $STATUS -eq $SUCCESS ]; then
#    # true
# else
#    # false
# fi
#
function __install_man {
    local MFILE=$1 INSTALL=$2 HPAGES=$3
    local FUNC=${FUNCNAME[0]} MSG="None" STATUS
    if [[ -z "${MFILE}" || -z "${INSTALL}" || -z "${HPAGES}" ]]; then
        usage GEN_MAN_INSTALL_USAGE
        return $NOT_SUCCESS
    fi
    MSG="Installing man page!"
    info_debug_message "$MSG" "$FUNC" "$GEN_MAN_TOOL"
    if [ ! -e "${MFILE}" ]; then
        MSG="Check file [${MFILE}]"
        info_debug_message "$MSG" "$FUNC" "$GEN_MAN_TOOL"
        MSG="Force exit!"
        info_debug_message_end "$MSG" "$FUNC" "$GEN_MAN_TOOL"
        return $NOT_SUCCESS
    fi
    if [ -d "${HPAGES}/" ]; then
        check_tool "${INSTALL}"
        STATUS=$?
        if [ $STATUS -eq $SUCCESS ]; then
            eval "${INSTALL} -g 0 -o 0 -m 0644 ${MFILE} ${HPAGES}/"
            gzip "${HPAGES}/${MFILE}"
            info_debug_message_end "Done" "$FUNC" "$GEN_MAN_TOOL"
            return $SUCCESS
        fi
        cp ${MFILE} "${HPAGES}/${MFILE}"
        gzip "${HPAGES}/${MFILE}"
        info_debug_message_end "Done" "$FUNC" "$GEN_MAN_TOOL"
        return $SUCCESS
    fi
    MSG="Check directory [${HPAGES}/]"
    info_debug_message "$MSG" "$FUNC" "$GEN_MAN_TOOL"
    MSG="Force exit!"
    info_debug_message_end "$MSG" "$FUNC" "$GEN_MAN_TOOL"
    return $NOT_SUCCESS
}


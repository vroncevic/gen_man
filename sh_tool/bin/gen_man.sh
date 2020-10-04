#!/bin/bash
#
# @brief   Generate and install man page
# @version ver.1.0.0
# @date    Tue Feb  7 08:49:43 CET 2017
# @company None, free software to use 2017
# @author  Vladimir Roncevic <elektron.ronca@gmail.com>
#
UTIL_ROOT=/root/scripts
UTIL_VERSION=ver.1.0
UTIL=${UTIL_ROOT}/sh_util/${UTIL_VERSION}
UTIL_LOG=${UTIL}/log

.    ${UTIL}/bin/devel.sh
.    ${UTIL}/bin/usage.sh
.    ${UTIL}/bin/check_root.sh
.    ${UTIL}/bin/check_tool.sh
.    ${UTIL}/bin/logging.sh
.    ${UTIL}/bin/load_conf.sh
.    ${UTIL}/bin/load_util_conf.sh
.    ${UTIL}/bin/progress_bar.sh

GEN_MAN_TOOL=genman
GEN_MAN_VERSION=ver.1.0
GEN_MAN_HOME=${UTIL_ROOT}/${GEN_MAN_TOOL}/${GEN_MAN_VERSION}
GEN_MAN_CFG=${GEN_MAN_HOME}/conf/${GEN_MAN_TOOL}.cfg
GEN_MAN_UTIL_CFG=${GEN_MAN_HOME}/conf/${GEN_MAN_TOOL}_util.cfg
GEN_MAN_LOG=${GEN_MAN_HOME}/log

.    ${GEN_MAN_HOME}/bin/install_man.sh
.    ${GEN_MAN_HOME}/bin/create_man.sh

declare -A GEN_MAN_Usage=(
    [Usage_TOOL]="${GEN_MAN_TOOL}"
    [Usage_ARG1]="[OPERATION] Create | install man page"
    [Usage_ARG2]="[MAN FILE] Filename of man page"
    [Usage_EX_PRE]="# Example create new man page for ldap script"
    [Usage_EX]="${GEN_MAN_TOOL} create ldapaddman"
)

declare -A GEN_MAN_LOGGING=(
    [LOG_TOOL]="${GEN_MAN_TOOL}"
    [LOG_FLAG]="info"
    [LOG_PATH]="${GEN_MAN_LOG}"
    [LOG_MSGE]="None"
)

declare -A PB_STRUCTURE=(
    [BW]=50
    [MP]=100
    [SLEEP]=0.01
)

TOOL_DBG="false"
TOOL_LOG="false"
TOOL_NOTIFY="false"

#
# @brief  Main function
# @params Values required option and file name
# @retval Function __gen_man exit with integer value
#            0   - tool finished with success operation
#            128 - missing argument(s) from cli
#            129 - failed to load tool script configuration from files
#            130 - failed to create man page
#            131 - failed to install man page
#            132 - not implemented option
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __gen_man "create" "ldapaddman"
# local STATUS=$?
#
# if [ $STATUS -eq $SUCCESS ]; then
#    # true
# else
#    # false
# fi
#
function __gen_man {
    local OP=$1 MFILE=$2
    if [[ -n "${OP}" && -n "${MFILE}" ]]; then
        local FUNC=${FUNCNAME[0]} MSG="None"
        local STATUS_CONF STATUS_CONF_UTIL STATUS
        MSG="Loading basic and util configuration!"
        info_debug_message "$MSG" "$FUNC" "$GEN_MAN_TOOL"
        progress_bar PB_STRUCTURE
        declare -A config_gen_man=()
        load_conf "$GEN_MAN_CFG" config_gen_man
        STATUS_CONF=$?
        declare -A config_gen_man_util=()
        load_util_conf "$GEN_MAN_UTIL_CFG" config_gen_man_util
        STATUS_CONF_UTIL=$?
        declare -A STATUS_STRUCTURE=(
            [1]=$STATUS_CONF [2]=$STATUS_CONF_UTIL
        )
        check_status STATUS_STRUCTURE
        STATUS=$?
        if [ $STATUS -eq $NOT_SUCCESS ]; then
            MSG="Force exit!"
            info_debug_message_end "$MSG" "$FUNC" "$GEN_MAN_TOOL"
            exit 129
        fi
        TOOL_LOG=${config_gen_man[LOGGING]}
        TOOL_DBG=${config_gen_man[DEBUGGING]}
        TOOL_NOTIFY=${config_gen_man[EMAILING]}
        if [ "${OP}" == "create" ]; then
            __create_man ${MFILE}
            STATUS=$?
            if [ $STATUS -eq $NOT_SUCCESS ]; then
                MSG="Force exit!"
                info_debug_message_end "$MSG" "$FUNC" "$GEN_MAN_TOOL"
                exit 130
            fi
            MSG="Created MAN Page: ${MFILE}.1"
            GEN_MAN_LOGGING[LOG_MSGE]=$MSG
            logging GEN_MAN_LOGGING
        elif [ "${OP}" == "install" ]; then
            __install_man ${MFILE}
            STATUS=$?
            if [ $STATUS -eq $NOT_SUCCESS ]; then
                MSG="Force exit!"
                info_debug_message_end "$MSG" "$FUNC" "$GEN_MAN_TOOL"
                exit 131
            fi
            MSG="Installed MAN Page: ${MFILE}.1"
            GEN_MAN_LOGGING[LOG_MSGE]=$MSG
            logging GEN_MAN_LOGGING
        else
            MSG="Not supported option [${OP}]"
            info_debug_message "$MSG" "$FUNC" "$GEN_MAN_TOOL"
            MSG="Force exit!"
            info_debug_message_end "$MSG" "$FUNC" "$GEN_MAN_TOOL"
            exit 132
        fi
        exit 0
    fi
    usage GEN_MAN_Usage
    exit 128
}

#
# @brief   Main entry point
# @params  Values required option and file name
# @exitval Script tool genman exit with integer value
#            0   - tool finished with success operation
#            127 - run tool script as root user from cli
#            128 - missing argument(s) from cli
#            129 - failed to load tool script configuration from files
#            130 - failed to create man page
#            131 - failed to install man page
#            132 - not implemented option
#
printf "\n%s\n%s\n\n" "${GEN_MAN_TOOL} ${GEN_MAN_VERSION}" "`date`"
check_root
STATUS=$?
if [ $STATUS -eq $SUCCESS ]; then
    __gen_man $1 $2
fi

exit 127


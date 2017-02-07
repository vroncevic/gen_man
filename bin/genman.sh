#!/bin/bash
#
# @brief   Generate and install man page
# @version ver.1.0
# @date    Tue Feb  7 08:49:43 CET 2017
# @company None, free software to use 2017
# @author  Vladimir Roncevic <elektron.ronca@gmail.com>
#
UTIL_ROOT=/root/scripts
UTIL_VERSION=ver.1.0
UTIL=${UTIL_ROOT}/sh_util/${UTIL_VERSION}
UTIL_LOG=${UTIL}/log

.	${UTIL}/bin/devel.sh
.	${UTIL}/bin/usage.sh
.	${UTIL}/bin/check_root.sh
.	${UTIL}/bin/check_tool.sh
.	${UTIL}/bin/logging.sh
.	${UTIL}/bin/load_conf.sh
.	${UTIL}/bin/load_util_conf.sh
.	${UTIL}/bin/progress_bar.sh

GENMAN_TOOL=genman
GENMAN_VERSION=ver.1.0
GENMAN_HOME=${UTIL_ROOT}/${GENMAN_TOOL}/${GENMAN_VERSION}
GENMAN_CFG=${GENMAN_HOME}/conf/${GENMAN_TOOL}.cfg
GENMAN_UTIL_CFG=${GENMAN_HOME}/conf/${GENMAN_TOOL}_util.cfg
GENMAN_LOG=${GENMAN_HOME}/log

.	${GENMAN_HOME}/bin/install_man.sh
.	${GENMAN_HOME}/bin/create_man.sh

declare -A GENMAN_USAGE=(
	[USAGE_TOOL]="__${GENMAN_TOOL}"
	[USAGE_ARG1]="[OP] Create | install man page"
	[USAGE_ARG2]="[MAN FILE] Filename of man page"
	[USAGE_EX_PRE]="# Example create new man page for ldap script"
	[USAGE_EX]="__${GENMAN_TOOL} create ldapaddman.1"
)

declare -A GENMAN_LOGGING=(
	[LOG_TOOL]="${GENMAN_TOOL}"
	[LOG_FLAG]="info"
	[LOG_PATH]="${GENMAN_LOG}"
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
# @retval Function __genman exit with integer value
#			0   - tool finished with success operation
#			128 - missing argument(s) from cli
#			129 - failed to load tool script configuration from files
#			130 - failed to create man page
#			131 - failed to install man page
#			132 - not implemented option
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __genman "create" "ldapaddman.1"
# local STATUS=$?
#
# if [ $STATUS -eq $SUCCESS ]; then
#	# true
# else
#	# false
# fi
#
function __genman() {
	local OP=$1 MFILE=$2
	if [[ -n "${OP}" && -n "${MFILE}" ]]; then
		local FUNC=${FUNCNAME[0]} MSG="None" STATUS_CONF STATUS_CONF_UTIL STATUS
		MSG="Loading basic and util configuration!"
		__info_debug_message "$MSG" "$FUNC" "$GENMAN_TOOL"
		__progress_bar PB_STRUCTURE
		declare -A config_genman=()
		__load_conf "$GENMAN_CFG" config_genman
		STATUS_CONF=$?
		declare -A config_genman_util=()
		__load_util_conf "$GENMAN_UTIL_CFG" config_genman_util
		STATUS_CONF_UTIL=$?
		declare -A STATUS_STRUCTURE=(
			[1]=$STATUS_CONF [2]=$STATUS_CONF_UTIL
		)
		__check_status STATUS_STRUCTURE
		STATUS=$?
		if [ $STATUS -eq $NOT_SUCCESS ]; then
			MSG="Force exit!"
			__info_debug_message_end "$MSG" "$FUNC" "$GENMAN_TOOL"
			exit 129
		fi
		TOOL_LOG=${config_genman[LOGGING]}
		TOOL_DBG=${config_genman[DEBUGGING]}
		TOOL_NOTIFY=${config_genman[EMAILING]}
		if [ "${OP}" == "create" ]; then
			__create_man ${MFILE}
			STATUS=$?
			if [ $STATUS -eq $NOT_SUCCESS ]; then
				MSG="Force exit!"
				__info_debug_message_end "$MSG" "$FUNC" "$GENMAN_TOOL"
				exit 130
			fi
		elif [ "${OP}" == "install" ]; then
			__install_man ${MFILE}
			STATUS=$?
			if [ $STATUS -eq $NOT_SUCCESS ]; then
				MSG="Force exit!"
				__info_debug_message_end "$MSG" "$FUNC" "$GENMAN_TOOL"
				exit 131
			fi
		else
			MSG="Not supported option [${OP}]"
			__info_debug_message "$MSG" "$FUNC" "$GENMAN_TOOL"
			MSG="Force exit!"
			__info_debug_message_end "$MSG" "$FUNC" "$GENMAN_TOOL"
			exit 132
		fi
		exit 0
	fi
	__usage GENMAN_USAGE
	exit 128
}

#
# @brief   Main entry point
# @params  Values required option and file name
# @exitval Script tool genman exit with integer value
#			0   - tool finished with success operation
# 			127 - run tool script as root user from cli
#			128 - missing argument(s) from cli
#			129 - failed to load tool script configuration from files
#			130 - failed to create man page
#			131 - failed to install man page
#			132 - not implemented option
#
printf "\n%s\n%s\n\n" "${GENMAN_TOOL} ${GENMAN_VERSION}" "`date`"
__check_root
STATUS=$?
if [ $STATUS -eq $SUCCESS ]; then
	__genman $1 $2
fi

exit 127


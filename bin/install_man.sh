#!/bin/bash
#
# @brief   Install Man Page
# @version ver.1.0
# @date    Tue Feb  7 08:49:43 CET 2017
# @company None, free software to use 2017
# @author  Vladimir Roncevic <elektron.ronca@gmail.com>
#

#
# @brief  Install Man page
# @param  Value required name of man file
# @retval Success return 0, else return 1
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __install_man "ldapaddman"
# local STATUS=$?
#
# if [ $STATUS -eq $SUCCESS ]; then
#	# true
# else
#	# false
# fi
#
function __install_man() {
	local MFILE=$1 FUNC=${FUNCNAME[0]} MSG="None" STATUS
	if [ -n "${MFILE}" ]; then
		MSG="Installing man page!"
		__info_debug_message "$MSG" "$FUNC" "$GENMAN_TOOL"
		if [ ! -e "${MFILE}" ]; then
			MSG="Check file [${MFILE}.1]"
			__info_debug_message "$MSG" "$FUNC" "$GENMAN_TOOL"
			MSG="Force exit!"
			__info_debug_message_end "$MSG" "$FUNC" "$GENMAN_TOOL"
			return $NOT_SUCCESS
		fi
		local INSTALL=${config_genman_util[INSTALL]}
		local HPAGES=${config_genman_util[MAN_HOME_PAGES]}
		if [ -d "${HPAGES}/" ]; then
			__check_tool "${INSTALL}"
			STATUS=$?
			if [ $STATUS -eq $SUCCESS ]; then
				eval "${INSTALL} -g 0 -o 0 -m 0644 ${MFILE}.1 ${HPAGES}/"
				gzip "${HPAGES}/${MFILE}.1"
				__info_debug_message_end "Done" "$FUNC" "$GENMAN_TOOL"
				return $SUCCESS
			fi
			cp ${MFILE}.1 "${HPAGES}/${MFILE}.1"
			gzip "${HPAGES}/${MFILE}.1"
			__info_debug_message_end "Done" "$FUNC" "$GENMAN_TOOL"
			return $SUCCESS
		fi
		MSG="Check directory [${HPAGES}/]"
		__info_debug_message "$MSG" "$FUNC" "$GENMAN_TOOL"
		MSG="Force exit!"
		__info_debug_message_end "$MSG" "$FUNC" "$GENMAN_TOOL"
		return $NOT_SUCCESS
	fi
	MSG="Provide argument [MAN FILE]"
	__info_debug_message "$MSG" "$FUNC" "$GENMAN_TOOL"
	MSG="Force exit!"
	__info_debug_message_end "$MSG" "$FUNC" "$GENMAN_TOOL"
	return $NOT_SUCCESS
}


#!/bin/bash
#
# @brief   Creating Man Page
# @version ver.1.0
# @date    Tue Feb  7 08:49:43 CET 2017
# @company None, free software to use 2017
# @author  Vladimir Roncevic <elektron.ronca@gmail.com>
#

#
# @brief  Creating Man Page
# @param  Value required name of man file
# @retval Success return 0, else return 1
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __create_man "ldapaddman"
# local STATUS=$?
#
# if [ $STATUS -eq $SUCCESS ]; then
#	# true
# else
#	# false
# fi
#
function __create_man() {
	local MFILE=$1 FUNC=${FUNCNAME[0]} MSG="None" DATE=`date` ML
	if [ -n "${MFILE}" ]; then
		MSG="Creating man page!"
		__info_debug_message "$MSG" "$FUNC" "$GENMAN_TOOL"
		local MT=${config_genman_util[MAN_PAGE]}
		local MTF="${GENMAN_HOME}/conf/${MT}"
		local AUTHOR=${config_genman_util[AUTHOR]}
		MSG="Generating file [${MFILE}.1]"
		__info_debug_message "$MSG" "$FUNC" "$GENMAN_TOOL"
		while read ML
		do
			eval echo "${ML}" >> ${MFILE}.1
		done < ${MTF}
		MSG="Set permission!"
		__info_debug_message "$MSG" "$FUNC" "$GENMAN_TOOL"
		eval "chmod 755 ${MFILE}.1"
		__info_debug_message_end "Done" "$FUNC" "$GENMAN_TOOL"
		return $SUCCESS
	fi
	MSG="Provide argument [MAN FILE]"
	__info_debug_message "$MSG" "$FUNC" "$GENMAN_TOOL"
	MSG="Force exit!"
	__info_debug_message_end "$MSG" "$FUNC" "$GENMAN_TOOL"
	return $NOT_SUCCESS
}


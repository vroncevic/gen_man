#!/bin/bash
#
# @brief   Generate and install man page
# @version ver.1.0
# @date    Sat Dec 17 12:12:20 CET 2016
# @company None, free software to use 2016
# @author  Vladimir Roncevic <elektron.ronca@gmail.com>
#
UTIL_ROOT=/root/scripts
UTIL_VERSION=ver.1.0
UTIL=$UTIL_ROOT/sh-util-srv/$UTIL_VERSION
UTIL_LOG=$UTIL/log

. $UTIL/bin/devel.sh
. $UTIL/bin/usage.sh
. $UTIL/bin/checkroot.sh
. $UTIL/bin/checktool.sh
. $UTIL/bin/logging.sh
. $UTIL/bin/sendmail.sh
. $UTIL/bin/loadconf.sh
. $UTIL/bin/loadutilconf.sh
. $UTIL/bin/progressbar.sh

GENMAN_TOOL=genman
GENMAN_VERSION=ver.1.0
GENMAN_HOME=$UTIL_ROOT/$GENMAN_TOOL/$GENMAN_VERSION
GENMAN_CFG=$GENMAN_HOME/conf/$GENMAN_TOOL.cfg
GENMAN_UTIL_CFG=$GENMAN_HOME/conf/${GENMAN_TOOL}_util.cfg
GENMAN_LOG=$GENMAN_HOME/log

declare -A GENMAN_USAGE=(
	[USAGE_TOOL]="__$GENMAN_TOOL"
	[USAGE_ARG1]="[OPTION] Create | install man page"
	[USAGE_ARG2]="[MAN_FILE] Filename of man page"
	[USAGE_EX_PRE]="# Example create new man page for ldap script"
	[USAGE_EX]="__$GENMAN_TOOL create ldapaddman.1"	
)

declare -A GENMAN_LOG=(
	[LOG_TOOL]="$GENMAN_TOOL"
	[LOG_FLAG]="info"
	[LOG_PATH]="$GENMAN_LOG"
	[LOG_MSGE]="None"
)

declare -A PB_STRUCTURE=(
	[BAR_WIDTH]=50
	[MAX_PERCENT]=100
	[SLEEP]=0.01
)

TOOL_DEBUG="false"

#
# @brief  Install man file
# @param  Value required man file
# @retval Success return 0, else return 1
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __install_man "ldapaddman.1"
# local STATUS=$?
#
# if [ $STATUS -eq $SUCCESS ]; then
# 	# true 
# else
# 	# false
# fi
#
function __install_man() {
	local MAN_FILE=$1
	local FUNC=${FUNCNAME[0]}
	local MSG="None"
	if [ -n "$MAN_FILE" ]; then
		MSG="Instaling man page"
		if [ "$TOOL_DBG" == "true" ]; then
			printf "$DSTA" "$GENMAN_TOOL" "$FUNC" "$MSG"
		else
			printf "$SEND" "$GENMAN_TOOL" "$MSG"
		fi
		if [ ! -e "$MAN_FILE" ]; then
			MSG="Check file $MAN_FILE"
			if [ "$TOOL_DBG" == "true" ]; then
				printf "$DSTA" "$GENMAN_TOOL" "$FUNC" "$MSG"
			else
				printf "$SEND" "$GENMAN_TOOL" "$MSG"
			fi
			return $NOT_SUCCESS
		fi
		__checktool "${configgenmanutil[INSTALL]}"
		local STATUS=$?
		if [ $STATUS -eq $SUCCESS ]; then
			local PRFX_CMD="${configgenmanutil[INSTALL]} -g 0 -o 0 -m 0644"
			eval "$PRFX_CMD $MAN_FILE ${configgenmanutil[MAN_HOME_PAGES]}/"
			gzip "${configgenmanutil[MAN_HOME_PAGES]}/$MAN_FILE"
			if [ "$TOOL_DBG" == "true" ]; then
				printf "$DSTA" "$GENMAN_TOOL" "$FUNC" "Done"
			else
				printf "$SEND" "$GENMAN_TOOL" "Done"
			fi
			return $SUCCESS
		fi
		cp $MAN_FILE "${configgenmanutil[MAN_HOME_PAGES]}/$MAN_FILE"
		gzip "${configgenmanutil[MAN_HOME_PAGES]}/$MAN_FILE"
		if [ "$TOOL_DBG" == "true" ]; then
			printf "$DSTA" "$GENMAN_TOOL" "$FUNC" "Done"
		else
			printf "$SEND" "$GENMAN_TOOL" "Done"
		fi
		return $SUCCESS
	fi
	MSG="Provide file argument [MAN_FILE]"
	printf "$SEND" "$GENMAN_TOOL" "$MSG"
	return $NOT_SUCCESS
}

#
# @brief  Install man file
# @param  Value required man file
# @retval Success return 0, else return 1
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __create_man "ldapaddman.1"
# local STATUS=$?
#
# if [ $STATUS -eq $SUCCESS ]; then
# 	# true 
# else
# 	# false
# fi
#
function __create_man() {
	local MAN_FILE=$1
	local FUNC=${FUNCNAME[0]}
	local MSG="None"
	if [ -n "$MAN_FILE" ]; then
		MSG="Creating man page"
		if [ "$TOOL_DBG" == "true" ]; then
			printf "$DSTA" "$GENMAN_TOOL" "$FUNC" "$MSG"
		else
			printf "$SEND" "$GENMAN_TOOL" "$MSG"
		fi
		DATE=`date`
		local MAN_TEMPLATE=".\\\" Manpage for [TOOL_NAME].
.\\\" Contact ${configgenman[ADMIN_EMAIL]} to correct errors or typos.
.TH man 8 \"$DATE\" \"1.0\" \"[TOOL_NAME] man page\"
.SH NAME
[TOOL_NAME] \- [Description of tool]
.SH SYNOPSIS
[TOOL_NAME] [TOOL_ARGUMENT]
.SH DESCRIPTION
[TOOL_NAME] [Description of tool].
.SH OPTIONS
The [TOOL_NAME] does not take any options. However, you can supply [TOOL_ARGUMENT].
.SH SEE ALSO
[TOOL_NAME](8), [TOOL_NAME].debian(8)
.SH BUGS
No known bugs.
.SH AUTHOR
[Fullname of author] ${configgenman[ADMIN_EMAIL]}
"
		echo -e "$MAN_TEMPLATE" > "$MAN_FILE"
		if [ "$TOOL_DBG" == "true" ]; then
			printf "$DSTA" "$GENMAN_TOOL" "$FUNC" "Done"
		else
			printf "$SEND" "$GENMAN_TOOL" "Done"
		fi
		return $SUCCESS
	fi
	MSG="Provide file argument [MAN_FILE]"
	printf "$SEND" "$GENMAN_TOOL" "$MSG"
	return $NOT_SUCCESS
}

#
# @brief  Main function
# @params Values required option and file name
# @retval Function __genman exit with integer value
#			0   - tool finished with success operation
#			128 - missing argument(s) from cli 
#			129 - failed to load tool script configuration from file 
#			130 - failed to load tool script utilities configuration from file
#			131 - failed to create man page
#			132 - failed to install man page
#			133 - not implemented option
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __genman "create" "ldapaddman.1"
# local STATUS=$?
#
# if [ $STATUS -eq $SUCCESS ]; then
# 	# true 
# else
# 	# false
# fi
#
function __genman() {
	local OPTION=$1
	local MAN_FILE=$2
	if [ -n "$OPTION" ] && [ -n "$MAN_FILE" ]; then
		local FUNC=${FUNCNAME[0]}
		local MSG="Loading basic and util configuration"
		printf "$SEND" "$GENMAN_TOOL" "$MSG"
		__progressbar PB_STRUCTURE
		printf "%s\n\n" ""
		declare -A configgenman=()
		__loadconf $GENMAN_CFG configgenman
		local STATUS=$?
		if [ $STATUS -eq $NOT_SUCCESS ]; then
			MSG="Failed to load tool script configuration"
			if [ "$TOOL_DBG" == "true" ]; then
				printf "$DSTA" "$GENMAN_TOOL" "$FUNC" "$MSG"
			else
				printf "$SEND" "$GENMAN_TOOL" "$MSG"
			fi
			exit 129
		fi
		declare -A configgenmanutil=()
		__loadutilconf $GENMAN_UTIL_CFG configgenmanutil
		STATUS=$?
		if [ $STATUS -eq $NOT_SUCCESS ]; then
			MSG="Failed to load tool script utilities configuration"
			if [ "$TOOL_DBG" == "true" ]; then
				printf "$DSTA" "$GENMAN_TOOL" "$FUNC" "$MSG"
			else
				printf "$SEND" "$GENMAN_TOOL" "$MSG"
			fi
			exit 130
		fi
		if [ "$OPTION" == "create" ]; then
			__create_man $MAN_FILE
			STATUS=$?
			if [ $STATUS -eq $NOT_SUCCESS ]; then
				exit 131
			fi
		elif [ "$OPTION" == "install" ]; then
			__install_man $MAN_FILE
			STATUS=$?
			if [ $STATUS -eq $NOT_SUCCESS ]; then
				exit 132
			fi
		else
			MSG="Not supported option [$OPTION]"
			printf "$SEND" "$GENMAN_TOOL" "$MSG"
			exit 133
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
#			129 - failed to load tool script configuration from file 
#			130 - failed to load tool script utilities configuration from file
#			131 - failed to create man page
#			132 - failed to install man page
#			133 - not implemented option
#
printf "\n%s\n%s\n\n" "$GENMAN_TOOL $GENMAN_VERSION" "`date`"
__checkroot
STATUS=$?
if [ $STATUS -eq $SUCCESS ]; then
	__genman $1 $2
fi

exit 127


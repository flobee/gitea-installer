#!/bin/dash
#echo "File: $(readlink -f "$0")";

# ---------------------------------------------------------------------
# un-install, remove gitea and all the user and files
# DANGE ZONE!
# ---------------------------------------------------------------------


# ---------------------------------------------------------------------
# Basic includes for all scripts
# ---------------------------------------------------------------------
DIR_OF_FILE="$(dirname "$(readlink -f "$0")")";
. "${DIR_OF_FILE}"/shellFunctions.sh;
sourceConfigs "${DIR_OF_FILE}" "config.sh-dist" "config.sh" "$1";
# ---------------------------------------------------------------------

# Force ask questions
ACTION_ASKQUESTIONS='Y';
CONFIRMCOMMAND='Y';

echo "+-----------------------------------------------------------------------+"
echo '# un-install gitea';
echo "+-----------------------------------------------------------------------+"
echo "WARNING!!!";
echo
echo "NOT FOR PRODUCTION";
echo
echo "This DELETE, PURGE, REMOVE ALL existing user, files and services this";
echo "installer created. ALSO ALL of YOUR DATA of the usage of gitea will be away.";
echo
echo "  - Make a backup first: # ./backup.sh";
echo "    Press 'CTRL + C' to abort here.";
echo
echo

HAS_BACKUPS=$(du -hs "${PATH_BACKUPS}");
if [ "$HAS_BACKUPS" ]; then
    echo "  - Old backups found in:";
    echo "    ${HAS_BACKUPS}";
    echo
    echo "    It will be DELETED if you don't save them in a save place.";
    echo
fi

#
# final question to go on...
#

UNINSTALL_NOW=0;
if [ "${ACTION_ASKQUESTIONS}" = "Y" ]; then
    CONFIRMCOMMAND=${ACTION_ASKQUESTIONS};
    echo "Remove and uninstall now? (defaut: '${ACTION_ASKQUESTIONS}')";
    if confirmCommand "${ACTION_ASKQUESTIONS}" && [ "${CONFIRMCOMMAND}" = "Y" ]; then
        UNINSTALL_NOW=1;
    else
        echo "Abort by user";
        exit 1;
    fi
fi

if [ "${ACTION_ASKQUESTIONS}" = "N" ]; then
    UNINSTALL_NOW=1;
fi

if [ "${UNINSTALL_NOW}" != 1 ]; then
    echo "Abort install process";
fi


# BACKUPS handling
contains=$(contains "${PATH_BACKUPS}" "${PATH_HOME}");
if [ "$contains" = 1 ]; then
    echo "Path: ${PATH_BACKUPS} is NOT IN ${PATH_HOME} and will not be handled"
else
    echo "Path: ${PATH_BACKUPS} is IN ${PATH_HOME} and will be deleted on next step"
fi


# GITEA handling
contains=$(contains "${PATH_GITEA}" "${PATH_HOME}");
if [ "$contains" = 1 ]; then
    echo "Path: ${PATH_GITEA} is NOT IN ${PATH_HOME} and will not be handled"
else
    echo "Path: ${PATH_GITEA} is IN ${PATH_HOME} and will be deleted on next step"
fi


# REPOSITORIES handling
contains=$(contains "${PATH_REPOSITORIES}" "${PATH_HOME}");
if [ "$contains" = 1 ]; then
    echo "Path: ${PATH_REPOSITORIES} is NOT IN ${PATH_HOME} and will not be handled"
else
    echo "Path: ${PATH_REPOSITORIES} is IN ${PATH_HOME} and will be deleted on next step"
fi


echo "Removes PATH_HOME (and all files inside): '${PATH_HOME}'";
rm -rf "${PATH_HOME}";


# Remove services

systemctl daemon-reload;
systemctl stop gitea
systemctl disable gitea
rm -f /etc/systemd/system/multi-user.target.wants/gitea.service
rm -f /etc/systemd/system/gitea.service

#rm /etc/systemd/system/gitea* # and symlinks that might be related
#rm /usr/lib/systemd/system/gitea
#rm /usr/lib/systemd/system/gitea # and symlinks that might be related

systemctl daemon-reload
systemctl reset-failed


echo "Removes the user: '${USER}'";
deluser --quiet "${USER}";


echo "remove complete.";
exit 0;
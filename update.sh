#!/bin/dash

# ---------------------------------------------------------------------
# Paths/ settings you may want to change: see config.sh
# ---------------------------------------------------------------------


# ---------------------------------------------------------------------
# Basic includes for all scripts
# ---------------------------------------------------------------------
DIR_OF_FILE="$(dirname "$(readlink -f "$0")")";
. "${DIR_OF_FILE}"/shellFunctions.sh;
sourceConfigs "${DIR_OF_FILE}" "config.sh-dist" "config.sh" "$1";
# ---------------------------------------------------------------------

# Download gitea bin

if ! sh "${DIR_OF_FILE}"/download.sh "$1"; then
    echo "Error in download";
    exit 1;
fi

echo '# install binary...';
echo
echo "Make sure the conf/app.ini is writable for the user 'git' if you want";
echo "to change settings! Otherwise just go ahead, see below";
echo

if [ "${ACTION_ASKQUESTIONS}" = "Y" ]; then
    CONFIRMCOMMAND=${ACTION_ASKQUESTIONS};
    echo "Install the downloaded version of gitea now? (defaut: '${ACTION_ASKQUESTIONS}')";
    if confirmCommand "${ACTION_ASKQUESTIONS}" && [ "${CONFIRMCOMMAND}" = "Y" ]; then
        INSTALL_NOW=1;
    else
        echo "Abort by user";
        exit 1;
    fi
fi

if [ "${ACTION_ASKQUESTIONS}" = "N" ]; then
    INSTALL_NOW=1;
fi

if [ "${INSTALL_NOW}" = 1 ]; then
    cp -f "/tmp/${GITEA_BIN_BASENAME}" "${PATH_GITEA}/gitea";
    chmod +x "${PATH_GITEA}/gitea";

    systemctl stop gitea;

    systemctl start gitea;

    . "${DIR_OF_FILE}"/z_after_install_update.sh;
fi
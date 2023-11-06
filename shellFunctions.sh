#!/bin/dash
# shellcheck source=config.sh-dist

# ---------------------------------------------------------------------
confirmCommand() {
    default="$1";
    if [ "${default}" = "" ] || [ "${default}" = "N" ]; then
        _CONFIRMCOMMAND='n';
    else
        _CONFIRMCOMMAND=${default};
    fi
    read -r -p "Confirm (Y)es,(n)o (def:'$_CONFIRMCOMMAND'): " CONFIRMCOMMAND;
    CONFIRMCOMMAND=${CONFIRMCOMMAND:-$_CONFIRMCOMMAND};

    return 0;
}


# ---------------------------------------------------------------------
sourceConfigs() {
    LOCATION=$1;        # Path where to load config files (eg: '/tmp/')
    CONFIG_DIST=$2;     # Name of the config of the distribution (default values; e.g: 'config.sh-dist')
    CONFIG_CUSTOM=$3;   # Name of your custom confif to overwrite defaults (e.g: 'config.sh')
    NEW_GITEA_BIN_URL=$4; # if given throuh the scripts to be shared

    if [ "$NEW_GITEA_BIN_URL" != "" ] && [ "$GITEA_BIN_URL" = "" ]; then
        GITEA_BIN_URL=$NEW_GITEA_BIN_URL;
        export GITEA_BIN_URL;

        GITEA_BIN_BASENAME=$(basename "$GITEA_BIN_URL");
        export GITEA_BIN_BASENAME;
    fi

    if [ -f "${LOCATION}/${CONFIG_DIST}" ]; then
        . "${LOCATION}/${CONFIG_DIST}";
    else
        echo "Default config not found: '${LOCATION}/${CONFIG_DIST}'";
    fi

    if [ -f "${LOCATION}/${CONFIG_CUSTOM}" ]; then
        . "${LOCATION}/${CONFIG_CUSTOM}";
    # else
        #echo "Custom config not found: '${LOCATION}/${CONFIG_CUSTOM}'";
    fi

    #printenv;
}

# ---------------------------------------------------------------------
# contains(heystackstring, stringpart)
# Returns 0 if stringpart found in heystackstring otherwise returns 1
contains() {
    string="$1"
    substring="$2"
    if test "${string#*$substring}" != "$string"
    then
        return 0 # $stringpart IN string
    else
        return 1 # $stringpart NOT in string
    fi
}

# Intro

Install helper scripts for the [https://gitea.io/](https://gitea.io/) project
using the binary versions.

**Gitea** is a lightweight DevOps platform like bitbucket, github, gitlab...:
For a own hosting in public or local domain. And it is open source.
It brings teams and developers high-efficiency but easy operations from planning
to production. Read more: https://about.gitea.com/

In my oppinion: The primary benefit in a local domain for low to medium teams
and repositories: It is very fast!
Even with a sqliteDB when i started using it. And it can scale.

**I ❤ Gitea**

+ Web: https://gitea.io/
+ Source: https://github.com/go-gitea/gitea
+ Releases: https://github.com/go-gitea/gitea/releases



## WARNING:

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

More: Check the [License](#license).


# TOC
<!-- doctoc --title '**Table of contents**' --entryprefix '+' README.md -->
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of contents**

+ [About](#about)
+ [Getting started](#getting-started)
+ [Updates](#updates)
+ [Usage over the time](#usage-over-the-time)
+ [Single script details](#single-script-details)
+ [License](#license)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->



## About

Install helper scripts for installing `gitea`. Made under/for debian and
many other *nix OS's.

I had some issues at the very first day installing `gitea` and was not able to
get it run quickly.

The documentation was not good enough in that time so this may help you today.

Install `gitea` under user "`git`"?. Read ahead...

Optional you can change the user and other important options for scaling gitea
and this installation.

You will find some scripts you may execute by hand or running the main
`runner.sh` script.

The `runner.sh` script will guide you by default. Asks questions for backups or
the kind of update (update or install from scratch) depending on config settings.

Read all infomations of the output befor you go on to avoid problems.

The scripts must run under `root` and will setup needed path and rights and
switch the user when needed for setup/configure the frontend (gitea frontend)
with furhter details.

**Hints:**

Please read this document first. There some hints you may need to get it run
better than me at very the first time. On code updates: Check this doc also!

Forget your /home/[USER_for_GITEA]/.ssh/authorized_keys
Gitea will do! Bring it to zero bytes if already exists and you will have
less issues.


## Getting started

Clone the repro (stable branch) or
Download the `config.sh-dist` and `selfupdate.sh` and run `selfupdate.sh`

With default values:

    git clone --branch=stable https://github.com/flobee/gitea-installer.git /home/git/tea/gitea-installer

+ Log-in at the server (or ssh remote call) and
    - run `/home/git/tea/gitea-installer/runner.sh`

Feel free to run the single scripts like: `backup.sh`, `download.sh`,
`install.sh` or `update.sh`.

By default this was tested with debian's default shell: `dash`. If you have
problems please report or post suggestions. i'm not that high-end shell junkie
and everything here could be improved but it should work with all posix shells
out there.


## Updates

To reduce output and handling create and setup your `config.sh` to overwrite the
defaults. By default you will be asked for each action.

Depending on the settings in `config.sh[-dist]` the `runner.sh` does
all steps and can guide you or just does it without requesting any futher user
input.

Maybe some time some updates are required. Update this repository or use the
`selfupdate.sh` script to replace/update existing scripts.

Note: `config.sh-dist` would be replaced with the default values! Don't edit it.
Don't copy it to be used as `config.sh`!

    `config.sh-dist` = maintainer side
    `config.sh`      = your values

For automisations you can set the config to not ask questions anymore e.g. using
your custom `config.sh`. Suggested values then:

    ACTION_ASKQUESTIONS='N';
    ACTION_TYPE='U';

Then call `runner.sh '[optional new url]'` or e.g. `update.sh '[new url]'`.

For all jobs the `runner.sh` is the best entry point for the latest version
(depending on the config: `CONFIG_GITEA_BIN_URL='latest'`).

Or: Update your config with an url/version you want to use or simply force using
the version you want to install/ update: `runner.sh [URL]`.

To avoid overwriting your settings (e.g. when using `selfupdate.sh`) add your
own `config.sh` including your settings which you can find in `config.sh-dist`.
But not all of them! Read carfully. The scripts first scans the default 
`config.sh-dist` file and then scans your `config.sh` file (if exists) so that 
your values will take account (lifo).


## Usage over the time

Once gitea service is installed there are not may things to take care for.
Except on scaling (DB of FS) or OS changes or changes of gitea where the
installer needs some updates.

Update the repository or use `selfupdate.sh` and compare/review the
`config.sh-dist` for changes and update your custom `config.sh` if exists.

Add your custom `config.sh`:

+ Probably disable asking question
+ Set default action for updates (U)
+ Set if you want backups with this script or not

Then you can run the `runner.sh` which just do all automatically.

Suggestion: symlink `config.sh.example-for-your-setup` to `config.sh` if you
want to have updates from the maintainer. It is only the 'update' case and
creates backups and dont asks questions anymore.


Happy git + tea :)



## Single script details

What the single scripts do (A-Z) and some hints you may like or need to know.


+ `backup.sh`

  Does only backups from the gitea installation (by given path in config) and
  also from the path of the repositories (by given path in config). the path of
  the git user (config: USER) account will (currently) not be backuped! This is
  something for general backups (repositories and gitea installation may be at
  very different places where user account things more OS related things)


+ `download.sh [optional new url]`

  Downloads only the binary (by given new url or url from config) and checks the
  sha256 checksum. All the rest must be done by hand.

+ `install.sh [optional new url]`

  Install gitea from scratch/ new installation. Optional use your 'new url' if
  you dont want to install the latest version (depends on config settings). 'new
  url' will overwrite this config setting.


+ `pre-install.sh` is for internal things, not executable...

  and is used within the `install.sh` script. It can use your OS package manager
  to check for required packages this program needs to work propperly.
  For debian OS's (eg. ubuntu) this works out of the box.


+ `runner.sh [optional new url]`

  Basis for all actions to install or upgrade gitea. All other
  scripts are seperations. The very first time it was an 'all in one' script
  for all actions. Enable `ACTION_ASKQUESTIONS='Y'` for manual usage.


+ `selfupdate.sh`

  Updates all the scripts for this app. You dont need to clone the repository.
  Updates are only from the 'stable' branch. Which means: The maintainer has
  tested the functions in any or all ways and marked it to be 'stable'.


+ `uninstall.sh`

  Currently a self deletion of this scripts and for the gitea installation
  including ALL OF YOUR DATA (within the default setup/config).
  If the paths for this app, repositoies or gitea installation are out of the
  git user account it will be left untouched. It will remove the user account
  and ALL under its account on FS and will remove system services. DB, if sqlite
  also! The `uninstall.sh` is set to force ask questions so that you must give
  an input before the deletion starts.
  The script come in mode 644 to not call by accident.


+ `update.sh [optional new url]`

  Like the `install.sh` task but just the update case. Creation of basis things
  are left untouched. It downloads and installs a new binary and re-init the
  services based on the settings.

  The optional new url is good when updating not to the latest version! You may
  want to update stepwise the minor or major versions if you dont update
  regulary. I do if i miss some updates because of unknown situations of gitea
  it self. Does a new major version really handle all bugs of a minor version?
  Hopefully yes but one is not really sure and the develpoment goes fast there.
  Minor vervion 1 includes some bugs which are fixed in minor version 2...
  and so on. And the next major version? Does ist solv the sub parts? READ the
  changelog and make you own oppinion. Based on this i deside using minor or
  major updates stepwise. Global: If i have a minor version i update each until
  the next major version and then each major version until the latest version
  exist or i want to have/ use.



## License

Copyright 2021 Florian Blasel

commit d1b5aef7274415d1e94fc63e908efd189b3d2bb8 (tag: 1.0.0)

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors
   may be used to endorse or promote products derived from this software without
   specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


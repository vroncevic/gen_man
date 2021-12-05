<img align="right" src="https://raw.githubusercontent.com/vroncevic/gen_man/dev/docs/gen_man_logo.png" width="25%">

# Generate Man Page

**gen_man** is shell tool for generating man pages.

Developed in **[bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell))** code: **100%**.

[![gen_man shell checker](https://github.com/vroncevic/gen_man/workflows/gen_man%20shell%20checker/badge.svg)](https://github.com/vroncevic/gen_man/actions?query=workflow%3A%22gen_man+shell+checker%22)

The README is used to introduce the tool and provide instructions on
how to install the tool, any machine dependencies it may have and any
other information that should be provided before the tool is installed.

[![GitHub issues open](https://img.shields.io/github/issues/vroncevic/gen_man.svg)](https://github.com/vroncevic/gen_man/issues) [![GitHub contributors](https://img.shields.io/github/contributors/vroncevic/gen_man.svg)](https://github.com/vroncevic/gen_man/graphs/contributors)

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [Installation](#installation)
- [Usage](#usage)
- [Dependencies](#dependencies)
- [Shell tool structure](#shell-tool-structure)
- [Docs](#docs)
- [Copyright and licence](#copyright-and-licence)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

### Installation

![Debian Linux OS](https://raw.githubusercontent.com/vroncevic/gen_man/dev/docs/debtux.png)

Navigate to release **[page](https://github.com/vroncevic/gen_man/releases)** download and extract release archive.

To install **gen_man** type the following

```
tar xvzf gen_man-x.y.tar.gz
cd gen_man-x.y
cp -R ~/sh_tool/bin/   /root/scripts/gen_man/ver.x.y/
cp -R ~/sh_tool/conf/  /root/scripts/gen_man/ver.x.y/
cp -R ~/sh_tool/log/   /root/scripts/gen_man/ver.x.y/
```

Self generated setup script and execution
```
./gen_man_setup.sh 

[setup] installing App/Tool/Script gen_man
	Sun 05 Dec 2021 06:13:29 PM CET
[setup] copy App/Tool/Script structure
[setup] remove github editor configuration files
[setup] set App/Tool/Script permission
[setup] create symbolic link of App/Tool/Script
[setup] done

/root/scripts/gen_man/ver.2.0/
├── bin/
│   ├── center.sh
│   ├── create_man.sh
│   ├── display_logo.sh
│   ├── gen_man.sh
│   └── install_man.sh
├── conf/
│   ├── gen_man.cfg
│   ├── gen_man.logo
│   ├── gen_man_util.cfg
│   └── template/
│       └── man.template
└── log/
    └── gen_man.log

4 directories, 10 files
lrwxrwxrwx 1 root root 44 Dec  5 18:13 /root/bin/gen_man -> /root/scripts/gen_man/ver.2.0/bin/gen_man.sh
```

Or You can use docker to create image/container.

[![gen_man docker checker](https://github.com/vroncevic/gen_man/workflows/gen_man%20docker%20checker/badge.svg)](https://github.com/vroncevic/gen_man/actions?query=workflow%3A%22gen_man+docker+checker%22)

### Usage

```
# Create symlink for shell tool
ln -s /root/scripts/gen_man/ver.x.y/bin/gen_man.sh /root/bin/gen_man

# Setting PATH
export PATH=${PATH}:/root/bin/

# Generating man
gen_man create ldapaddman

gen_man ver.2.0
Sun 05 Dec 2021 06:27:32 PM CET

[check_root] Check permission for current session? [ok]
[check_root] Done

	                                          
	  __ _  ___ _ __    _ __ ___   __ _ _ __  
	 / _` |/ _ \ '_ \  | '_ ` _ \ / _` | '_ \ 
	| (_| |  __/ | | | | | | | | | (_| | | | |
	 \__, |\___|_| |_| |_| |_| |_|\__,_|_| |_|
	 |___/                                    
	                                          
		Info   github.io/gen_man ver.2.0 
		Issue  github.io/issue
		Author vroncevic.github.io

[gen_man] Loading basic and util configuration!
100% [================================================]

[load_conf] Loading App/Tool/Script configuration!
[check_cfg] Checking configuration file [/root/scripts/gen_man/ver.2.0/conf/gen_man.cfg] [ok]
[check_cfg] Done

[load_conf] Done

[load_util_conf] Load module configuration!
[check_cfg] Checking configuration file [/root/scripts/gen_man/ver.2.0/conf/gen_man_util.cfg] [ok]
[check_cfg] Done

[load_util_conf] Done

[gen_man] Creating man page!
[gen_man] Generating file [ldapaddman.1]
[gen_man] Set permission!
[gen_man] Done

[logging] Checking directory [/root/scripts/gen_man/ver.2.0/log/]? [ok]
[logging] Write info log!
[logging] Done
```

### Dependencies

**gen_man** requires next modules and libraries
* sh_util [https://github.com/vroncevic/sh_util](https://github.com/vroncevic/sh_util)

### Shell tool structure

**gen_man** is based on MOP.

Shell tool structure
```
sh_tool/
├── bin/
│   ├── center.sh
│   ├── create_man.sh
│   ├── display_logo.sh
│   ├── gen_man.sh
│   └── install_man.sh
├── conf/
│   ├── gen_man.cfg
│   ├── gen_man.logo
│   ├── gen_man_util.cfg
│   └── template/
│       └── man.template
└── log/
    └── gen_man.log
```

### Docs

[![Documentation Status](https://readthedocs.org/projects/gen_man/badge/?version=latest)](https://gen_man.readthedocs.io/projects/gen_man/en/latest/?badge=latest)

More documentation and info at
* [https://gen_man.readthedocs.io/en/latest/](https://gen_man.readthedocs.io/en/latest/)
* [https://www.gnu.org/software/bash/manual/](https://www.gnu.org/software/bash/manual/)
* [https://www.man7.org/linux](https://www.man7.org/linux/man-pages/man7/man-pages.7.html)

### Copyright and licence

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Copyright (C) 2017 by [vroncevic.github.io/gen_man](https://vroncevic.github.io/gen_man)

**gen_man** is free software; you can redistribute it and/or modify
it under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

Lets help and support FSF.

[![Free Software Foundation](https://raw.githubusercontent.com/vroncevic/gen_man/dev/docs/fsf-logo_1.png)](https://my.fsf.org/)

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://my.fsf.org/donate/)

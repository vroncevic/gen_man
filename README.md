# Generate Man Page

<img align="right" src="https://raw.githubusercontent.com/vroncevic/gen_man/dev/docs/gen_man_logo.png" width="25%">

**gen_man** is shell tool for generating man pages.

Developed in **[bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell))** code: **100%**.

[![gen_man_shell_checker](https://github.com/vroncevic/gen_man/actions/workflows/gen_man_shell_checker.yml/badge.svg)](https://github.com/vroncevic/gen_man/actions/workflows/gen_man_shell_checker.yml)

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

Navigate to release **[page](https://github.com/vroncevic/gen_man/releases)** download and extract release archive.

To install **gen_man** type the following:

```bash
tar xvzf gen_man-x.y.tar.gz
cd gen_man-x.y
cp -R ~/sh_tool/bin/   /root/scripts/gen_man/ver.x.y/
cp -R ~/sh_tool/conf/  /root/scripts/gen_man/ver.x.y/
cp -R ~/sh_tool/log/   /root/scripts/gen_man/ver.x.y/
```

![alt tag](https://raw.githubusercontent.com/vroncevic/gen_man/dev/docs/setup_tree.png)

Or You can use docker to create image/container.

### Usage

```bash
# Create symlink for shell tool
ln -s /root/scripts/gen_man/ver.x.y/bin/gen_man.sh /root/bin/gen_man

# Setting PATH
export PATH=${PATH}:/root/bin/

# Generating man
gen_man SimpleTest
```

### Dependencies

**gen_man** requires next modules and libraries:
* sh_util [https://github.com/vroncevic/sh_util](https://github.com/vroncevic/sh_util)

### Shell tool structure

**gen_man** is based on MOP.

Code structure

```bash
sh_tool/
├── bin/
│   ├── create_man.sh
│   ├── gen_man.sh
│   └── install_man.sh
├── conf/
│   ├── gen_man.cfg
│   ├── gen_man_util.cfg
│   └── template/
│       └── man.template
└── log/
    └── gen_man.log
```

### Docs

[![Documentation Status](https://readthedocs.org/projects/gen_man/badge/?version=latest)](https://gen-man.readthedocs.io/projects/gen_man/en/latest/?badge=latest)

More documentation and info at:
* [https://gen_man.readthedocs.io/en/latest/](https://gen-man.readthedocs.io/en/latest/)
* [https://www.gnu.org/software/bash/manual/](https://www.gnu.org/software/bash/manual/)
* [https://www.man7.org/linux](https://www.man7.org/linux/man-pages/man7/man-pages.7.html)

### Copyright and licence

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Copyright (C) 2017 - 2024 by [vroncevic.github.io/gen_man](https://vroncevic.github.io/gen_man)

**gen_man** is free software; you can redistribute it and/or modify
it under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

Lets help and support FSF.

[![Free Software Foundation](https://raw.githubusercontent.com/vroncevic/gen_man/dev/docs/fsf-logo_1.png)](https://my.fsf.org/)

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://my.fsf.org/donate/)

# Generate Man Page.

gen_man is shell tool for generating man.

Developed in bash code: 100%.

The README is used to introduce the tool and provide instructions on
how to install the tool, any machine dependencies it may have and any
other information that should be provided before the tool is installed.

[![GitHub issues open](https://img.shields.io/github/issues/vroncevic/gen_man.svg)](https://github.com/vroncevic/gen_man/issues)
 [![GitHub contributors](https://img.shields.io/github/contributors/vroncevic/gen_man.svg)](https://github.com/vroncevic/gen_man/graphs/contributors)

### INSTALLATION

Navigate to release [page](https://github.com/vroncevic/gen_man/releases) download and extract release archive.

To install modules type the following:

```
tar xvzf gen_man-x.y.z.tar.gz
cd gen_man-x.y.z
cp -R ~/sh_tool/bin/   /root/scripts/gen_man/ver.1.0/
cp -R ~/sh_tool/conf/  /root/scripts/gen_man/ver.1.0/
cp -R ~/sh_tool/log/   /root/scripts/gen_man/ver.1.0/
```

Or You can use docker to create image/container.

:sparkles:

### USAGE

```
# Create symlink for shell tool
ln -s /root/scripts/gen_man/ver.1.0/bin/gen_man.sh /root/bin/gen_man

# Setting PATH
export PATH=${PATH}:/root/bin/

# Generating man
gen_man SimpleTest
```

### DEPENDENCIES

This tool requires these other modules and libraries:

* sh-util https://github.com/vroncevic/sh-util

### SHELL TOOL STRUCTURE

gen_man is based on MOP.

Shell tool structure:
```
.
├── bin/
│   ├── create_man.sh
│   ├── gen_man.sh
│   └── install_man.sh
├── conf/
│   ├── gen_man.cfg
│   ├── gen_man_util.cfg
│   └── template
│       └── man.template
└── log/
    └── gen_man.log
```

### DOCS

[![Documentation Status](https://readthedocs.org/projects/gen_man/badge/?version=latest)](https://gen_man.readthedocs.io/projects/gen_man/en/latest/?badge=latest)

More documentation and info at:

* https://gen_man.readthedocs.io/en/latest/

:sparkles:

### COPYRIGHT AND LICENCE

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Copyright (C) 2018 by https://vroncevic.github.io/gen_man

This tool is free software; you can redistribute it and/or modify
it under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

:sparkles:


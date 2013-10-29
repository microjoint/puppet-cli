#cli

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with cli](#setup)
    * [What cli affects](#what-cli-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with cli](#beginning-with-cli)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

The cli module installs, configures the cli of choice.

##Module Description

The cli module handles installing cli mainly on Arch Linux. Were possible I have added other distributions where known.

##Setup

###What cli affects

* cli package.
* cli configuration file.

###Beginning with cli

include '::cli' is enough to get you up and running.  If you wish to pass in
parameters like if the service should be running, use:

```puppet
class { '::cli':
  service_ensure => true,
}
```

##Usage

All interaction with the cli module can do be done through the main cli class.
This means you can simply toggle the options in the cli class to get at the
full functionality.

###I just want cli, what's the minimum I need?

```puppet
include '::cli'
```

###I'd like to define a command line editor.

```puppet
class { '::cli':
  editor    => 'nano',
}
```

###I'd like to opt out of having bash and all it's wonder.

```puppet
class { '::cli':
  editor    => 'nano',
  bash      => false,
}
```

##Reference

###Classes

* cli: Main class, includes all the rest.
* cli::install: Handles the packages.
* cli::config: Handles the configuration files.

###Parameters

The following parameters are available in the cli module

####`editor`

Command line editor used for $EDITOR environment variable.

####`path`

String to be used as global path environmental variable.

####`visual`

$VISUAL environment variable

####`umask`

Global umask.

####`sudo_grp_with_passwd`

The name of the group that needs a password when using sudo.

####`sudo_grp_without_passwd`

The name of the group that doesn't needs a password when using sudo.

####`bash`

Boolean, whether bash should be installed with all its configuration.

####`bash_config`

Hash of all the file resources to be created.


##Limitations

This module has been built on and tested against Puppet 3.3 and higher.

The module has been tested on:

* Arch Linux

Testing on other platforms has been light and cannot be guaranteed. 

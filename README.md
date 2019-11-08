# pwatch
Watch for Files to be printed.
Pwatch is a small Lua script destined to operate as a background service under Linux. It monitors a well defined directory for new files using the inotify library and the corresponding Lua binding linotify.
As soon as new file is created in the observed directory, pwatch starts printing. Printing capabilities are determined by the underlying print system, e.g. CUPS.

The main purpose is to write files via Owncloud to the monitored directory from anywhere in the web.

### Installation

The easiest way to use pwatch is to adopt the configuration file _watch.conf_ and the service unit description _pwatch.service_ and use pwatch as a systemd service.

#### Configuration
There are the following three configuration values:
```
wdname=PATH_TO_DIRECTORY_TO_BE_MONITORED (mandatory)
logfilename=PATH_TO_LOGFILE (default: /var/log/pwatch.log)
printopts=USER_DEFINED_LP_OPTIONS (default: "")
```

#### Service Installation

After adoption of the configuration and service description, simply use 
```
$ make install
```

to install program, configuration file and service description.

Now use 
```
make start/stop/status
```
to start or stop the service or retrieve it's status from systemd.

Look into the makefile for the exact commands.

### Usage

The program knows two options
```
usage: pwatch OPTIONS
  OPTIONS:
  --help   Print this help.
  --test   Run in test mode.
```

Option --test can be used to test the operation without actually printing. 

Have fun!

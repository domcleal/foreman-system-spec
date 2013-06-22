# System tests for Foreman

This project tests [Foreman](http://theforeman.org) and
[foreman-installer](https://github.com/theforeman/foreman-installer) using
[rspec-system](https://github.com/puppetlabs/rspec-system) and
[rspec-system-foreman](https://github.com/domcleal/rspec-system-foreman).

It's designed to test that a full installation of Foreman on a virtual machine
basically functions by testing it through the API.  This is then used to check
installer changes and package promotions.  rspec-system allows testing on each
supported operating system.

## Configuration

In order to support running via Jenkins, config is done by environment
variables.  See rspec-system docs for the list of supported settings there:

* [https://github.com/puppetlabs/rspec-system#running-tests](rspec-system)
* notably *RSPEC_SET* to set the test OS according to `.nodeset.yml`

Other settings:

* *FOREMAN_REPO* - published repo subdir (yum) or component (deb) to use
  (default: latest stable release)
* *FOREMAN_CUSTOM_REPO* - URL to a custom package repository to configure
* *FOREMAN_INSTALLER_SOURCE* - path to a Foreman installer checkout to use
  instead of from the repo
* *FOREMAN_SKIP_INSTALL* - set to `1` to skip installing Foreman, useful in
  combination with `RSPEC_DESTROY=no` to re-test an existing VM

# Contributing

* Fork the project
* Commit and push until you are happy with your contribution
* Send a pull request with a description of your changes

# More info

See http://theforeman.org or at #theforeman irc channel on freenode

Copyright (c) 2013 Red Hat Inc and their respective owners

Except where specified in provided modules, this program and entire
repository is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

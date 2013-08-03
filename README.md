Git Aliases
===========

This is a library of useful git aliases that I use in my development
environment. They are designed to be used with the
[include](http://git-scm.com/docs/git-config#_includes) functionality in git
1.7.10+. Pull requests are welcome, so feel free to submit your own aliases or
improve upon existing ones.


System Requirements
-------------------

* git 1.7.10+
* ruby


Installation
------------

To install git_aliases for the first time, change directories to the place where
you want git_aliases installed and then execute the following commands.

	git clone https://github.com/Ajedi32/git_aliases.git
	cd git_aliases
	./git_aliases.rb install

By default, all aliases are installed. If you only want to install some aliases,
use these commands:

	./git_aliases.rb uninstall all # To uninstall the default aliases
	./git_aliases.rb install <alias 1> <alais 2> ...

Note: Currently, "all" is treated like a normal alias. As a result, you can't
uninstall individual aliases that were installed with "all". Instead, you have
to uninstall "all" and then install the aliases that you want.

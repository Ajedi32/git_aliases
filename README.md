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

	git uninstall all # To uninstall the default aliases
	git install <alias 1> <alias 2> ...

Note: Currently, "all" is treated like a normal alias. As a result, you can't
uninstall individual aliases that were installed with "all". Instead, you have
to uninstall "all" and then install the aliases that you want.


Usage
-----

This library has a whole bunch of useful commands designed to streamline your
workflow and make common tasks quick and painless. I use many of these myself
on an everyday basis. Here are a few of my favorites:


### `git temp`

Stashes any uncommitted changes to your current branch as a temporary commit.


### `git pop`

Equivalent to `git reset HEAD~`. Useful for undoing `git temp`.


### `git l`

An alternative to `git log` that produces very pretty output that makes it easy
to see at a glance what your current branch looks like. The output looks like
this (except with color):

    * 7ee8988 - (HEAD, origin/master, origin/HEAD, master) Refactor do-each to use Ruby (22 hours ago) <Andrew Meyer>
    * 68d79fa - Refactor GitConfig's methods (12 days ago) <Andrew Meyer>
    * d15a742 - Suppress STDOUT from `git config` commands (12 days ago) <Andrew Meyer>
    * 7ac2acb - Refactor install script (12 days ago) <Andrew Meyer>
    *   690096f - Merge pull request #1 from Ajedi32/install_individual_aliases (12 days ago) <Ajedi32>
    |\
    | * 946c7e7 - Update README with instructions for installing individual aliases (12 days ago) <Andrew Meyer>
    | * d543dd2 - Allow installation of individual aliases (12 days ago) <Andrew Meyer>
    |/
    * c06fd9a - License the repo under the MIT License (13 days ago) <Andrew Meyer>
    * bd96039 - Add a README file (13 days ago) <Andrew Meyer>
    * 48136f5 - Move aliases to subdirectory to keep things organized (13 days ago) <Andrew Meyer>
    * ab0c5b5 - Add install script (13 days ago) <Andrew Meyer>
    * ed75532 - Rename alias-settings to alias-config (13 days ago) <Andrew Meyer>
    * ec5c3b6 - Rename branch-do-each to do-each and make it use rev-list (13 days ago) <Andrew Meyer>
    * b14332a - Add test branch alias (2 weeks ago) <Andrew Meyer>
    * 0871412 - Initial commit (4 weeks ago) <Andrew Meyer>

There's also `git lg` which does basically the same thing, but doesn't try to
limit the output to only the most recent commits, and `git lga` which is the
same as `lg` but shows all branches.


### `git recommit`

Amends your last commit without changing its commit message. Useful for making
a quick change to a commit you just made.


### `git split`

Allows you to pull changes out of your most recent commit, splitting it in two.
Works like `git add`.


### `git ignore`

Quickly append files to `.gitignore`


### `git unpushed`

View a list of all branches not already pushed to a remote repository.


### `git view-conflicts`

Open all files with merge conflicts in your favorite text editor. (Configurable
with `git config alias-config.viewer`.)


### Lots of really simple aliases

There are also a number of very simple aliases designed to make it easier to
type common commands, or remember the names and syntax of less common ones.
Here are a few of my favorites:

* `git s`, `git stat` -> `git status`
* `git rs` -> `git reset`
* `git fa` - Fetch all remotes
* `git review` - View diff of staged changes
* `git reword` - Reword last commit message
* `git cm "Commit message here"` - Commit with the given message
* `git remotes` - List remotes
* `git branches` - List branches
* `git sync` - Sync with all remotes


### And more!

Those are just a few of my favorite aliases from this collection. There's a
whole bunch more that I didn't even mention. For a complete list, look in the
[aliases](aliases) directory.

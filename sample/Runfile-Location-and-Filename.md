◄ Back to [[Home]]

-----

Runfile is designed to help you create both project specific command
line tools, and system wide command line applications.

**Project Runfiles** are simply named **Runfile** and can only be 
accessed in the same directory they live in.

**Named Runfiles (*.runfile)** can exist in several places:

- `*.runfile` in the current folder
- `*.runfile` in `~/runfile` and its sub directories
- `*.runfile` in `/etc/runfile` and its sub directories
- `*.runfile` in any custom folder

When you execute `run`, this is what happens:

- If there is a file called __Runfile__ in the current directory, 
  we will use it.
- If there is a file called __.runfile__ in the current folder, we will
  use it as a configuration file to tell us where the runfiles are. 
  (See [Custom Location](#custom-location-for-named-runfiles) below).
- If not, search for __*.runfiles__ in the runfile search directories and 
  subdirectories.
- If one or more were found, show a list of all of them.



Using a project Runfile
--------------------------------------------------

	$ cd /your/project

	$ run new
	Runfile created.

	$ run
	Usage:
	  run command <arg> [--flag]
	  run (-h|--help|--version)

	$ run command hello
	Command running...

	$ cat Runfile
	summary "Application description"
	version "0.1.0"

	usage  "command <arg> [--flag]"
	help   "Help line for command"
	option "-f --flag", "Help text for option"
	action :command do |args|
	  say "Command running..."
	end



Using Named Runfiles
--------------------------------------------------

	$ cd /your/project

	$ run new greet
	greet.runfile created.

	$ run
	Runfile engine v0.7.0

	Tip: Type 'run new' or 'run new name' to create a runfile.
	For global access, place named.runfiles in ~/runfile/ or in /etc/runfile/ or 
	anywhere in the PATH.

	  run greet ........................ /path/to/file

	$ run greet
	Usage:
	  run greet command <arg> [--flag]
	  run greet (-h|--help|--version)

	$ cd ~/runfile    # or /etc/runfile

	$ run new hotdog
	hotdog.runfile created.

	$ run
	Runfile engine v0.4.0

	Tip: Type 'run new' or 'run new name' to create a runfile.
	For global access, place named.runfiles in ~/runfile/ or in /etc/runfile/ or 
	anywhere in the PATH.

	  run greet ........................ /path/to/file
	  run hotdog ....................... /path/to/file


Custom Location for Named Runfiles
--------------------------------------------------

For more advanced uses, you can define multiple Runfiles per project.

This can be handy if you have a large set of commands and wish to 
separate them to multiple files.

Simply create a `.runfile` settings file in your project, and use it
to specify the location of the folder containing your runfiles.

```yaml
# in .runfile
---
folder: lib/commands
```

This settings file supports several more options, like auto-loading a
helper file, and creating command shortcuts.

Read more in the [Multiple Project Runfiles][1] page, or see the 
[Settings Example][2]


Ignoring the local Runfile
--------------------------------------------------

In case you are using both local Runfiles and global named runfiles, you may find
yourself in a situation where you are trying to run a named runfile from a 
folder that contains a local Runfile.

The local Runfile will take precedence and not allow access to your global 
runfiles. 

To overcome this issue, **use `run!` instead of `run`**.

The `run!` command will ignore the local Runfile and only look for 
named runfiles.


[1]: https://github.com/DannyBen/runfile/wiki/Multiple-Project-Runfiles
[2]: https://github.com/DannyBen/runfile/tree/master/examples/s_settings

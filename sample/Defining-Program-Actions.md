◄ Back to [[Runfile Command Reference]]

-----

## Cheatsheet

```ruby
# --- Action Definition

usage   "server [--background]"
help    "Start the server, optionally in the background"
option  "-b --background", "Start in the background"
example "server -b"
action  :server do |args|
	# ... action code here
end

# --- Command Prefix

command 'prefix'

# all actions here will be prefixed by 'prefix'

action :anything do
	# ...
end

encdommand
```

-----

## Reference

### `usage <string>`

Specify the usage pattern of the following `action`.
This string is expected to be in any format recognized by docopt.

In some cases ( [compact usage example](https://github.com/DannyBen/runfile/blob/master/examples/l_compact_usage/Runfile) ) 
you may want to force-disable the usage text for the following action. 
Simply use `usage false`. 

This command is optional if the action does not have any arguments.

__Examples:__

	usage "command" 			 # The next action (:command) has no 
	                             # arguments (optional in this case)

	usage "greet <name>"         # The next action (:greet) has one
	                             # require argument, called 'name'

	usage "run [--fast --slow]"  # The next action (:run) has two 
	                             # optional flags.
	
	usage false                  # Disable usage pattern for the next 
	                             # action.


### `help <string>`

Specify the help message for the following action.
This is the message that will be displayed when you execute 
`run --help`

This command is optional.

__Example:__ `help "Greet the user with a colorful 'Hello!'"`


### `option <string>, <description> [, <label>]`

Specify the help information for any of the option flags.
This is the place where you can specify that a certain flag also has 
a short version.

Normally, the help message for all options appear under the `Options:`
caption. If you provide the third `<label>` argument, it will appear 
under a different caption.

See Also: [Options Label Example](https://github.com/DannyBen/runfile/blob/master/examples/o_options_label/Runfile)

This command is optional unless the `usage` pattern may be ambiguous. 

__Examples:__

	option "-c --color", "Show message with a color"
	option "--force", "Force delete", "Delete Options"


### `example string`

Add an example command to the general help information. 
When adding an example, the command `run --help` will show an 
`Examples:` section at the end of the help text, with all added examples.

You do not need to include the `run` or `run runfile_name` at the beginning
of your example text, it is done automatically.

See Also: [Example Command Example](https://github.com/DannyBen/runfile/blob/master/examples/q_example/Runfile)

This command is optional.

__Examples:__

	example "copy source.txt dest.txt --force"
	example "copy source.txt --here"


### `action :<name> [, :<alias>] { <block> }`

Define the actual action block that will be called.  
This command is required

__Examples:__


```ruby
# If you do not need to process any arguments:
action :command do 
	# your code here
end

# if you want to handle arguments defined in `usage`:
action :command do |args|
	# your code here
	# access any argument with arg['--flagname'] or arg['<arg>']
end

# If you wish to use commands with hyphen, simply use single quotes:
action :'drink-beer' do 
	# your code here
end

# To define an alias (shortcut) to a command, use:
action :command, :c do 
	# your code here
end
```
See Also: [Alias Example](https://github.com/DannyBen/runfile/blob/master/examples/p_alias/Runfile)

### `command <string>`

The `command` command lets you define a namespace. Once you use this
command, any subsequent action will be associated with this namespace.

This is a way to create sub commands.

Call without parameter to revert back to the global namespace.

This command is optional.

__Example:__ `command "html"`

See Also: [Namespace Example](https://github.com/DannyBen/runfile/blob/master/examples/f_namespace/Runfile)


### `endcommand`

Alias of `command`. Intended as a syntactic sugar so that you can end
a `command 'namespace'` with `endcommand` instead of an empty 
`command`.

This command is optional.


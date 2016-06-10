◄ Back to [[Home]]

-----

**Runfile is ruby**. You can write any ruby code in it as usual.

> **Tip:** To create an initial Runfile, go to a folder that does not 
> contain one already, and execute `run new`.

Runfile provides several commands to help you define your program 
and a handful of utility functions to make writing beautiful 
command line applications a breeze.

A simple Runfile looks like this ( [more examples](https://github.com/DannyBen/runfile/tree/master/examples) ):

```ruby
usage  "greet <name>"
help   "Say hello to <name>"
action :greet do |args|
	say "Hello #{args['<name>']}" 
end
```

-----

#### [[Defining Program Details]]  

Commands to specify information about the program, such as its name and 
version.

#### [[Defining Program Actions]]  

Commands to define program actions

#### [[Output Commands]]

Commands that can be executed in any action to print colorful, indented
messages to the console.

#### [[Execution Commands]]

Commands that can be executed in any action to run external programs in
the foreground or background easily.

#### [[Misc Commands]]

Additional commands you can use in your action blocks.



◄ Back to [[Home]]

-----

**Runfile** lets you create command line applications in a way similar 
to [Rake][rake], but with the full power of [Docopt][docopt] command 
line options.

You create a `Runfile`, and execute commands with 
`run command arguments -and --flags`.

If you are not familiar with Rake or Docopt...
----------------------------------------------------------------------

**You don't have to be.**

These are just the tools that inspired Runfile (and docopt is used 
behind the scenes).

Think about Runfile as a way to easily define a command line 
application using Ruby code.

The fastest way to understand how Runfile works, is to create one or
play with [one of the examples][eg]

### To create your first Runfile:

1. Install Runfile - execute `gem install runfile`
2. Make sure it is installed - execute `run`
3. Create a template Runfile - execute `run new`
4. Execute your shiny new program - execute `run`

If everything went well, you should now see:

```
Usage:
  run command <arg> [--flag]
  run (-h|--help|--version)
```
Take a look at the [examples][eg], or the 
[Runfile Command Reference][ref]


If you are familiar with Rake...
----------------------------------------------------------------------

If you know rake, then Runfile is like Rakefile. You use a special, 
lightweight language (DSL) to define tasks in ruby.

One of the key differences between a Runfile and a Rakefile, is that 
in a Runfile you can define a fairly expressive set of commands, with 
required/optional parameters and long/short option flags.

For example, defining a Runfile that responds to 

	run watch style.css --verbose --all

is done like this:

```ruby
usage  "watch <file> [--verbose --all]"
action :watch do |args|
	say "Watching #{args['<file>']}"
	say "Verbosity: High" if args['--verbose']
	# your code here
end
```


If you are familiar with Docopt...
----------------------------------------------------------------------

If you have ever used Docopt, you know it is one of the simplest ways
to create expressive command line applications. Runfile is sort of a 
DSL around docopt.

Each command you use in the Runfile, adds a little something to the 
final "docopt" that will be generated.

For example, if you have this in your Runfile:

```ruby
usage  "greet <name> [--long --color]"
help   "Say hello to <name>"
option "--long", "Show a longer greeting"
option "--color", "Use colored output"
```

The generated docopt will look like this:

```		
$ run -h
Runfile 0.0.0

Usage:
  run greet <name> [--long --color]
  run (-h|--help|--version)

Commands:
  greet <name> [--long --color]
      Say hello to <name>

Options:
  -h --help
      Show this screen

  --version
      Show version

  --long
      Show a longer greeting

  --color
      Use colored output
```

Familiar right? Good. Familiar is good.

See the full [Runfile Command Reference](https://github.com/DannyBen/runfile/wiki/Runfile-Command-Reference) 
(it is short and not at all scary) or learn more about [Runfile 
Locations and Filenames](https://github.com/DannyBen/runfile/wiki/Runfile-Location-and-Filename).


[eg]: https://github.com/DannyBen/runfile/tree/master/examples
[ref]: https://github.com/DannyBen/runfile/wiki/Runfile-Command-Reference
[rake]: https://github.com/ruby/rake
[docopt]: http://docopt.org/

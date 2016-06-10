◄ Back to [[Home]]

-----

You can easily build a set of tasks that can be reused in any Runfile.

Since this is pure ruby, there are many ways to do so. The below is 
an example.

## Step 1: Create your common tasks file

Let's save this file as 'tasks.rb'

```ruby
# The reusable tasks module

module MyCommonTasks
  def self.tasks
    # We can use the standard Runfile syntax here

    command "make"

    usage  "cake [--chocolate|--cheese]"
    help   "Make some cake"
    action :cake do |args|
      say "Making a cake..."
      say "... a chocolate cake" if args['--chocolate']
      say "... a cheese cake" if args['--cheese']
    end

    usage  "faces"
    help   "Make faces"
    action :faces do |args|
      say "Making faces"
    end

    endcommand
  end
end
```

## Step 2: Embed the tasks in your Runfile

Create a `Runfile` file (you can simply run `run make`) and paste this
content in it.

```ruby
# include our common tasks file
require_relative "tasks"

name    "My Runfile"
summary "A sample Runfile"
version "0.1.0"

# include the external tasks
MyCommonTasks::tasks

# continue with regular tasks
usage  "hello [<name> --color]"
help   "Say hello"
option "-c --color", "Greet with color"
action :hello do |args|
  if args['--color']
    say "!txtgrn!Hello #{args['<name>']}"
  else
    say "Hello #{args['<name>']}"
  end
end
```

## Step 3: Test the Runfile

Running `run` will now show both the embedded and local tasks:

```
$ run
Usage:
  run make cake [--chocolate|--cheese]
  run make faces
  run hello [<name> --color]
  run (-h|--help|--version)
```

## Packing reusable tasks as a gem

You can pack your reusable tasks as a gem for all to enjoy.

An example of such a gem, is the 
[runfile-tasks gem](https://github.com/DannyBen/runfile-tasks)
which provides a collection of tasks like:

- Tasks for running tests (minitest, rspec, cucumber)
- Tasks for packing and publishing gems

And more.




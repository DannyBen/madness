◄ Back to [[Runfile Command Reference]]

-----

## Cheatsheet

```ruby

# --- Running commands and services

run 'pwd'
run! 'pwd' # and exit
run_bg 'rails server'
run_bg 'rails server', log: 'my.log', pid: 'myserver'
stop_bg 'myserver'

# --- Before / After run hooks

before_run do |command|
  command.gsub /^(rails|rake|cucumber)/, "bin/\\1"
end

after_run do |command|
  puts "Finished #{command}"
end

# --- Configuration

Runfile.setup do |config|
  config.pid_dir = 'tmp/pid'
  config.quiet   = true
end

# or...

Runfile.pid_dir = 'tmp'

```

-----

## Reference

### `run <string>`

Print and run a command. Wait until it is done and continue.
This is executed using `system`. If `Runfile.quiet` is true, it will
not echo the command to the console.

__Example:__

```ruby
run "rails server -b* -p3000"
```


### `run! <string>`

Print and run a command, then exit. This is executed using `exec`.
If `Runfile.quiet` is true, it will not echo the command to the console.

__Examples:__

```ruby
run! "rails server -b* -p3000"
puts "this message will never be shown"
```

### `run_bg <string> [, options]`

Run a command in the background, which you can later stop with `stop_bg`. 

Available options are:

- `pid` - provide a string that will be used to name the PID file. 
  This is the string you will later use in `stop_bg`. All PID files will
  be stored in the working directory, or in `Runfile.pid_dir`.
- `log` - provide a filename that will be used to log the output.

__Examples:__

```ruby
run_bg 'some/long-running/process'
run_bg 'some/long-running/process', log: 'my.log', pid: 'daemon'
```

### `stop_bg <string>`

Stop a command started with 'run_bg'. Provide the name of he pid file you 
used in 'run_bg'

__Example:__

```ruby
stop_bg 'server'
```

### `before_run {...}`

Intercept each call before executed. Can be used to modify the command, 
run something before it, or cancel it altogether.

Your block receives the command as argument, and should return a command 
to run or false to stop execution.

__Examples:__

```ruby
# Prefix the command with "bin/" if it is rails, rake or cucumber
before_run do |command|
  cmd.gsub /^(rails|rake|cucumber)/, "bin/\\1"
end

# Abort the command execution based on the value of an environment 
# variable
before_run do |command|
  ENV['PREVENT_EXECUTION'] ? false : command
end
```


### `after_run {...}`

Intercept each call before it exits. Note this is only useful with `run` 
and `run_bg` but not with `run!` which exits immediately after execution.


__Examples:__

```ruby
after_run do |command|
  puts "Finished #{command}"
end
```

## Configuration

You can configure several aspects of how these commands behave.

Configuration can be done in one of two ways. Either use the direct 
syntax: `Runfile.option = value`, or provide a block:

```ruby
Runfile.setup do |config|
  config.option = value
end
```

Add the configuration anywhere in your Runfile (either inside an
action or outside, at the beginning of the file).

### `pid_dir` - configure folder for PID files

PID files are stored in the working directory by default.

```ruby
Runfile.pid_dir = './tmp/pids'
```

### `quiet` - run without echoing the command

By default, calls to `run` will show the command before running it.
Set `quiet` to true to change that.

__Example:__

```ruby
Runfile.quiet = true
```

## Example

See this [example file] sample usage or this [feature file] to get an 
idea of what is possible with this extension.


[example file]: https://github.com/DannyBen/runfile/blob/master/examples/r_exec/Runfile
[feature file]: https://github.com/DannyBen/runfile/blob/master/features/n_exec.feature

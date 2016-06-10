◄ Back to [[Home]]

-----

Runfile provides another mechanism for more advanced uses.

This mechanism lets you have multiple named runfiles per project.

To use this mechanism, you need to:

- Delete the `Runfile` file from your project's folder.
- Create a `.runfile` settings file (YAML) in your project's folder.

The .runfile Configuration File
--------------------------------------------------

```yaml
# .runfile
# Runfile settings YAML 

# Define the folder where *.runfile files reside.
folder: lib/commands

# Optional: File to load before any runfile.
# Consider this your "helper" file.
helper: helper.rb

# Optional: Message to show before the list of files.
# This string supports color markers.
intro: "!txtgrn!My Command Line"

# Optional: An array of shortcut commands
# Each of the keys here will be expanded to their values before Runfile
# tries to move on to the execution stage. In other words, if you have
# a shortcut saying "s: server --daemon", and you run "run s" it is
# exactly like you run "run server --daemon".
shortcuts:
  s: server start
  sd: server start --daemon
  stat: server status
```

To see how it works, check out the [Settings Example][1]

Now, whenever you execute `run`, we will look for `lib/commands/*.runfile`
files and you can execute any of them like any other named runfile.

Running `run` without any argument will show both the runfiles in the folder
and the available shortcuts.


[1]: https://github.com/DannyBen/runfile/tree/master/examples/s_settings
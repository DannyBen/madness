◄ Back to [[Runfile Command Reference]]

-----

## Cheatsheet

```ruby
say 'anything'
say '!txtred!anything in red'
say 'only one !txtred!word!txtrst! in red'
resay 'go back to the beginning of the line'
say_status :download, 'Download in progress'
say_status :download, 'Download in progress', :txtblu
word_wrap '  Indent a potentially wrapping line by two spaces'
say word_wrap '  Indent a potentially wrapping line by two spaces and say it'
```

-----

## Reference

All these commands can be used inside your `:action` blocks.

These commands are provided by the 
[Colsole gem](https://github.com/DannyBen/colsole) which is already 
bundled with Runfile.

### `say <string>`

Print a message to screen, with support for color markers and 
partial strings.

End the string with a space to force the cursor to stay at the same
line (otherwise, a newline is added).

__Examples:__

```ruby
say "Hello world"
say "!txtgrn!I am green"
say "Legen... wait for it... "
say "dary"
```

### `resay <string>`

Erase the current output line and print a new message. Should be 
called only after a space terminated call to `say` to ensure the 
cursor is at the same line.


__Examples:__

```ruby
say "Downloading... "
resay "Downloaded"
```

### `say_status <status>, <message> [, <color>]`

Print a message to screen, with a colored status tag.

__Examples:__

```ruby
say_status :success, "Task completed"
say_status :error, "Task failed", :txtred
```

### `word_wrap <string> [, <length>]`

If you wish to print a string and make it wrap automatically based
on the width of the terminal, use `word_wrap`.

The function is also sensitive to any leading spaces. These will be
preserved in any wrapped line, so it is easy to print indented long 
strings.

__Examples:__

```ruby
say word_wrap("one two three four", 10)
say word_wrap("   one two three four", 10)
say word_wrap "Some long line ... that ends here"
```


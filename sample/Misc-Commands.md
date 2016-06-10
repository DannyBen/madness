◄ Back to [[Runfile Command Reference]]

-----

## Cheatsheet

```ruby
execute 'other_action'
```

-----

## Reference

### `execute <string>`

Call another action. This command accepts a single string argument
which should include the command as if you type it in the command 
prompt (only without the `run` prefix).

__Example:__ `execute "theme watch --all"`

See Also: [Cross Call Example](https://github.com/DannyBen/runfile/blob/master/examples/i_crosscall/Runfile)

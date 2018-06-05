# Madness Usage

```shell
$ madness --help

Madness

Usage:
  madness [PATH] [options]
  madness create config
  madness create theme FOLDER
  madness (-h|--help|--version)

Subcommands:
  create config
    Initialize a new default .madness.yml config file.

  create theme
    Initialize a new theme folder, based on the default theme. You can then
    customize it to your needs and use it with --theme.

Parameters:
  PATH:
    Optional path to the markdown directory.
    (Config option: path)

Options:
  -p, --port NUMBER
    Set server port number.
    (Config option: port)

  -b, --bind ADDRESS
    Set server listen address.
    (Config option: bind)

  --no-auto-h1
    By default, if a markdown document does not start with an H1 caption,
    it will be added automatically based on the file name. To disable this
    behavior, use --no-auto-h1.
    (Config option: auto_h1)

  --no-syntax
    Disable code syntax highlighting.
    (Config option: highlighter)

  --no-line-numbers
    Disable line numbering for syntax highlighter.
    (Config option: line_numbers)

  --no-sidebar
    Disable sidebar navigation.
    (Config option: sidebar)

  --no-auto-nav
    Disable automatic generation of footer navigation for folder README 
    files.
    (Config option: auto_nav)

  --theme FOLDER
    Use a custom theme. FOLDER is either absolute or relative to the main
    documentation path.
    (Config option: theme)

  --index
    Build or rebuild the index for the search page.
    (Config option: index)

  --toc FILE
    Generate a table of contents file. 
    (Config option: toc)

  --and-quit
    Quit instead of running the server. Useful with --index or --toc.

Examples:
  madness
  madness docs
  madness docs --no-auto-h1 -p 4567
  madness --no-sidebar --no-auto-nav
  madness --index --and-quit
  madness --toc "Table of Contents.md" --index --and-quit
  madness --theme _mytheme
  madness create config
  madness create theme

```

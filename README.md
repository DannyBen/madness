Madness - Instant Markdown Server
==================================================

[![Gem Version](https://img.shields.io/gem/v/madness.svg?style=flat-square)](https://rubygems.org/gems/madness)
[![Travis](https://img.shields.io/travis/DannyBen/madness.svg?style=flat-square)](https://travis-ci.org/DannyBen/madness)
[![Code Climate](https://img.shields.io/codeclimate/github/DannyBen/madness.svg?style=flat-square)](https://codeclimate.com/github/DannyBen/madness)
[![Dependencies](https://img.shields.io/gemnasium/DannyBen/madness.svg?style=flat-square)](https://gemnasium.com/DannyBen/madness)

---

Screenshot
--------------------------------------------------

![Screenshot]


Install
--------------------------------------------------

    $ gem install madness


Design Intentions
--------------------------------------------------

Madness was designed in order to provide easy browsing, viewing and 
searching for local, markdown based documentation directories.


Usage
--------------------------------------------------

Go to any directory that contains markdown files and run:

    $ madness

For more options, run:

    $ madness --help


Directory Conventions
--------------------------------------------------

Madness expects to be executed in a documentation directory.

A documentation directory contains only markdown files (`*.md`) and 
sub directories that contain more markdown files.

The server will consider the file `README.md` in any directory as the 
main file describing this directory.

The navigation sidebar will show all the sub directories and files in 
the same directory as the viewed file.

Example structure:

```
./
├── README.md
├── Code.md
├── Double Escape.md
├── File-with-Dashes.md
├── Folder
│   └── File.md
└── Another Folder
    ├── README.md
    ├── Headings.md
    ├── Images.md
    └── Lists.md
```

Configuration File
--------------------------------------------------

All the command line arguments can also be configured through a 
configuration file. Create a file named `.madness.yml` in your 
documentation directory, and modify any of the settings below.

```yaml
# .madness.yml
---
path: '.'
port: '3000'
bind: '0.0.0.0'
autoh1: true
highlighter: true
line_numbers: true
index: false
```


Search
--------------------------------------------------

Madness comes with a full text search page. To activate it, you need to
generate a search index by running `madness --index` or 
`madness path/to/docs --index`.

This will create an `_index` sub folder, and will add a new search page
to your documentation server.

You will need to run this command from time to time, as your 
documents change or new documents are added.


Tips
--------------------------------------------------

**Automatic H1**  
If your markdown document does not start with a level 1 heading, it
will be automatically added based on the file name.

**Hidden Directories**  
Directories that begin with an underscore will not be displayed in the
navigation.

**Images and Static Files**  
Your markdown directory can have a `public` folder. Anything in it
will be served as is. For example, if you have `public/images/ok.png` 
you can access it from your markdown file by typing:

```markdown
![alt text](/images/ok.png)
```


---

[Screenshot]: https://raw.githubusercontent.com/DannyBen/madness/master/screenshot.png


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

    $ bundle install madness


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
subfolders that contain more markdown files.

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



---

[Screenshot]: https://raw.githubusercontent.com/DannyBen/madness/master/screenshot.png

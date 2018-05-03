Madness - Instant Markdown Server
==================================================

[![Gem Version](https://badge.fury.io/rb/madness.svg)](https://badge.fury.io/rb/madness)
[![Build Status](https://travis-ci.com/DannyBen/madness.svg?branch=master)](https://travis-ci.com/DannyBen/madness)
[![Maintainability](https://api.codeclimate.com/v1/badges/fa440dc4dbf895734d74/maintainability)](https://codeclimate.com/github/DannyBen/madness/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/fa440dc4dbf895734d74/test_coverage)](https://codeclimate.com/github/DannyBen/madness/test_coverage)

---


Screenshot
--------------------------------------------------

![screenshot]



Install
--------------------------------------------------

    $ gem install madness



Design Intentions
--------------------------------------------------

Madness was designed in order to provide easy browsing, viewing and 
searching for local, markdown based documentation directories.



Feature Highlights
--------------------------------------------------

- Easy to use
- Built in full text search
- Built in GraphViz diagram generator
- Configure with a configuration file or command arguments



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
development: false
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



Images and Static Files
--------------------------------------------------

Your markdown directory can have a `public` folder. Anything in it
will be served as is. For example, if you have `public/images/ok.png` 
you can access it from your markdown file by typing:

```markdown
![alt text](/images/ok.png)
```


Automatic H1
--------------------------------------------------

If your markdown document does not start with a level 1 heading, it
will be automatically added based on the file name.


Hidden Directories
--------------------------------------------------

Directories that begin with an underscore will not be displayed in the
navigation.



Automatic GraphViz Dot Diagram Generation
--------------------------------------------------

This feature requires that you have GraphViz installed 
(`$ sudo apt install graphviz`).

When you place `*.dot` files in the `_dot` folder (or subfolders), they
can be accessed directly as an image in your Markdown files. 

In development mode, when such files are accessed, Madness will run the
graphviz `dot` command and generate a respective image in the `public` 
folder.

For example, if you have the following graphviz file:

```
# _dot/diagrams/my_diagram.dot
digraph {
  Hello -> World
} 
```

You can access it from your markdown files like this:

```markdown
!['alt text'](/diagrams/my_diagram.dot)
```

This will work in one of two ways:

1. If the server is in development mode (`--development`), then it will 
   create a `png` image in the public folder, and redirect to it.
2. If the server is in production mode, it will redirect to the 
   (previously-generated-) `png` image in the public folder, meaning 
   `public/diagrams/my_diagram.png`



Docker Image
--------------------------------------------------

This gem is also available as a docker image.

This command will start the server on localhost:3000, with the current 
directory as the markdown documentation folder

```shell
$ docker run --rm -it -v $PWD:/docs -p 3000:3000 dannyben/madness
```

For more information see:

- [Madness image on Docker Hub][dockerhub]
- [Madness Dockerfile][dockerfile]



---

[screenshot]: https://raw.githubusercontent.com/DannyBen/madness/master/screenshot.png
[dockerhub]: https://hub.docker.com/r/dannyben/madness/
[dockerfile]: https://github.com/DannyBen/docker-madness



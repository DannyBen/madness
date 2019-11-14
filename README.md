Madness - Instant Markdown Server
==================================================

[![Gem Version](https://badge.fury.io/rb/madness.svg)](https://badge.fury.io/rb/madness)
[![Build Status](https://travis-ci.com/DannyBen/madness.svg?branch=master)](https://travis-ci.com/DannyBen/madness)
[![Maintainability](https://api.codeclimate.com/v1/badges/fa440dc4dbf895734d74/maintainability)](https://codeclimate.com/github/DannyBen/madness/maintainability)

---

Screenshots (click to zoom)
--------------------------------------------------

<table><tr>
  <td><a target='_screenshot' href='assets/screen-main.png'><img src='assets/screen-main.png'/></a></td>
  <td><a target='_screenshot' href='assets/screen-nav.png'><img src='assets/screen-nav.png'/></a></td>
  <td><a target='_screenshot' href='assets/screen-code.png'><img src='assets/screen-code.png'/></a></td>
  <td><a target='_screenshot' href='assets/screen-search.png'><img src='assets/screen-search.png'/></a></td>
</tr></table>



Table of Contents
--------------------------------------------------

* [Install](#install)
* [Design Intentions](#design-intentions)
* [Feature Highlights](#feature-highlights)
* [Usage](#usage)
* [Directory Conventions](#directory-conventions)
* [Configuration File](#configuration-file)
* [Search](#search)
* [Images and Static Files](#images-and-static-files)
* [Automatic H1](#automatic-h1)
* [Table of Contents Generation](#table-of-contents-generation)
* [Hidden Directories](#hidden-directories)
* [Controlling Sort Order](#controlling-sort-order)
* [Customizing Theme](#customizing-theme)
* [Forcing HTTPS Connection](#forcing-https-connection)
* [Docker Image](#docker-image)



Install
--------------------------------------------------

    $ gem install madness



Design Intentions
--------------------------------------------------

Madness was designed in order to provide easy browsing, viewing and 
searching for local, markdown based documentation directories.



Feature Highlights
--------------------------------------------------

- Easy to use.
- Built-in full text search.
- Compatible with how markdown files are displayed on GitHub and GitHub pages.
- Configure with a configuration file or command arguments.
- Fully customizable theme.
- Automatic generation of navigation sidebar.
- Automatic generation of Table of Contents.



Usage
--------------------------------------------------

Go to any directory that contains markdown files and run:

    $ madness

For more options, run:

    $ madness --help

Executing `madness` will start a webserver and allow you to browse your
rendered markdown files using a webbrowser.  By
[default](#configuration-file), the URL you have to visit is
`http://0.0.0.0:3000` (thus also available in your network).

If you do not have Ruby installed, you can also 
[run madness with docker](#docker-image).



Directory Conventions
--------------------------------------------------

Madness expects to be executed in a documentation directory.

A documentation directory contains only markdown files (`*.md`) and 
sub directories that contain more markdown files.

The server will consider the file `index.md` or `README.md` in any directory 
as the main file describing this directory, where `index.md` has priority.

The navigation sidebar will show all the sub directories and files in 
the same directory as the viewed file.

Example structure:

```
./
├── README.md
├── File.md
├── Another File.md
├── Folder
│   ├── File.md
│   └── image.png
└── Another Folder
    ├── README.md
    └── File.md
```



Configuration File
--------------------------------------------------

All the command line arguments can also be configured through a 
configuration file. Create a file named `.madness.yml` in your 
documentation directory, and modify any of the settings below.

```yaml
# .madness.yml
path: '.'
port: '3000'
bind: '0.0.0.0'
sidebar: true
auto_h1: true
auto_nav: true
highlighter: true
line_numbers: true
index: false
toc: Table of Contents
theme: _theme
```

For convenience, you can get a template config file by running:

```shell
$ madness create config
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

You can put images and other asset files anywhere in your documentation
folder.

When linking to other pages or images in your documentation folder, simply
use the URL relative to the markdown file. 

For example, if you have a folder named `subfolder` that contains a 
`README.md` and a `nice-picture.png`, showing it in your `README` is done by
this markdown:

```markdown
![alt text](nice-picture.png)
```

If you wish to link to images or pages in a different folder, simply specify
the path relative to the homepage:

```
![alt text](/images/nice-picture.png)
```



Automatic H1
--------------------------------------------------

If your markdown document does not start with a level 1 heading, it
will be automatically added based on the file name.



Table of Contents Generation
--------------------------------------------------

You can use the `madness --toc` command to generate a "Table of Contents" 
markdown file.



Hidden Directories
--------------------------------------------------

Directories that are made only of lowercase letters, underscoes, dash and/or
numbers (`/^[a-z_\-0-9]+$/`) will not be displayed in the navigation. In
other words, directories must have at least one uppercase letter or a space
to be recognized as a documentation directory.



Controlling Sort Order
--------------------------------------------------

To control the sort order of the automatically generated navigation elements,
simply perfix your files and directories with digits followed by a dot and a 
space, just like you would create an ordered list in Markdown. The numbers
will be omitted when they are displayed.

```
./
├── 1. Some file or folder
└── 2. Another file or folder
```



Customizing Theme
--------------------------------------------------

There are two ways to change how Madness looks. 


### Option 1: Change CSS and HTML (Slim)

In order to have complete control over the CSS and generated HTML, you
can override the views and styles. Views are provided as Slim templates, 
and CSS is provided as SCSS.

Madness comes with a command that copies the default theme to a folder of
your choice, where you can customize it to your taste. Run:

```shell
$ madness create theme my_theme
```

Where `my_theme` is the folder that will be created.

To use the created theme, simply run Madness with the `--theme my_theme`
option.

```shell
$ madness --theme my_theme
```


### Option 2: Change CSS only

If you are looking to implement a smaller CSS change, follow these steps:

- Create a directory named `css` in your root documentation directory.
- Copy the [main.css][css] file to it.
- Update it as you see fit.

Note that this functionality is not guaranteed to stay as is in future 
versions of madness.



Forcing HTTPS Connection
--------------------------------------------------

To have Madness redirect HTTP traffic to HTTPS, set this environment 
variable:

    $ export MADNESS_FORCE_SSL=1



Docker Image
--------------------------------------------------

Madness server is also available as a docker image.

This command will start the server on localhost:3000, with the current 
directory as the markdown documentation folder

```shell
$ docker run --rm -it -v $PWD:/docs -p 3000:3000 dannyben/madness
```

For more information about the docker image, see:

- [Madness image on Docker Hub][dockerhub]
- [Madness Dockerfile and Docker Compose][dockerfile]



---

[dockerhub]: https://hub.docker.com/r/dannyben/madness/
[dockerfile]: https://github.com/DannyBen/docker-madness
[css]: app/public/css/main.css
[app]: app


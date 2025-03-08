<!-- TOC -->

H1 header will be added automatically
TOC will be added automatically

## Blockquote and code

> Blockquote
> as a multiline section
> with **markdown support** in it

Inline `code_word` and block code:

```ruby
def say(message = "Hi")
  puts message
end
```

## Footnotes, Images

This needs a footnote explanation[^1]

![Random Image](https://picsum.photos/200/200)

## Links

*Not all are supported*

- [Standard link](http://example.com)
- [Reference link]
- [Explicit reference link][Reference link]
- Bracketed link <http://www.example.com>
- Autolink www.example.com
- Another Autolink http://example.com

## Lists

*Not all are supported*

- Unordered list
  - With
  - nesting
- Another item

1. Ordered
2. List
  1. with
  2. nesting

- [x] This is done
- [ ] This is not

Definition List Term
: Description

## Tables and Keyboard

Press <kbd>F12</kbd> to open the console.

| Shortcut       | Result                       |
|----------------|------------------------------|
| <kbd>F12</kbd> | Open console                 |

## Text Decorations

- This is a **Bold Text**
- This is an *Italic Text*
- This is a ~~Strikethrough Text~~
- This is a ***Bold Italic Text***
- This is an _Underlined Text_
- This is a _**Bold Underlined Text**_
- This is a ==Highlighted Text==
- This is a ^superscript

## Mermaid Diagrams

Mermaid is supported (after enabling it in the config) by placing the diagram
code inside a mermaid div:

<div class='mermaid'>
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
</div>

Or using the `mermaid` code block:

```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```

## Unsafe HTML

This is calculated by Javascript: <span id='demo'></div>

<script>document.getElementById("demo").innerHTML = 5 + 6;</script>


[^1]: Footnote explanation
[Reference link]: http://example.com

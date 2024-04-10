# File with TOC and Code

<!-- TOC -->

This file ensures that headers in code blocks (including nested code blocks)
are ignored in TOC generation

````

## Header trap (should not be included)

The below is displayed as is (unparsed)

```
## Code block in code block (also a trap)
```

````

```markdown
## Header in code block with language identifier
```

## Header 2

Some text

### Level 3 header

More text

## Another Header 2

Even more text


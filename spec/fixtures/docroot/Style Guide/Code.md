The `CommandLine` class is responsible for handling the execution from 
the command line. Its `#execute` method is called from `bin/madness`.

## Example

```ruby
def execute(argv=[])
  if argv.empty?
    launch_server
  else
    launch_server_with_options argv
  end
end
```

## Overflow?

```ruby
class Server < ServerBase
  get '/*' do
    path = params[:splat].first
    debug = nil

    doc = Document.new path
    dir     = doc.dir
    content = doc.content

    nav = Navigation.new(dir)
    breadcrumbs = Breadcrumbs.new(path).links

    slim :document, locals: { content: content, type: doc.type, nav: nav, breadcrumbs: breadcrumbs, debug: debug }
  end
end
```

## Without Syntax Highlighting

```
class Server < ServerBase
  def serve(path, &block)
    slim path
  end
end
```
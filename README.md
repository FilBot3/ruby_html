# RubyHtml

Welcome to to the `ruby_html` gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/ruby_html`. To experiment with that code, run `bin/console` for an interactive prompt.

This gem is meant to be a hobby project, but also works to generate HTML using a Ruby DSL. It can do most HTML tags, and can be easily extended to add others. Examples are below.

This DSL was a collimation of all the blogs and how-to's on creating DSLs in Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby_html'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby_html

## Usage

Example Code!!

### Inline CSS
```
require 'ruby_html'

output = RubyHtml::Generator.new.document do
  head do
    title 'A sample Ruby generated HTML'
    style('
.flex-container {
  display: -webkit-flex;
  display: flex;
  -webkit-flex-flow: row wrap;
  flex-flow: row wrap;
  text-align: center;
}
.flex-container > * {
  padding: 15px;
  -webkit-flex: 1 100%;
  flex: 1 100%;
}
.article {
  text-align: left;
}
header {background: black;color:white;}
footer {background: #aaa;color:white;}
.nav {background:#eee;}
.nav ul {
  list-style-type: none;
  padding: 0;
}
.nav ul a {
  text-decoration: none;
}
@media all and (min-width: 768px) {
  .nav {text-align:left;-webkit-flex: 1 auto;flex:1 auto;-webkit-order:1;order:1;}
  .article {-webkit-flex:5 0px;flex:5 0px;-webkit-order:2;order:2;}
  footer {-webkit-order:3;order:3;}
}
'
    )
  end
  body do
    div( class: 'flex-container' ) {
      header {
        h1( 'City Gallery' )
      }
      nav( class: :nav ) {
        ul {
          li('London')
          li('Paris')
          li('Tokyo')
        }
      }
      article( class: :article ) {
        h1('London')
        par('London is the capital city of Egland. It is big.')
        par('Blah Blah Blah')
        par {
          strong('Resize this page!')
        }
      }
      footer('Copyright &copy; W3Schools.com')
    }
  end
end
puts output
::File.open('index.html', 'w') do |file|
  file.write(output)
  file.close
end
```

### External Style Sheet
```
require 'ruby_html'

output = RubyHtml::Generator.new.document do
  head do
    title 'A sample Ruby generated HTML'
    link( :rel => 'stylesheet', :type => 'text/css', :href => 'flex_container.css' )
  end
  body do
    div( class: 'flex-container' ) {
      header {
        h1( 'City Gallery' )
      }
      nav( class: :nav ) {
        ul {
          li('London')
          li('Paris')
          li('Tokyo')
        }
      }
      article( class: :article ) {
        h1('London')
        par('London is the capital city of Egland. It is big.')
        par('Blah Blah Blah')
        par {
          strong('Resize this page!')
        }
      }
      footer('Copyright &copy; W3Schools.com')
    }
  end
end
puts output
::File.open('index.html', 'w') do |file|
  file.write(output)
  file.close
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Predatorian3/ruby_html. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


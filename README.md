# Log Parser

A simple log parser that prints two list:
- Webpages with most page views ordered by number of views
- Webpages with most unique page views ordered by number of unique visitors

The format of the log file should follow this format:
```shell
/help_page/1 126.318.035.038
/contact 184.123.665.067
/home 184.123.665.067
```

See webserver.log for a full example.

## Usage

### Installation:

Install ruby version 2.7.0 using your favorit version manager for ruby.

If using rvm, you just need to run
``` shell
rvm install "ruby-2.7.0"
```

Install bundler if not done already
``` shell
gem install bundler
```

Then install the gem for development and test
``` shell
bundle install
```

### Use Log Parser

To use the log parser, you can either use:
```shell
bin/console
```

Which will start a ruby shell with all the files you need to run the program. So you can then run in your ruby shell:
```ruby
WebLogParser.run('./webserver.log')
```

or you can call directly run with the file you want to use
```shell
bin/run webserver.log
```

## Testing

Tests built using rspec, to run the suite do:

```shell
rspec spec/
```
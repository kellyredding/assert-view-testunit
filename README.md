# Test-Unit style views for Assert

This is a package for some assert views based on the old test-unit style output.  For use with [Assert](https://github.com/teaminsight/assert) ~>0.8.

## Views

### `TestUnitView`

This is a view that outputs test result info much like the original test/unit framework output its results.  Not every detail can be reproduced exactly because assert tracks result data in more detail and this view shows its results using that full detail.

### `RedgreenView`

This view adds simple colored output to the `TestUnitView`.  Not every
detail can be reproduced exactly because assert tracks result data in more
detail and this view shows its results using that full detail.

This view is identical to the TestUnitView, except:
- each result abbreviation is colored
- each detailed result has its name colored
- the results_breakdown_statement is colored

It is designed based on the [redgreen gem](https://rubygems.org/gems/redgreen).

## Installation

The easiest way to install is to clone this repo into your `~/.assert/views` dir:

```sh
cd ~/.assert/views
git clone git://github.com/kellyredding/assert-view-testunit.git
```

See the Assert README for details on using 3rd party assert views.  https://github.com/teaminsight/assert#using-3rd-party-views

# Usage

If the view package has been installed to the user assert views dir as shown above, require it in your options file and set it as the view:

```ruby
# in ~/.assert/options.rb

Assert::View.require_user_view  'assert-view-testunit'

Assert.options.view             Assert::View::TestUnitView.new($stdout)
# or...
Assert.options.view             Assert::View::RedgreenView.new($stdout)
```

That's about it.  Run your assert test suite and see the new view in action.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

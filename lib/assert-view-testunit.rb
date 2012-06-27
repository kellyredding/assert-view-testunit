# require in the base view from assert
require 'assert/view/base'

# because this repo holds more than one view, we'll add the lib dir to the load
# path and require in the views this provides

$:.push File.expand_path("../../lib", __FILE__)

require 'assert-view-testunit/test_unit_view'
require 'assert-view-testunit/redgreen_view'

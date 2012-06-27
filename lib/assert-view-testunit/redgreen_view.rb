$:.push File.expand_path("../../../lib", __FILE__)
require 'assert-view-testunit/test_unit_view'

module Assert::View

  # This view adds simple colored output to the TestUnitView.  Not every
  # detail can be reproduced exactly because assert tracks result data in more
  # detail and this view shows its results using that full detail.

  # this view is identical to the TestUnitView, except:
  # - each result abbreviation is colored
  # - each detailed result has its name colored
  # - the results_breakdown_statement is colored

  class RedgreenView < TestUnitView

    require 'assert/view/helpers/capture_output'
    include Helpers::CaptureOutput

    require 'assert/view/helpers/ansi_styles'
    include Helpers::AnsiStyles

    options do
      styled         true
      pass_styles    :green
      fail_styles    :red
      error_styles   :yellow
      skip_styles    :yellow
      ignore_styles  :yellow
    end

    # override the on_result handler to style the abbreviation
    def on_result(result)
      result_abbrev = options.send("#{result.to_sym}_abbrev")
      styled_abbrev = ansi_styled_msg(result_abbrev, result_ansi_styles(result))

      # list out an abbrev for each test result as it is run
      print styled_abbrev
    end

    protected

    # override these protected methods to style the result details and summary info

    def output_result_details(result, test, index)
      name = ansi_styled_msg(result.name, result_ansi_styles(result.to_sym))
      puts "  #{index}) #{name}:"
      puts "#{result.test_name} (#{test.context_class.name}):"
      puts result.message
      puts "    #{result.backtrace.filtered.first.to_s}"
    end

    def build_results_summary
      results_summary_sentence do |summary, sym|
        # style the summaries of each result set
        ansi_styled_msg(summary, result_ansi_styles(sym))
      end
    end

  end

end

module Assert::View

  # This is a view that outputs test result info much like the original test/unit
  # framework output its results.  Not every detail can be reproduced exactly
  # because assert tracks result data in more detail and this view shows its
  # results using that full detail.

  class TestUnitView < Base

    require 'assert/view/helpers/capture_output'
    include Helpers::CaptureOutput

    def after_load
      puts "Loaded suite (#{test_count_statement})"
    end

    def on_start
      if tests?
        puts "Running tests in random order, seeded with \"#{runner_seed}\""
      end
    end

    def on_result(result)
      print options.send("#{result.to_sym}_abbrev")
    end

    def on_finish
      if tests?
        output_finished_statement
        result_details_for(suite.ordered_tests).each do |details|
          if show_result_details?(details.result)
            output_result_details(details.result, details.test, details.test_index)
            output_captured_output(details.output)
          end
        end
      end

      output_results_summary_info
    end

    protected

    def output_finished_statement
      print "\n"
      puts
      puts "Finished in #{run_time} seconds."
      puts
    end

    def output_result_details(result, test, index)
      puts "  #{index}) #{result.name}:"
      puts "#{result.test_name} (#{test.context_class.name}):"
      puts result.message
      puts "    #{result.backtrace.filtered.first.to_s}"
    end

    def output_captured_output(output)
      puts captured_output(output) if output && !output.empty?
      puts
    end

    def output_results_summary_info
      t_count = "#{count(:tests)} tests"
      r_count = "#{count(:results)} assertions"
      summary = build_results_summary

      puts "#{t_count}, #{r_count}, #{summary}"
    end

    def build_results_summary
      results_summary_sentence
    end

  end

end

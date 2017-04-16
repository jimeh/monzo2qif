require 'active_support/core_ext/time/calculations'
require 'trollop'

require 'monzo2qif/runner'
require 'monzo2qif/version'

module Monzo2QIF
  class CLI
    attr_reader :options

    def self.run(args = [])
      new(args).run
    end

    def initialize(args)
      @options = parse_args(args)
    end

    def run
      runner = Runner.new(options)
      runner.run
    end

    private

    def parse_args(args)
      opts = Trollop.with_standard_exception_handling(parser) do
        parser.parse(args.clone)
      end

      if opts[:start_date]
        opts[:start_date] = Time.parse(opts[:start_date]).beginning_of_day
      end

      if opts[:end_date]
        opts[:end_date] = Time.parse(opts[:end_date]).end_of_day
      end

      opts
    end

    def parser
      @parser ||= begin
        parser = Trollop::Parser.new
        parser.banner 'Usage: monzo2qif [options]'
        parser.version "monzo2qif #{VERSION}"

        define_options(parser)
        parser.banner ''
        parser
      end
    end

    def define_options(parser)
      parser.banner "\nOptions:"
      parser.opt :token, 'Monzo account token - https://developers.monzo.com/',
                 short: 't', type: :string, required: true
      parser.opt :include_unsettled, 'Include unsettled transactions',
                 short: 'u', type: :bool
      parser.opt :start_date, 'Start date (optional)', short: 's', type: :string
      parser.opt :end_date, 'End date (optional)', short: 'e', type: :string
      parser.opt :output_dir,
                 'Output directory (defaults to current working directory)',
                 short: 'o', type: :string
    end
  end
end

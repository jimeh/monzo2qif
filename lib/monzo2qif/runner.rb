require 'mondo'

require 'monzo2qif/transaction'

module Monzo2QIF
  class Runner
    attr_reader :token
    attr_reader :start_date
    attr_reader :end_date
    attr_reader :output_dir
    attr_reader :include_unsettled

    DATE_FORMAT = '%Y-%m-%d'.freeze

    def initialize(options)
      @token = options[:token]
      @start_date = options[:start_date]
      @end_date = options[:end_date]
      @output_dir = options[:output_dir]
      @include_unsettled = options[:include_unsettled]
    end

    def run
      count = 0
      Qif::Writer.open(filepath, 'Bank', 'dd/mm/yyyy') do |qif|
        transactions.each do |t|
          if t.declined?
            puts "Skipping declined: #{t}"
            next
          end

          if !include_unsettled && !t.settled?
            puts "Skipping unsettled: #{t}"
            next
          end

          count += 1
          qif << t.to_qif
        end
      end

      puts "Exported #{count} transactions to #{filepath}"
    end

    private

    def filepath
      dir = File.expand_path(output_dir || Dir.pwd)
      File.join(dir, filename)
    end

    def filename
      "#{account_name} (#{filename_start_date} - #{filename_end_date}).qif"
    end

    def filename_start_date
      time = start_date || transactions.last.date
      time.strftime(DATE_FORMAT)
    end

    def filename_end_date
      time = end_date || transactions.first.date
      time.strftime(DATE_FORMAT)
    end

    def account_name
      @account_name ||= account.description
    end

    def account
      @account ||= client.accounts.first
    end

    def transactions
      @transactions ||= client.transactions(transactions_opts)
                              .map { |t| Transaction.new(t) }
                              .sort_by(&:date).reverse
    end

    def transactions_opts
      opts = {}
      opts[:since] = start_date.iso8601 if start_date
      opts[:before] = end_date.iso8601 if end_date
      opts
    end

    def client
      @client ||= Mondo::Client.new(token: token)
    end
  end
end

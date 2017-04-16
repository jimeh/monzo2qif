require 'active_support/core_ext/object/blank'
require 'qif'

module Monzo2QIF
  class Transaction
    attr_reader :source

    def initialize(monzo_transaction)
      @source = monzo_transaction
    end

    def declined?
      source.declined?
    end

    def settled?
      source.settled.present?
    end

    def to_qif
      Qif::Transaction.new(qif_attributes)
    end

    def to_s
      "#<#{self.class} #{qif_attributes}>"
    end

    def date
      source.created
    end

    def payee
      source.description
    end

    def amount
      source.amount.to_f
    end

    def memo
      source.notes unless source.notes == ''
    end

    private

    def qif_attributes
      attrs = {
        date: date,
        amount: amount,
        payee: payee
      }

      attrs[:memo] = memo if memo
      attrs
    end
  end
end

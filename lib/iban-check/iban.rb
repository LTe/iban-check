module Iban
  class IbanCheck

    BRANCH_WEIGHT       = [7,1,3,9,7,1,3]
    BRANCH_WEIGHT_CHECK = [3,9,7,1,3,9,7,1]

    attr_accessor :iban, :branch, :country

    def initialize(options = {})
      self.iban     = options[:iban].gsub(/[^A-Za-z0-9]/, '')
      self.country  = options[:country] || try_get_country
      self.branch   = options[:branch] || self.iban[2..9]
    end

    def check_branch
      number = self.branch.split(//)
			number.pop

      result = 0

      number.each_with_index do |item, index|
        result += item.to_i * BRANCH_WEIGHT[index]
      end

      result % 10
    end

    def branch?
      number = self.branch.split(//)
      result = 0

      number.each_with_index do |item, index|
        result += item.to_i * BRANCH_WEIGHT_CHECK[index]
      end

      if result.to_s[-1] == 48
				true
			else
				false
			end
    end

    def checksum
      checksum = 98 - (prepare_iban % 97)

      if checksum < 10
        "0#{checksum}"
      else
        checksum.to_s
      end
    end

    def iban?
      checksum == iban[0..1]
    end

    private

    def prepare_iban
      result = country + reset_checksum(self.iban.dup)

      result = result.split(//)
      4.times { result.rotate }

      result.map! do |item|
        item.switch
      end

      result = result.join.to_i
    end

    def reset_checksum(number)
      number[0] = number[1] = "0"
      number
    end

    def try_get_country
      if iban[0].chr =~ /[A-Z]/ and iban[1].chr =~ /[A-Z]/
        result = iban[0..1]
        iban.sub!(/^[A-Z]{2}/, '')

        result
      else
        raise "No country specified"
      end
    end

  end
end

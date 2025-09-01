module StringCalculator
  class Calculator
    class NegativeNumbersError < ArgumentError; end

    def self.add(numbers)
      return 0 if numbers.to_s.strip.empty?

      delimiter, body = parse_delimiter(numbers)

      delimiters = [",", "\n"]
      delimiters << delimiter if delimiter && !delimiter.empty?
      regex = Regexp.union(*delimiters)

      ints = body.split(regex).map(&:to_i)

      negatives = ints.select(&:negative?)
      raise NegativeNumbersError, "negative numbers not allowed #{negatives.join(',')}" if negatives.any?

      ints.sum
    end

    private_class_method def self.parse_delimiter(input)
      if input.start_with?("//")
        header, body = input.split("\n", 2)
        custom = header[2..-1] || ""
        [custom, body.to_s]
      else
        [nil, input]
      end
    end
  end
end

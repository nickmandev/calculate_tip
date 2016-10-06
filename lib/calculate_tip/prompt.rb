module CalculateTip
  class Prompt
    attr_accessor :amount, :percent

    def start
      handle_amount
      handle_percent
      handle_response
    end

    def get_user_input
      gets.chomp
    end

    def handle_amount
      begin
        puts "Please provide amount: "
        input = get_user_input
        @amount = input.scan(/[\d,.-]+/).join("").to_f
        @currency = input.scan(/[a-zA-Z]/).join("").upcase
        raise print "You've entered negative amount!\n" unless @amount > 0
      rescue
        retry
      end
    end


    def handle_percent
      puts "Please provide tip (%): "
      @percent = get_user_input
      @percent = 15 if @percent.to_f.zero?
    end

    def handle_response
      response = CodeRunnersAPI.calc_tip(@amount, @percent)
      puts "Total amount with tip: #{response[:amount_with_tip]} #{@currency}"
      puts "Tip amount: #{response[:tip]} #{@currency}"
    end
  end
end
module CalculateTip
  class CodeRunnersAPI
    MAX_RETRIES = 3

    def self.calc_tip(amount, percent)
      begin
        uri = URI("http://office.code-runners.com:8888")
        req = Net::HTTP.post_form(uri,'amount' => "#{amount}", "tip" => "#{percent}")
      rescue Net::ReadTimeout => error
        if times_retried < MAX_RETRIES
          times_retried += 1
          puts "Failed to connect to the remote server, retrying #{times_retried}/#{MAX_RETRIES}"
          retry
        else
          puts "Exiting script. Remote server is unavailable."
          exit(1)
        end
      end
      JSON.parse(req.body, :symbolize_names => true)
    end
  end
end
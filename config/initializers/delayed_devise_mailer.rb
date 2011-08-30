 module Devise
    module Models
        module Confirmable
            handle_asynchronously :send_confirmation_instructions, :run_at => Proc.new { 5.minutes.from_now.in_time_zone }
        end

        module Recoverable
            handle_asynchronously :send_reset_password_instructions, :run_at => Proc.new { 5.minutes.from_now.in_time_zone }
        end

        module Lockable
            handle_asynchronously :send_unlock_instructions, :run_at => Proc.new { 5.minutes.from_now.in_time_zone }
        end
    end
  end
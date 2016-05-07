defmodule Netmonit do
  def check_net(state, _state_change_time) do
    new_state = case System.cmd("ping",["-c", "1", "google.ro"]) do
      {_output, code} when code != 0 -> 
        if state != :down do
          System.cmd "terminal-notifier",["-message", "#{format_time} No internet connection"]
          :down
        else
          IO.puts "Internet still down"
          state
        end
      _ ->
        if state != :up do
          System.cmd "terminal-notifier",["-message", "#{format_time} Internet connection is back"]
          :up
        else
          IO.puts "Internet still up"
          state
        end
    end

    :timer.sleep(20000)
    check_net(new_state, :calendar.local_time)

  end

  defp format_time do
    {{year, month, day}, {hour, min, sec}} = :calendar.local_time

    "#{year}.#{month}.#{day} at #{hour}:#{min}:#{sec} ->"
  end
end

Netmonit.check_net(:up, :calendar.local_time)
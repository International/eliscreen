defmodule Netmonit do
  def check_net(state, _state_change_time) do
    new_state = case System.cmd("ping",["-c", "1", "google.com"]) do
      {_output, code} when(code != 0) and (state != :down) -> 
        :down
      _ ->
        if state != :up do
          :up
        else
          state
        end
    end

    if new_state != state do
      send_notification!(notification_msg(state, new_state))
    else
      IO.puts "Internet state is still: #{state}"
    end

    :timer.sleep(sleep_time)
    check_net(new_state, :calendar.local_time)

  end

  defp notification_msg(:up,:down) do
    "No internet connection"
  end

  defp notification_msg(:down,:up) do
    "Internet connection is back"
  end

  defp send_notification!(msg) do
    System.cmd "terminal-notifier",["-message", "#{format_time} #{msg}"]
  end

  defp sleep_time do
    5 * 60000
  end

  defp format_time do
    {{year, month, day}, {hour, min, sec}} = :calendar.local_time

    "#{year}.#{month}.#{day} at #{hour}:#{min}:#{sec} ->"
  end
end

Netmonit.check_net(:up, :calendar.local_time)
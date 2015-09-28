case System.argv do
  [dir_name |_ ] ->
    try do
      for _ <- Stream.cycle([:ok]) do

        {{year, month, day}, {hour, minute, sec}} = :calendar.local_time()

        path_start = Path.join([dir_name, to_string(year), to_string(month), to_string(day), to_string(hour)])

        case File.mkdir_p(path_start) do
          :ok ->
            destination = Path.join([path_start, "#{:os.system_time(:seconds)}.png"])
            case System.cmd "gnome-screenshot", ["-f", destination] do
              {_, 0} ->
                IO.puts "Saved #{destination}"
              {output, code} ->
                IO.puts "Error taking screenshot: #{output} code: #{code}"
                throw :halt
            end
          _ ->
            IO.puts "Error making dir!"
        end

        :timer.sleep(60 * 1000)
      end
    catch   
      :halt -> IO.puts "Finished taking screenshots!"
    end

   _ -> IO.puts "Please supply a folder name"
end

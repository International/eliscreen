case System.argv do
  [dir_name |_ ] ->
    {{year, month, day}, {hour, minute, sec}} = :calendar.local_time()

    path_start = Path.join(dir_name, to_string(year))
    case File.mkdir_p(path_start) do
      :ok ->
        IO.puts "Succesfully created #{path_start}"
      _ ->
        IO.puts "Error!"
    end
    #
    # case System.cmd "echo", ["hello"] do
  #   {output, 0} ->
    #     IO.puts "Output was #{output}"
  #   {output, code} ->
    #     IO.puts "Error, code #{code}"
    # end

    #     throw :halt
    #   end
    # catch
      #   :halt -> IO.puts "Finished processing"
      # end

   _ -> IO.puts "Please supply a folder name"
end
# if length(System.argv) == 1 do
#   # try do
#   #   for _ <- Stream.cycle([:ok]) do
# else
#   IO.puts "Need the folder name as an argument"
# end

try do
  for _ <- Stream.cycle([:ok]) do
    {{year, month, day}, {hour, minute, sec}} = :calendar.local_time()

    IO.puts year

    case System.cmd "echo", ["hello"] do
      {output, 0} ->
        IO.puts "Output was #{output}"
      {output, code} ->
        IO.puts "Error, code #{code}"
    end

    throw :halt
  end
catch
  :halt -> IO.puts "Finished processing"
end

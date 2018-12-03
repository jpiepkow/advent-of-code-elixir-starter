defmodule AdventOfCode2018.Day03 do
	def decode(nil), do: false
	def decode(_), do: true
	def check_overlap(arr) do
		m = Enum.reduce(arr,[],fn({id,left,top,width,height} = x,acc) -> 
			for x <- left + 1..(left+width), y <- top + 1..(top+height) do
				{x,y}
			end ++ acc
		end)
		|> Enum.reduce(%{},fn(x,acc) -> 
			Map.update(acc, x, 1, fn(x) -> x + 1 end)
		end)
		|> Enum.filter(fn
			{_,1} -> false
			{_,_} -> true
			end)
		IO.inspect(length(m))
		m = m |> Enum.into(%{})
		
		Enum.reduce(arr,[],fn({id,left,top,width,height} = x,acc) -> 
			val = for x <- left + 1..(left+width), y <- top + 1..(top+height) do
				decode(Map.get(m,{x,y},nil))
			end |> Enum.any?(fn(x) -> x == true end)
			[{id,val} | acc]
		end)
		|> Enum.filter(fn 
			{id,true} -> false
			{id,false} -> true
			end)
		|> IO.inspect
	end
  def part1(args) do
  	String.split(args, "\n", trim: true)
  	|> Enum.map(fn(x) -> 
  		[one,two] = String.split(x,":", trim: true)	
  		[width,height] = String.split(two, "x", trim: true)
  		[o,t,tr] = String.split(one, " ", trim: true)
  		[left,top] = String.split(tr,",", trim: true)
  		{o,String.to_integer(left),String.to_integer(top),String.to_integer(String.trim(width)),String.to_integer(height)}
  	end)
  	|> check_overlap()
  end

  def part2(args) do
  	# ended up finish both solutions in check_overlap
  end
end

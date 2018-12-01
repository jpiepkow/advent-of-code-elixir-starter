defmodule AdventOfCode2018.Day01 do
	def redu(arr,tup,loop) do
		new_tup = Enum.reduce_while(arr,tup,fn(x,{val,map,_}) -> 
			new_freq = arit(x,val)
			is_val = Map.get(map, new_freq)
			if not is_nil(is_val) do
				{:halt,{new_freq,Map.put(map,new_freq,new_freq),is_val}}	
			else
				{:cont,{new_freq,Map.put(map,new_freq,new_freq),nil}}
			end
		end) 

		{_,_,val} = new_tup

		if loop == true and is_nil(val) do
			redu(arr,new_tup,true)			
		else
			new_tup
		end
		
	end

	def arit("+" <> rest, val), do: val + String.to_integer(rest)
	def arit("-" <> rest,val), do: val - String.to_integer(rest)

  def part1(args) do
		String.split(args,"\n", [trim: true])
		|> redu({0,%{},nil},false)
  end
  def part2(args) do
  	String.split(args,"\n", [trim: true])
		|> redu({0,%{},nil},true)
  end
end

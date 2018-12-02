defmodule AdventOfCode2018.Day02 do

	def get_checksum([],map) do
		map[2] * map[3]
	end

	def get_checksum([val|rest],map) do
		inner_map = String.split(val,"", trim: true)
		|> Enum.reduce(%{},fn(x,acc) -> 
			Map.put(acc,x,Map.get(acc,x,0) + 1)
		end)
		new = inner_map |> Enum.reduce(map,fn(x,acc) -> 
			part_of_checksum(x,acc) 
		end)

		get_checksum(rest,reset(new))	
	end

	def part_of_checksum({k,2},%{"two" => false} = map) do
		Map.update!(map, 2, fn(current) -> 
			current + 1
		end) |> Map.update!("two", fn(x) -> true end)
	end	
	def part_of_checksum({k,3},%{"three" => false} = map) do
		Map.update!(map, 3, fn(current) -> 
			current + 1
		end) |> Map.update!("three", fn(x) -> true end)
	end	
	def part_of_checksum({_,_},map) do
		map
	end	
	
	def reset(map) do
		map |> Map.update!("two", fn(x) -> false end) |> Map.update!("three", fn(x) -> false end)
	end

	def part2(args) do
		arr = String.split(args,"\n",trim: true)

		{_,{s1,s2}} = arr |> Enum.reduce({0,"",""},fn(x,acc) -> 
			{dis,v,c} = check_closest_string(x,arr) 
			check_distance(dis,{v,c},acc)
		end) 
		String.myers_difference(s1,s2) |> pull_eql("")
	end

	def check_closest_string(x,arr) do
		{amt,val} = Enum.reduce(arr,{0,""},fn(y,{distance,str}) -> 
			check_distance(String.jaro_distance(x,y),y,{distance,str})
		end)
		{amt,val,x}
	end

	def check_distance(val,new_str,{distance,_,_}) when val > distance and val != 1.0, do: {val,new_str}
	def check_distance(val,new_str,{distance,_}) when val > distance and val != 1.0, do: {val,new_str}
	def check_distance(_,_,acc), do: acc 

	def pull_eql([],str), do: str
	def pull_eql([{:eq, val}|rest],str), do: pull_eql(rest,str <> val)
	def pull_eql([key | rest], str), do: pull_eql(rest,str)

	def part1(args) do
		String.split(args,"\n",trim: true)
		|> get_checksum(%{3 => 0, 2 => 0, "two" => false, "three" => false})
	end
end
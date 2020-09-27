def get_solver_callstring(instance_filename, seed, param_hashmap)
	solver_callstring = "~/algorithms/spear/Spear-32_1.2.1 --seed #{seed} --model-stdout --dimacs #{instance_filename}"
        for param_name in param_hashmap.keys
	        param_value = param_hashmap[param_name]
        	solver_callstring += " --#{param_name} #{param_value}"
	end
	return solver_callstring
end

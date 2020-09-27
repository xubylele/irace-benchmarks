def get_solver_callstring(instance_filename, seed, param_hashmap)
        solver_callstring = "/home/iraceTester/algorithms/lingeling/lingeling-cssc14/lingeling -f --seed=#{seed} "
        for param_name in param_hashmap.keys
                param_value = param_hashmap[param_name]
                solver_callstring += " -#{param_name}=#{param_value}"
        end
        return solver_callstring + " #{instance_filename}"
end

#=========================================================================================
# The code below stays the same for every Ruby wrapper; simply replace the function above.  
#=========================================================================================

require 'csv'
in_file = ARGV[0]
in_csv = CSV.read(in_file)
instance_filename = in_csv[0][0]
seed = in_csv[1][0]
param_hashmap = {}
in_csv[2...in_csv.length].each { |x|
	param_hashmap[x[0]] = x[1]
}
call_string = get_solver_callstring(instance_filename, seed, param_hashmap)
puts call_string

def float_regexp()
        return '[+-]?\d+(?:\.\d+)?(?:[eE][+-]\d+)?';
end

tmp_file = "tmp_satcompformat_output#{rand}.txt"
cmd = $cmdArray.join(" ")
exec_cmd = "#{cmd} > #{tmp_file}"

solved = "CRASHED"
runtime = nil
walltime = nil

Signal.trap("TERM") {
    #=== Respond to termination by deleting temporary file and crashing.
    begin
        puts "Result for ParamILS: CRASHED, 0, 0, 0, #{$seed}"
        File.delete(tmp_file)
    ensure
        Process.exit 1
    end
}

begin
    STDOUT.puts "Calling: #{exec_cmd}"
    system exec_cmd

    #=== Parse algorithm output to extract relevant information for configurator.
    #=== The default result is CRASHED, and certain output changes this to SOLVED (SAT/UNSAT) or TIMEOUT.
    #=== If we match outputs for both SOLVED and TIMEOUT, TIMEOUT takes precedence to allow the developer to detect any problems.
    File.open(tmp_file){|file|
        while line = file.gets
            if solved == "CRASHED"
                if line =~ /s UNSATISFIABLE/
                    solved = "UNSAT"
                elsif line =~ /s SATISFIABLE/
                    solved = "SAT"
		end
# Cryptominisat will require another condition "c SATISFIABLE" due to a little bug
            end
            if line =~ /s UNKNOWN/ 
                solved = "TIMEOUT"
            end
	    if line =~ /INDETERMINATE/ # for Glucose memory limit
		solved = "TIMEOUT"
	    end
            if line =~ /runsolver_max_cpu_time_exceeded/
                solved = "TIMEOUT"
            end
            if line =~ /runsolver_max_memory_limit_exceeded/
                solved = "TIMEOUT"
            end
#            if line =~ /runtime (\d+\.\d+)/
#                runtime = $1.to_f
#            end
            if line =~ /runsolver_walltime: (#{float_regexp})$/
                walltime = $1.to_f
            end
            if line =~ /runsolver_cputime: (#{float_regexp})$/
    		runtime = $1.to_f
            end
        end
    }
ensure
    if solved == "TIMEOUT" and runtime==nil # This should NOT be needed since the runsolver output should always contain runsolver_cputime, but there were TIMEOUT cases where it did not!
	runtime = $runtimeLimit
    end
    puts "Result for ParamILS: #{solved}, #{runtime}, 0, 0, #{$seed}"

    begin
        File.delete(tmp_file)
    rescue Errno::ENOENT # ignore ENOENT errors. (errno 2)
    end

    if solved == "CRASHED"
        Process.exit 1
    end
end

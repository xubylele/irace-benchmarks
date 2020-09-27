#!/bin/bash
###############################################################################
# This hook is to tune the ACOTSP software.
#
# PARAMETERS:
# $1 is the instance name  
# $2 is the candidate number
# The rest ($* after `shift 2') are parameters to the run of ACOTSP
#
# RETURN VALUE:
# This hook should print a single numerical value (the value to be minimized)
###############################################################################

# Path to the ACOTSP software:
EXE=~/algorithms/acotsp/algorithm/ACOTSP-1.02/acotsp

# What "fixed" parameters should be always passed to ACOTSP?
# The time to be used is always 5 seconds, and we want only one run:
FIXED_PARAMS=" --tries 1 --quiet "

# The instance name and the candidate id are the first parameters
CANDIDATE=$1
INSTANCE_ID=$2
SEED=$3
INSTANCE=$4
RUNTIME=$5

# All other parameters are the candidate parameters to be passed to ACOTSP
shift 5 || exit 1
CAND_PARAMS=$*

RR=$RANDOM

MYDIR=`mktemp -d`

STDOUT="${MYDIR}/c${CANDIDATE}-${INSTANCE_ID}-${SEED}-${RR}.stdout"
STDERR="${MYDIR}/c${CANDIDATE}-${INSTANCE_ID}-${SEED}-${RR}.stderr"

# Now we can call ACOTSP by building a command line with all parameters for it
$EXE ${FIXED_PARAMS} --time $RUNTIME --seed $SEED -i $INSTANCE ${CAND_PARAMS} 1> $STDOUT 2> $STDERR

# In case of error, we print the current time:
error() {
    echo "`TZ=UTC date`: error: $@" >&2
    exit 1
}

# The output of the candidate $CANDIDATE should be written in the file 
# c${CANDIDATE}.stdout (see hook run for ACOTSP). Does this file exist?
if [ ! -s "${STDOUT}" ]; then
    # In this case, the file does not exist. Let's exit with a value 
    # different from 0. In this case irace will stop with an error.
    error "${STDOUT}: No such file or directory"
fi

# Ok, the file exist. It contains the whole output written by ACOTSP.
# This script should return a single numerical value, the best objective 
# value found by this run of ACOTSP. The following line is to extract
# this value from the file containing ACOTSP output.
COST=$(cat ${STDOUT} | grep -o -E 'Best [-+0-9.e]+' | cut -d ' ' -f2)
if ! [[ "$COST" =~ ^[-+0-9.e]+$ ]] ; then
    error "${STDOUT}: Output is not a number"
fi

# Print it!
echo "$COST"

# We are done with our duty. Clean files and exit with 0 (no error).
rm -rf "${STDOUT}" "${STDERR}"
rm -rf best.* stat.* cmp.* "${MYDIR}"
exit 0

#!/bin/bash

# Define the number of threads to use
num_threads=20

# Define the range of numbers to use
start_num=1
end_num=10000

# Define a function to make the curl request and filter for email addresses
function make_request() {
    local num=$1
    curl -s https://example/com/$num 2>/dev/null | grep -E -o "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b"
    echo "Request $num complete"
}

# Use xargs to parallelize the requests across multiple threads
export -f make_request
seq $start_num $end_num | xargs -P $num_threads -I {} bash -c 'make_request "$@"' _ {}
echo "Done!"

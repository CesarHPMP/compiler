#!/bin/zsh

# Define paths (with trailing slash)
DATA_DIR="DATA/"
EXECUTABLE="src/sint"
ACTUAL_OUTPUT_FILE="${DATA_DIR}output.txt"

# List of input and expected output files
INPUT_FILES=("entrada1.txt" "entrada2.txt" "entrada3.txt" "entrada4.txt" "entrada5.txt")
EXPECTED_OUTPUT_FILES=("saida1.txt" "saida2.txt" "saida3.txt" "saida4.txt" "saida5.txt")

# Debugging: Print the current directory and contents of DATA directory
echo "Current working directory: $(pwd)"
echo "DATA_DIR is set to: '$DATA_DIR'"
echo "Checking if DATA directory exists: $(ls -la "$DATA_DIR")"

# Check if DATA directory exists
if [ ! -d "$DATA_DIR" ]; then
    echo "Error: Directory '$DATA_DIR' not found."
    exit 1
else
    echo "DATA directory found: $DATA_DIR"
fi

# Check if the executable exists
if [ ! -x "$EXECUTABLE" ]; then
    echo "Error: Executable $EXECUTABLE not found or not executable."
    exit 1
fi

# Function to run the executable and compare output
run_and_compare() {
    local input_file=$1
    local expected_output_file=$2

    echo "Processing input file: ${DATA_DIR}${input_file}"
    echo "Expected output file: ${DATA_DIR}${expected_output_file}"

    # Run the executable and capture the output
    "$EXECUTABLE" < "${DATA_DIR}${input_file}" > "$ACTUAL_OUTPUT_FILE"

    # Compare the actual output with the expected output, ignoring whitespaces and blank lines
    echo "Comparing $input_file with $expected_output_file:"
    diff -Bw "$ACTUAL_OUTPUT_FILE" "${DATA_DIR}${expected_output_file}"
    echo
}

# Iterate over input and expected output files using a robust loop
for ((i=1; i<=${#INPUT_FILES[@]}; i++)); do
    INPUT_FILE="${INPUT_FILES[$((i))]}"
    EXPECTED_OUTPUT_FILE="${EXPECTED_OUTPUT_FILES[$((i))]}"

    # Check if input and expected output files exist
    if [ ! -f "${DATA_DIR}${INPUT_FILE}" ]; then
        echo "Error: Input file ${DATA_DIR}${INPUT_FILE} not found."
        continue
    fi

    if [ ! -f "${DATA_DIR}${EXPECTED_OUTPUT_FILE}" ]; then
        echo "Error: Expected output file ${DATA_DIR}${EXPECTED_OUTPUT_FILE} not found."
        continue
    fi

    run_and_compare "$INPUT_FILE" "$EXPECTED_OUTPUT_FILE"
done

# Optionally, clean up actual output file
rm -f "$ACTUAL_OUTPUT_FILE"

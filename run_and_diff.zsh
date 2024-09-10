#!/bin/zsh

# Define paths
DATA_DIR="DATA"
EXECUTABLE="src/sint"
ACTUAL_OUTPUT_FILE="$DATA_DIR/output.txt"

# List of input and expected output files
INPUT_FILES=("entrada1.txt" "entrada2.txt" "entrada3.txt" "entrada4.txt" "entrada5.txt")
EXPECTED_OUTPUT_FILES=("saida1.txt" "saida2.txt" "saida3.txt" "saida4.txt" "saida5.txt")

# Function to run the executable and compare output
run_and_compare() {
    local input_file=$1
    local expected_output_file=$2

    # Run the executable and capture the output
    "$EXECUTABLE" < "$DATA_DIR/$input_file" > "$ACTUAL_OUTPUT_FILE"

    # Compare the actual output with the expected output
    echo "Comparing $input_file with $expected_output_file:"
    diff "$ACTUAL_OUTPUT_FILE" "$DATA_DIR/$expected_output_file"
    echo
}

# Check if the executable exists
if [ ! -x "$EXECUTABLE" ]; then
    echo "Error: Executable $EXECUTABLE not found or not executable."
    exit 1
fi

# Iterate over all input files and their corresponding expected output files
for i in {1..5}; do
    INPUT_FILE="${INPUT_FILES[$((i-1))]}"
    EXPECTED_OUTPUT_FILE="${EXPECTED_OUTPUT_FILES[$((i-1))]}"

    # Check if input file exists
    if [ ! -f "$DATA_DIR/$INPUT_FILE" ]; then
        echo "Error: Input file $DATA_DIR/$INPUT_FILE not found."
        continue
    fi

    # Check if expected output file exists
    if [ ! -f "$DATA_DIR/$EXPECTED_OUTPUT_FILE" ]; then
        echo "Error: Expected output file $DATA_DIR/$EXPECTED_OUTPUT_FILE not found."
        continue
    fi

    run_and_compare "$INPUT_FILE" "$EXPECTED_OUTPUT_FILE"
done

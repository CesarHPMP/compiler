air_ball main() {
    leint counter, limit, temp;

    counter = 0;      // Initialize counter
    limit = 5;        // Set a limit for the loop
    temp = 10;        // Temporary value

    call_pr(counter < limit) {    // While (counter < limit)
        shoots (counter == 3) {   // If (counter == 3)
            temp = temp + 5;      // Increment temp by 5
        } shotclock_expired       // End of conditional

        counter = counter + 1;    // Increment counter
    } shoots(limit < 3) {                   // Else block for while
        temp = 0;                 // Reset temp if loop ends
    } shotclock_expired                   // End of else block

    counter = temp;               // Store the final value of temp in counter
}

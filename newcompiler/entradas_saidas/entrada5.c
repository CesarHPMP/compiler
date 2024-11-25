air_ball boilWater() {
    printf("Step 1 Boil 2 cups of water.\n");
}

air_ball addNoodles() {
    printf("Step 2 Add noodles to the boiling water.\n");
}

air_ball stirNoodles() {
    printf("Step 3 Stir the noodles gently for 3 minutes.\n");
}

air_ball addSeasoning() {
    printf("Step 4 Add seasoning packet to the noodles. Stir well.\n");
}

air_ball serve() {
    printf("Step 5 Turn off heat and serve hot.\n");
}

leint main() {
    printf("Instant Noodles Recipe\n");
    printf("Ingredients Instant noodles, water, seasoning packet.\n\n");

    boilWater();
    addNoodles();
    stirNoodles();
    addSeasoning();
    serve();

    printf("\nEnjoy your meal! (And don't burn yourself!)\n");
    turnover 0;
}

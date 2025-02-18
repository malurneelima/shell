#!/bin/bash
FRUITS=("APPLE" "KIWI" "ORANGE") # Here the size of array is 3 and the index starts with 0.

echo "First fruit is ${FRUITS[0]}"
echo "Second fruit is ${FRUITS[1]}"
echo "Third fruit is ${FRUITS[2]}"
echo "All  fruits are ${FRUITS[@]}" # @ will give all fruits
#!/bin/bash

# Function to print text in green color
print_green() {
    local text="$1"
    echo -e "\033[1;32m$text\033[0m"
}

# Function to print text in a red box
print_red_box() {
    local text="$1"
    # Calculate the number of spaces needed to center the text in the box
    local padding=$(( (48 - ${#text}) / 2 ))
    # Construct a string of spaces with the calculated length
    local spaces=$(printf "%*s" $padding)
    echo -e "\033[1;31m"
    echo "#############################################"
    echo "#                                           #"
    echo "#$spaces$text$spaces#"
    echo "#                                           #"
    echo "#############################################"
    echo -e "\033[0m"
}

# Display the title "Darknet Search" in a red box and center the text
print_red_box "Darknet Search V1.0 by Alex.N"

# Ask the user to enter the search keyword
read -p "Enter search keyword: " search_query

# Counter for the number of results
count=0

# List of search engines
search_engines=("https://ahmia.fi/search/?q=" "http://msydqstlz2kzerdg.onion/search/?q=")

# Iterate through each search engine and search for .onion domains
for engine in "${search_engines[@]}"; do
    # Download the search page for each engine
    search_url="$engine$search_query"
    wget -qO- "$search_url" | grep -oP 'http[s]?://[^[:space:]]*\.onion' | while read -r onion_domain; do
        ((count++))
        if [ $count -gt 15 ]; then
            count=0
        fi
        # Print the .onion domain in green color
        print_green "$onion_domain"
    done
done

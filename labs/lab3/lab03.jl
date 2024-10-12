using Base64  

# XOR Encryption Function
function xor_encrypt(plaintext::String, key::String)
    # Check that the key length is at least as long as the plaintext
    if length(key) < length(plaintext)
        error("The key must be longer than the plaintext.")
    end
    
    # Perform XOR operation for each character in the plaintext with the corresponding character in the key
    encrypted = [Char(xor(codeunit(plaintext, i), codeunit(key, i))) for i in 1:length(plaintext)]
    return join(encrypted)
end

# XOR Decryption Function (same as the encryption function)
function xor_decrypt(encrypted_text::String, key::String)
    return xor_encrypt(encrypted_text, key)  # Decryption is the same as encryption
end

# Linear Congruential Generator (LCG) function
function lcg(a, b, m, seed, length)
    random_sequence = Int[]
    yi = seed
    for i in 1:length
        yi = (a * yi + b) % m
        push!(random_sequence, yi)
    end
    return random_sequence
end

# Main program loop
while true
    # Display options for the user
    println("=== Select an Option ===")
    println("1. Encryption")
    println("2. Decryption")
    println("3. Key Generation using LCG")
    println("4. Exit")
    println("Please enter your choice (1, 2, 3, or 4): ")
    
    choice = parse(Int, readline())  # Get the user's choice

    if choice == 1
        # Encryption Process
        println("\n=== Encryption ===")
        println("Enter the plaintext (original text): ")
        plaintext = readline()  # Get the plaintext from user input

        println("Enter the key (must be at least as long as the plaintext): ")
        key = readline()  # Get the key from user input

        try
            encrypted_text = xor_encrypt(plaintext, key)  # Encrypt the text
            encoded_text = base64encode(encrypted_text)  # Encode the encrypted text in base64
            println("Encrypted text (base64 encoded): ", encoded_text)

        catch e
            println("An error occurred during encryption: ", e)
        end

    elseif choice == 2
        # Decryption Process
        println("\n=== Decryption ===")
        println("Enter the encrypted text (base64 encoded): ")
        encoded_input = readline()  # Get the base64 encoded encrypted text from user input

        # Decode the base64 input back to the original encrypted text
        encrypted_input = String(base64decode(encoded_input))

        println("Enter the key (must be the same as the key used for encryption): ")
        key_input = readline()  # Get the key from user input

        try
            decrypted_text = xor_decrypt(encrypted_input, key_input)  # Decrypt the text
            println("Decrypted text: ", decrypted_text)

        catch e
            println("An error occurred during decryption: ", e)
        end

    elseif choice == 3
        # Key Generation Process
        println("\n=== Key Generation using LCG ===")
        println("Enter the first LCG parameter (a): ")
        a = parse(Int, readline())  # Get the first LCG parameter from user input

        println("Enter the second LCG parameter (b): ")
        b = parse(Int, readline())  # Get the second LCG parameter from user input

        println("Enter the third LCG parameter (m): ")
        m = parse(Int, readline())  # Get the third LCG parameter from user input

        println("Enter the seed value: ")
        seed = parse(Int, readline())  # Get the seed value from user input

        println("Enter the length of the sequence: ")
        sequence_length = parse(Int, readline())  # Get the length of the sequence from user input

        # Generate keys
        key_sequence = lcg(a, b, m, seed, sequence_length)  # Generate keys
        println("Generated key sequence: ", key_sequence)

    elseif choice == 4
        println("Exiting the program.")
        break  # Exit the loop and terminate the program
    else
        println("Invalid choice. Please enter 1, 2, 3, or 4.")
    end

    println()  # Add an empty line for better readability
end

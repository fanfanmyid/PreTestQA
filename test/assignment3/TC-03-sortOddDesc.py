def sort_even_odd_desc(arr):
    # Pisahkan Ganjil dan Genap dengan Modulus Function
    even_numbers = [num for num in arr if num % 2 == 0]
    odd_numbers = [num for num in arr if num % 2 != 0]

    # Sort dengan urutan descendubg
    even_numbers.sort(reverse=True)
    odd_numbers.sort(reverse=True)

    # gabung list
    sorted_arr = even_numbers + odd_numbers
    return sorted_arr

# checking
input_array = [3, 2, 5, 1, 8, 9, 6]
output_array = sort_even_odd_desc(input_array)
print(output_array)
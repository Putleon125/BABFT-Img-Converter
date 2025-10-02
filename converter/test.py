string = str(input('Input string: '))

def str_to_hex(string):
    bytes_data = string.encode('utf-8')
    hex_data = bytes_data.hex()
    return hex_data

hex_string = str_to_hex(string)

print(f'Original text = {string}')
print(f'Hex encoded: {hex_string}')
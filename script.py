file = open("program.hex")
content = file.read()
file.close()
lines = content.split("\n")[:-4]
new_lines = []
for line in lines:
  if "@" not in line:
    new_lines.append(line)
bytes_8 = []
for line in new_lines:
  hex_list = line.split()
  if len(hex_list) < 16:
    if len(hex_list) < 8:
      baqiKiLength = 8 - len(hex_list) 
      theStr = "00" * baqiKiLength
      newline =theStr + "".join(hex_list[::-1])
      print(baqiKiLength)
      bytes_8.append(newline)
    else:
      line1 = "".join(hex_list[:8])[::-1]
      bytes_8.append(line1)
      line2 = hex_list[8:]
      baqiKiLength = 8 - len(line2)
      newline = f"{'0'*baqiKiLength}".join(line2[::-1])
      bytes_8.append(newline)
  else:
    line1 = "".join(hex_list[:8][::-1])
    line2 = "".join(hex_list[8:][::-1])
    bytes_8.append(line1)
    bytes_8.append(line2)
file = open("program.coe","w+")
file.write("memory_initialization_radix=16;\nmemory_initialization_vector=\n"+",\n".join(bytes_8) + ";")
file.close()
# with open('program.coe', mode='wt', encoding='utf-8') as myfile:
#   for lines in bytes_8_1:
#     myfile.write('\n'.join(str(line)))
# file = open("program.hex")
# file.write(bytes_8)
# file.close()



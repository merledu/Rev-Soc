file = open("program.hex")
content = file.read()
file.close()

content1 = content.split("\n")[:-3]
content2=[]
for i in content1:
  if "@" not in i:
    content2.append(i)


content3 = []
for i in content2:
  line = i.split()
  
  if len(line) < 16:
    count = 16 - len(line)
    for j in range(count):
      line.append("00")
  byte1 = line[:8][::-1]
  byte2 = line[8:][::-1]
  content3.append("".join(byte1))
  content3.append("".join(byte2))

content3 = content3[:-1]
content3.append("0000000000000FFF")
content3.append("0000000000000FFF")
file = open("firmware.hex", "w+")
file.write("\n".join(content3))
file.close()
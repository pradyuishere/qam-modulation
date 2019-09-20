import matplotlib.pyplot as plt

valuesRead = []
countone = 0
with open("dataRead.txt", "r") as filestreamone:
	for line in filestreamone:
		currentline = line.split(",")
		for item in currentline:
			if countone < 100000:
				valuesRead.append(int(item))
				countone = countone+1
			
valuesWritten = []
counttwo = 0
with open("dataWritten.txt", "r") as filestreamtwo:
	for line in filestreamtwo:
		currentline = line.split(",")
		for item in currentline:
			if counttwo < 100000:
				valuesWritten.append(int(item))
				counttwo = counttwo + 1

plt.plot(valuesRead)
plt.plot(valuesWritten)
plt.show()




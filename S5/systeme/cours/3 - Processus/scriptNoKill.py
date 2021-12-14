import os 
import sys
import signal 
import time

def finProg (signal, frame): 
	file = open("./tmp.txt", "w")
	file.write(text)
	print("Fin")
	sys.exit(0)

signal.signal(signal.SIGINT, finProg)
text = input("Entrez un mot : ")


while True:
	time.sleep(0.3)
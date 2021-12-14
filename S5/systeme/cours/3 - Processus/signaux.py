import os,sys,signal,time
#mot="vide"
def sauve(mot):
	F = open("tmp.save","w") 
	F.write(mot)
	F.close() 

def fin_signal_INTERRUPTION(sig,ignore): 
	print ("\nquelqu'un vient de m'interrompre\n")
	sauve(mot) 
	sys.exit()

def fin_signal_ALRM(sig,ignore):
	print("\nca fait 5s : fin du processus par SIGALRM\n") 
	sauve(mot) 
	sys.exit(0) 


print("le processus demarre")
signal.signal(signal.SIGINT, fin_signal_INTERRUPTION) 
signal.signal(signal.SIGALRM,fin_signal_ALRM) 
signal.alarm(5) 
print("pret a recevoir un mot :") 
mot=input('!!') 
while True:
	# ne rien faire a l'infini (ou jusqu'a un signal)
	i = 0

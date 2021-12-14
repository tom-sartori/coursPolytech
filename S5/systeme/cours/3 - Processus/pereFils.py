#!/usr/bin/python3
import os,sys


# Partie 1

# for i in range(3): 
# 	pid = os.fork()
# 	if pid == 0:
# 		print ("je suis le fils %d" %i) 
# 		sys.exit(i)
# 	else:
# 		print ("Je viens de creer le fils %d" %(pid))
	
# # Le pere	
# #rep = raw_input("blah...") 
# for i in range(3):
# 	pid,status = os.wait()
# 	print ("Mort de mon fils %d" %(pid))


# Partie 2 (pere, 3 fils, 2 fils au fils 1)


nbFils = 3
nbSousFils = 2

print ('Père        | ppid : %d | pid : %d' %(os.getppid(), os.getpid()))
for i in range(nbFils): 
	pid = os.fork()
	if pid == 0:
		print ("Fils %d      | ppid : %d | pid : %d" %(i, os.getppid(), os.getpid()))
		if i == 0: 
			for j in range(nbSousFils):
				pidFils = os.fork()
				if pidFils == 0: 
					print ("Sous fils %d | ppid : %d | pid : %d" %(j, os.getppid(), os.getpid()))
					sys.exit(j)
				else: 
					print ('Fils %d      | ppid : %d | pid : %d || Création sous fils %d de pid %d' %(i, os.getppid(), os.getpid(), j, pidFils))
			for k in range(nbSousFils): 
				pidFils,status = os.wait()
				print ('Fils %d      | ppid : %d | pid : %d || Mort du sous fils %d de pid %d' %(i, os.getppid(), os.getpid(), k, pidFils))

		sys.exit(i)
	else:
		print ('Père        | ppid : %d | pid : %d || Création fils %d de pid %d' %(os.getppid(), os.getpid(), i, pid))
	
# Le pere	
# rep = input("blah...") 
for i in range(nbFils):
	pid,status = os.wait()
	print ('Père        | ppid : %d | pid : %d || Mort du fils %d de pid %d' %(os.getppid(), os.getpid(), i, pid))





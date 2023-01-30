# coding: utf8
# -*- coding: utf-8 -*-
import sys
import os

# Donné
def lecture_adn():
  print("Entrez le nom du suspect :")
  nom_suspect = input()
  nom_fichier_adn = nom_suspect+".adn"
  fd = open(nom_fichier_adn, "r") or sys.exit("Ne trouve pas le fichier "+nom_fichier_adn)
  adn = fd.readline()
  fd.close()
  return adn

# Donné
def lit_automate_du_fichier():
  nb_etats = -1 ; alphabet = [] ; initial = '' ; final = [] ; transitions = {}
  fichier = open("FREZIER_SARTORI-automate.txt", "r") or sys.exit("Ne trouve pas le fichier   FREZIER_SARTORI-automate.txt")
  data = fichier.readlines()
  fichier.close()
  for word in data:
    word = word.rstrip()
    #print word
    if '->' in word:
      process = word.split('->')
      if(process[0] == 'nb états'):
        nb_etats = int( process[1] )
      elif(process[0] == 'alphabet'):
        alphabet = process[1].split(',')
      elif(process[0] == 'état final'):
        final = int( process[1] )
      elif(process[0] == 'état initial'):
        initial = int( process[1] )
      elif(process[0] == 'transition'):
        (dep,l,arr) = process[1].split(',')
        transitions[(int(dep),l)] =  int(arr)
      else:
        sys.exit(word," <-- ligne avec données non correctes !")
    else:
      sys.exit(word," <-- ligne avec données non correctes !")
  return nb_etats,alphabet,initial,final,transitions


# Lit l'automate depuis un fichier selon le format prévu
(nb_etats,Alphabet,initial,final,transitions) = lit_automate_du_fichier()
etat_courant = initial
print(str(nb_etats) + " etats")
print("Alphabet : ") ; print(Alphabet)
print("Etat initial = "+str(initial))
print("Etat final = "+str(final))
print("Transitions = "); print(transitions)







# Récupère l'adn à analyser
adn_suspect = lecture_adn()
# adn_suspect = "aactacatcgcgtaccg"

# TODO étudiants
#Vérifier que l'automate est complet

isComplet = True
i = 0
while isComplet and i < nb_etats:
    j = 0
    while isComplet and j < len(Alphabet):
        try:
            transitions[i, Alphabet[j]]
        except:
            isComplet = False
        j += 1
    i += 1

print("L'automate est complet : ", isComplet)



# Examine l'adn du suspect par l'automate correspondant au bout d'adn suspect
position = 0
chemin = str(initial)
# chemin doit être de la forme : 0,a,1,g,2,t,0,a,1,t,3....

# pour récupérer la lettre du texte à la position en cours d'exmamen : adn_suspect[position]
# coupable = ...

##TODO Algo de reconnaissance


coupable = False
etat = 0
i = 0
while not coupable and i < len(adn_suspect):
    etat = transitions[etat, adn_suspect[i]]
    chemin += ',' + adn_suspect[i] + ',' + str(etat)
    if etat == 5:
        coupable = True
    i += 1


if coupable:
  print("Coupable !!!")
  print("Chemin prouvant la culpabilité :")
  print(chemin)
else:
  print("Non coupable.")
  print(chemin)

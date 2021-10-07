import re


def ligneValide(tab):
    if (re.match(r"^[A-Z]{3}$", tab[0]) is not None) and (re.match(r"^[A-Z]{4}$", tab[1]) is not None):
        for i in range(2, 5):
            if (re.match(r"^.*$", tab[i]) is None):
                return False
        return True
    return False


# 12.

def createDicoAirport(fileName):
    with open(fileName, 'r') as file:
        dico = {}

        for line in file:
            tab = line.split(',')
            if ligneValide(tab):
                dico[tab[0]] = tab[1:5]

    file.close()
    return dico


dico = createDicoAirport('listeaeroports.csv')


# print(dico)


# 13.

def getIndicatif(dico, nomAeroport):
    for cle, val in dico.items():
        for sousVal in val:
            if sousVal == nomAeroport:
                return cle


# print(getIndicatif(dico, 'Los Angeles'))


# 14.

def createFile(dico):
    dico = sorted(dico.items(), key=lambda item: item[1][1])
    file = open('result.csv', 'w')
    # with open('result.csv', 'w') as file:
    for cle, val in dico:
        file.writelines(cle + ',' + val[1] + ',\n')
    file.close()


createFile(dico)


# 15.

def ex15():
    dico = {}
    with open('result.csv', 'r') as file:
        for line in file:
            tab = line.split(',')
            dico[tab[0]] = tab[1]

    file.close()
    return dico

# print(ex15())

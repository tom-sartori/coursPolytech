# 1.

def ex1():
    return {"MPL": "Montpellier",
            "DUB": "Dublin",
            "CDG": "Paris Charles-de-Gaule",
            "ORY": "Paris Orly",
            "YYZ": "Toronto",
            "LHR": "London Heathrow",
            "LCY": "London City",
            "LAX": "Los Angeles",
            }


# 2.

def createDico(tab1, tab2):
    if len(tab1) != len(tab2):
        return False

    dico = {}

    for i in range(len(tab1)):
        dico[tab1[i]] = tab2[i]

    return dico


tab1 = ["MPL",
        "DUB",
        "CDG"]

tab2 = ["Montpellier",
        "Dublin",
        "Paris Charles-de-Gaule"]


# print(createDico(tab1, tab2)["MPL"])


# 3.

def getIndicatif(dico, nomAeroport):
    for cle, val in dico.items():
        if val == nomAeroport:
            return cle


# print(getIndicatif(ex1(), "Los Angeles"))


# 4.

def getDicoSortedByKey(dico):
    return sorted(dico.items())


# print(getDicoSortedByKey(ex1()))


# 5.

def getDicoSortedByValue(dico):
    return sorted(dico.items(), key=lambda item: item[1])


# print(getDicoSortedByValue(ex1()))

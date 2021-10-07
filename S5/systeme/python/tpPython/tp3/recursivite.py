grilleVide = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],

    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],

    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
]

grilleSimple = [
    [0, 6, 2, 8, 5, 0, 4, 0, 3],
    [5, 0, 4, 1, 0, 9, 6, 7, 0],
    [7, 8, 0, 0, 4, 3, 0, 2, 1],

    [4, 7, 0, 0, 1, 2, 0, 8, 6],
    [9, 0, 3, 5, 0, 6, 7, 4, 0],
    [0, 2, 8, 7, 9, 0, 1, 3, 5],

    [0, 5, 6, 4, 7, 8, 2, 0, 9],
    [2, 0, 1, 9, 3, 5, 8, 6, 0],
    [8, 9, 0, 2, 6, 1, 0, 5, 4],
]

grille = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [1, 0, 3, 0, 5, 0, 2, 0, 9],
    [0, 4, 0, 0, 0, 0, 0, 0, 0],

    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 5, 0, 0, 0, 0, 0, 0, 0],
    [0, 7, 0, 0, 0, 0, 0, 0, 0],

    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 9, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
]

grille1 = []
grille1.append([0, 5, 0, 4, 0, 0, 0, 0, 0])
grille1.append([9, 1, 0, 0, 0, 3, 8, 0, 0])
grille1.append([0, 0, 3, 0, 1, 0, 0, 0, 7])
grille1.append([0, 0, 0, 0, 4, 0, 0, 3, 0])
grille1.append([7, 0, 1, 6, 0, 8, 4, 0, 2])
grille1.append([0, 2, 0, 0, 3, 0, 0, 0, 0])
grille1.append([1, 0, 0, 0, 9, 0, 5, 0, 0])
grille1.append([0, 0, 5, 8, 0, 0, 0, 6, 9])
grille1.append([0, 0, 0, 0, 0, 4, 0, 2, 0])

ligne = [0, 1, 4,
         0, 0, 0,
         0, 0, 3]


def toPrint(grille):
    print("")
    print(grille[0])
    print(grille[1])
    print(grille[2])
    print("")
    print(grille[3])
    print(grille[4])
    print(grille[5])
    print("")
    print(grille[6])
    print(grille[7])
    print(grille[8])
    print("")


# 1.

def valDispo(ligne):
    result = [True,
              True, True, True,
              True, True, True,
              True, True, True]

    for elt in ligne:
        result[elt] = False

    return result


# print(valDispo(ligne))


# 2.

def valDispoPourLigne(grille, numLigne):
    return valDispo(grille[numLigne])


# print(valDispoPourLigne(grille, 1))


# 3.

def valDispoPourCol(grille, numCol):
    colonne = []

    for val in grille:
        colonne.append(val[numCol])

    return valDispo(colonne)


# print(valDispoPourCol(grille, 1))


# 4.

def valDispoPourRegion(grille, x, y):
    region = []

    for i in range(x, x + 3):
        for j in range(y, y + 3):
            region.append(grille[i][j])

    return valDispo(region)


# print(valDispoPourRegion(grille, 0, 0))


# 5.

def valDispoPourPosition(grille, x, y):
    dispoLigne = valDispoPourLigne(grille, x)
    dispoCol = valDispoPourCol(grille, y)
    dispoRegion = valDispoPourRegion(grille, x - (x % 3), y - (y % 3))

    result = [True,
              True, True, True,
              True, True, True,
              True, True, True]

    for i in range(10):
        if (dispoLigne[i] is False) or (dispoCol[i] is False) or (dispoRegion[i] is False):
            result[i] = False

    return result


# print(valDispoPourPosition(grille, 8, 0))


# 6.

def listePositionsNonRemplies(grille):
    result = []
    for i in range(len(grille)):
        for j in range(len(grille[i])):
            if grille[i][j] == 0:
                result.append([i, j])
    return result


# print(listePositionsNonRemplies(grilleSimple))


# 7.

def grilleFinie(grille, listePosNonRempli, start):
    # print(toPrint(grille))
    if start == len(listePosNonRempli):
        return grille, True
    elif start < 0:
        return False

    coordCourant = listePosNonRempli[start]
    xCourant = coordCourant[0]
    yCourant = coordCourant[1]

    tabBoolValPossible = valDispoPourPosition(grille, xCourant, yCourant)
    temp = False
    for i in range(1, len(tabBoolValPossible)):
        if tabBoolValPossible[i]:
            grille[xCourant][yCourant] = i
            result = grilleFinie(grille, listePosNonRempli, start + 1)
            if result[1]:
                temp = True
                break
            grille[xCourant][yCourant] = 0

    return grille, temp


def sudoku(grille):
    listePosNonR = listePositionsNonRemplies(grille)

    if len(listePosNonR) > 0:
        return grilleFinie(grille, listePosNonR, 0)
    else:
        return grille


result = sudoku(grille1)
print(toPrint(result[0]))
# toPrint(sudoku(grilleSimple))

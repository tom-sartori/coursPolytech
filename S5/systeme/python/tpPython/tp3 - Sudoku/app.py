import tkinter as tk


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


def SudokuReset():
    for i in range(9):
        for j in range(9):
            listvalue[i][j].set(0)
            listentry[i][j].configure(bg="white", font=("Calibri", 20))

    print("-- Grid Reset --")


def SetGrid1():  # Sudoku TP
    SudokuReset()
    sudoku = []
    sudoku.append([0, 5, 0, 4, 0, 0, 0, 0, 0])
    sudoku.append([9, 1, 0, 0, 0, 3, 8, 0, 0])
    sudoku.append([0, 0, 3, 0, 1, 0, 0, 0, 7])
    sudoku.append([0, 0, 0, 0, 4, 0, 0, 3, 0])
    sudoku.append([7, 0, 1, 6, 0, 8, 4, 0, 2])
    sudoku.append([0, 2, 0, 0, 3, 0, 0, 0, 0])
    sudoku.append([1, 0, 0, 0, 9, 0, 5, 0, 0])
    sudoku.append([0, 0, 5, 8, 0, 0, 0, 6, 9])
    sudoku.append([0, 0, 0, 0, 0, 4, 0, 2, 0])

    setGrid(sudoku)
    print("-- Config 1 --")


def SetGrid2():  # Sudoku Enonce 2
    SudokuReset()
    sudoku = []
    sudoku.append([3, 0, 0, 4, 1, 0, 0, 8, 7])
    sudoku.append([0, 0, 9, 0, 0, 5, 0, 6, 0])
    sudoku.append([4, 0, 0, 7, 9, 0, 5, 0, 3])
    sudoku.append([0, 7, 3, 2, 4, 0, 0, 0, 0])
    sudoku.append([0, 0, 0, 0, 0, 0, 0, 0, 0])
    sudoku.append([0, 0, 0, 0, 7, 8, 2, 4, 0])
    sudoku.append([6, 0, 2, 0, 8, 3, 0, 0, 5])
    sudoku.append([0, 5, 0, 1, 0, 0, 3, 0, 0])
    sudoku.append([1, 3, 0, 0, 2, 4, 0, 9, 6])

    setGrid(sudoku)
    print("-- Config 2 --")


def SetGrid3():  # Sudoku Easy
    SudokuReset()
    sudoku = []
    sudoku.append([2, 9, 0, 0, 3, 1, 7, 8, 0])
    sudoku.append([0, 1, 6, 0, 0, 0, 0, 2, 4])
    sudoku.append([0, 7, 0, 4, 0, 0, 5, 9, 0])
    sudoku.append([4, 0, 0, 0, 0, 0, 8, 6, 5])
    sudoku.append([0, 0, 0, 8, 5, 9, 0, 0, 0])
    sudoku.append([7, 8, 5, 0, 0, 0, 0, 0, 2])
    sudoku.append([0, 5, 7, 0, 0, 3, 0, 4, 0])
    sudoku.append([8, 2, 0, 0, 0, 0, 1, 7, 0])
    sudoku.append([0, 4, 1, 7, 9, 0, 0, 5, 3])

    setGrid(sudoku)
    print("-- Config 3 --")


def SetGrid4():  # Sudoku Hard
    SudokuReset()
    sudoku = []
    sudoku.append([7, 2, 0, 4, 0, 6, 0, 0, 3])
    sudoku.append([0, 0, 4, 0, 0, 0, 7, 0, 0])
    sudoku.append([0, 5, 0, 0, 0, 0, 0, 2, 0])
    sudoku.append([0, 1, 5, 0, 0, 4, 0, 0, 8])
    sudoku.append([0, 0, 0, 2, 0, 7, 0, 0, 0])
    sudoku.append([9, 0, 0, 5, 0, 0, 2, 4, 0])
    sudoku.append([0, 6, 0, 0, 0, 0, 0, 1, 0])
    sudoku.append([0, 0, 3, 0, 0, 0, 8, 0, 0])
    sudoku.append([5, 0, 0, 1, 0, 8, 0, 9, 4])

    setGrid(sudoku)
    print("-- Config 4 --")


def setGrid(sudoku):
    SudokuReset()
    for i in range(9):
        for j in range(9):

            if sudoku[i][j] != 0:
                listvalue[i][j].set(sudoku[i][j])
                # Set background color to grey if the value come from the start grid
                listentry[i][j].configure(bg="#E0E0E0")
                # Set font to bold instead of changing background color
                # listentry[i][j].configure(font=("Calibri", 20,"bold"))


def setGrid2(sudoku):
    for i in range(9):
        for j in range(9):
            if (listvalue[i][j].get() == 0):
                listvalue[i][j].set(sudoku[i][j])





def StdoutPrint():
    global initialSudoku, resultSudoku
    print("-- Printing Sudoku Actual State --\n")
    initial = []
    grilleTest = []
    for i in range(9):
        line = "     "
        if i % 3 == 0 and i != 0:
            print("      - - - - - - - - - - -")
        grilleLigne = []
        initialLine = []
        for j in range(9):
            if j % 3 == 0 and j != 0:
                line += " |"
            line = line + " " + str(listvalue[i][j].get())
            grilleLigne.append(listvalue[i][j].get())
            initialLine.append(listvalue[i][j].get())
        grilleTest.append(grilleLigne)
        initial.append(initialLine)

    print("\nYou have to modify this button action, Please !\n")
    result = sudoku(grilleTest)[0]
    setGrid2(result)

    initialSudoku = initial
    resultSudoku = result



def save():
    file = open('resultSudoku.csv', 'w')

    for line in initialSudoku:
        file.writelines((str)(line))
        file.writelines('\n')

    file.writelines('\n')

    for line in resultSudoku:
        file.writelines((str)(line))
        file.writelines('\n')


def RunButton():
    print("Solving Sudoku")
    #### TO DO : Link your solver to this program ####
    ## When the run button is clicked,
    ## the grid has to be sent to the solving function
    ## and the solution has to be printed on terminal at first (optional)
    ## and then in the tk windows (main goal)


### Window creation
window = tk.Tk()

### Printing Title
title = tk.Label(window, text="My Sudoku Solver", font=("Calibri", 30), justify="center").grid(row=1, column=0,
                                                                                               columnspan=20)

### Empty grid of sudoku, 0 in all boxes
listvalue = [[tk.IntVar() for j in range(9)] for i in range(9)]
listentry = [[0 for j in range(9)] for i in range(9)]
### Assigning boxes to Interactive Grid
for ligne in range(9):
    for colonne in range(9):
        listentry[ligne][colonne] = tk.Entry(
            window,
            textvariable=listvalue[ligne][colonne],
            width=2,
            relief="raised",
            font=("Calibri", 20),
            justify="center",
        )
        listentry[ligne][colonne].grid(row=(ligne + 1) * 2, column=(colonne + 1) * 2)

### Exemple Config 

tk.Button(window, text="Grid 1", command=SetGrid1).grid(row=2, column=20, rowspan=2)
tk.Button(window, text="Grid 2", command=SetGrid2).grid(row=4, column=20, rowspan=2)
tk.Button(window, text="Grid 3", command=SetGrid3).grid(row=5, column=20, rowspan=2)
tk.Button(window, text="Grid 4", command=SetGrid4).grid(row=7, column=20, rowspan=2)

### Button Config
tk.Button(window, text="Run", command=StdoutPrint).grid(row=20, column=2, columnspan=3)
tk.Button(window, text="Save", command=save).grid(row=20, column=6, columnspan=3)
tk.Button(window, text="Reset", command=SudokuReset).grid(row=20, column=16, columnspan=3)
tk.Button(window, text="Close", command=window.quit).grid(row=20, column=20, columnspan=3)

### Border Layout
tk.Label(window, text="", fg="blue4", bg="#404040").grid(row=2, column=7, rowspan=17, sticky="ns")
tk.Label(window, text="", fg="blue4", bg="#404040").grid(row=2, column=13, rowspan=17, sticky="ns")

tk.Label(window, text="", fg="blue4", bg="#404040", font=("Calibri", 1)).grid(row=7, column=2, columnspan=17,
                                                                              sticky="ew")
tk.Label(window, text="", fg="blue4", bg="#404040", font=("Calibri", 1)).grid(row=13, column=2, columnspan=17,
                                                                              sticky="ew")

window.grid_rowconfigure(0, minsize=10)
window.grid_rowconfigure(19, minsize=10)
window.grid_rowconfigure(21, minsize=10)
window.grid_columnconfigure(0, minsize=10)
window.grid_columnconfigure(19, minsize=10)
window.grid_columnconfigure(21, minsize=10)

### Loop
window.mainloop()

print("Window Closed, End of Program\nBye !")

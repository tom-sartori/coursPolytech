# 1.
def produitEntiersPairs(n):
    i: int
    result: int = 1

    if (n % 2) != 0:
        n -= 1

    i = n
    while i > 0:
        result = result * i
        i -= 2

    return result


# 2.
def sansDiviseur(n, k):
    for i in range(k, n):
        if (n % i) == 0:
            return False
    return True


def estPremier(n):
    if n <= 1:
        return False
    return sansDiviseur(n, 2)


# 3.
def somePrem(k):
    result: int = 0
    for i in range(k + 1):
        if estPremier(i):
            result += i
    return result


# 4.
def nbOcur(tab, x):
    result: int = 0

    for i in range(len(tab)):
        if tab[i] == x:
            result += 1
    return result


def estPresent(tab, x):
    for i in range(len(tab)):
        if tab[i] == x:
            return True
    return False


def indice(tab, x):
    for i in range(len(tab)):
        if tab[i] == x:
            return i
    return -1


# tab = [3, 4, 2, 4, 3]
# print(indice(tab, 6))


# 5.
def compare(tab1, tab2):
    equal = True

    for i in range(len(tab1)):
        if tab1[i] > tab2[i]:
            return 1
        if tab1[i] != tab2[i]:
            equal = False

    if equal:
        return 0
    return -1


# tab1 = ('a', 'd', 'a')
# tab2 = ('a', 'b', 'c')
#
# print(compare(tab1, tab2))


# 6.
# P sous tab de G ?
def estSousTab(tabP, tabG):
    i: int = 0
    j: int = 0

    while i < len(tabP) and j < len(tabG):
        if tabP[i] == tabG[j]:
            i += 1
            j = 0
        else:
            j += 1
            if j == len(tabG):
                return False
    return True


# tabP = ('a', 'e', 'a')
# tabG = ('a', 'c', 'd', 'e')
# print(estSousTab(tabP, tabG))


# 7.
def isPrime(x):
    if x <= 1:
        return False
    for i in range(2, x):
        if x % i == 0:
            return False
    return True


def n_iemePremier(n):
    if n < 1:
        return False

    nbPrimeNumber: int = 0
    i: int = 0
    result: int

    while nbPrimeNumber < n:
        if isPrime(i):
            nbPrimeNumber += 1
            result = i
        i += 1
    return result


# print(n_iemePremier(25))

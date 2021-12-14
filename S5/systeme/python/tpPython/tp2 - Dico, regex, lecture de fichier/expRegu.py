# 6.
import re


def isEmail1(txt):
    return re.match(r"^.*@.*$", txt) is not None


# print(isEmail1("test@gmail.com"))


# 7.

def isEmail2(txt):
    return re.match(r"^(\w|\.|-|_)*@.*$", txt) is not None


# 8.

def isEmail(txt):
    return re.match(r"^(\w|\.|\-|\_)*@(\w|\.|\-|\_)*\.(fr|com|org)$", txt) is not None


def testEmail():
    print(isEmail("test@gmail.com"))
    print(isEmail("te2.-_st@gmail.com"))
    print(isEmail("te,st@gmail.com") == False)
    print(isEmail("te,st@gmailcom") == False)
    print(isEmail("te,st@gmail.c") == False)
    print(isEmail("test@gmail.fr"))


# testEmail()


# 9.

def isNumber(nb):
    return re.match(r"^(0|\+\d{2,3}|\(\d{2,3}\))(\d{9}|\d(( |\.|-)\d{2}){4})$", nb) is not None


# 10.

def getNumber(nb):
    if isNumber(nb) is False:
        return None

    # tab = re.findall(r"^(0|\+\d{2,3}|\(\d{2,3}\))(\d{9}|\d(( |\.|-)\d{2}){4})$", nb)
    # tab = re.findall(r"^(0|\+(\d{2,3})|\((\d{2,3})\))((\d{9})|(\d(( |\.|-)\d{2}){4}))$", nb)
    tab = re.findall('\d', nb)
    result = [0, 1]

    if len(tab) == 10:
        result[0] = '33'
        result[1] = "".join(tab[1:])
    else:
        result[0] = "".join(tab[:2])
        result[1] = "".join(tab[2:])

    return result

    # print(tab)
    # tab = "".join(re.findall('\d', nb))

    # tab[0][0].replace('+', '')
    # tab[0][0].replace('(', '')
    # tab[0][0].replace(')', '')

    # print(tab)


def testIsNumber():
    print(isNumber("0603940393"))
    print(isNumber("+33670924829"))
    print(isNumber("(33)382759275"))
    print(isNumber("06 03 94 03 93"))
    print(isNumber("+336.70.92.48.29"))
    print(isNumber("(33)3-82-75-92-75"))

    print(isNumber("(33)3-82-75-92-7") is False)
    print(isNumber("(333-82-75-92-79") is False)


def testGetNumber():
    print(getNumber("0603940393"))
    print(getNumber("+33670924829"))
    print(getNumber("(49)382759275"))
    print(getNumber("06 03 94 03 93"))
    print(getNumber("+336.70.92.48.29"))
    print(getNumber("(33)3-82-75-92-75"))

    print(getNumber("(33)3-82-75-92-7") is False)
    print(getNumber("(333-82-75-92-79") is False)


testGetNumber()


# 11.

def isPalindrome(txt):
    taille = len(txt)

    if taille % 2 != 0:
        return False

    txt1 = txt[:int(taille / 2)]
    txt2 = txt[int(taille / 2):]
    txt2 = txt2[::-1]

    if re.match(r"^[a-zA-Z]{1,3}\d{1,2}$", txt1) is not None:
        for i in range(len(txt1)):
            if txt1[i] != txt2[i]:
                return False
        return True
    else:
        return False


# print(isPalindrome('rad2112dar'))

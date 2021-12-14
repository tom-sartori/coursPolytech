# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import numpy as np 


def ex1 (): 

    A = np.array((
        [4, 6, -2, 3], 
        [2, -1, 0, 1], 
        [-7, 0, 1, 12.]))
    
    # print(A)
    # print()
    
    # A[0] *= 2
    # A[1] *= 2
    # A[2] /= 3
    
    B = np.array((
        np.arange(4, 7), 
        np.arange(5, 16, 5), 
        np.ones(3)
        ))
    
    
    # print(B)
    
    C = A[:3, :3]
    C = np.vstack((2*A[0:2, :], 1/3*A[2,:]))
    # print(C)
    
    
    D = np.dot(B, A)
    # print(D)
   
   
    Y = np.sum(D, axis=1)
    
   
    
def ex2 (): 
    A = np.array((
        [4, 5, 6, -1], 
        [5, 10, 15, 2], 
        [6, 15, 1, 4], 
        [-1, 2, 4, -2]
        ), dtype=(np.int8()))

    
    vap, vecp = np.linalg.eig(A)
    print("Val propres : ", vap)
    print("Vecteurs propres : ", vecp)
    
    det = np.linalg.det(A)
    
    invap = np.diag(1./vap)
    # inva2 = np.dot(vacp, np.dot(invap, vecp.T))

    B = np.linalg.inv(A)
    print(B)



def ex3(): 
    A = np.array([
            [1, -1, 2, 1, 2], 
            [-1, 2, 3, -4, 1], 
            [0, -1, 1, 0, 0]]
        )
    print(A)
    rankA = np.linalg.matrix_rank(A)
    
    
    B = np.array([[0], [1], [-1]])
    print(np.linalg.solve(A[:3, :3], B))
    
    


# ex1()
# ex2()
ex3()
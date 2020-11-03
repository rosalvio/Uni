import numpy as np

def levenshtein(x, y):
    """
    Calcula la distancia de Levenshtein entre las cadenas x e y
    """
    d = matriz(x,y)
    d[0,0] = 0

    for i in range(1,len(x)):
        d[i,0] = d[i-1,0] + 1
    
    for j in range(1,len(y)):
        d[0,j] = d[0,j-1] + 1

    for i in range(1,len(x)):
        for j in range(1, len(y)):
            d[i,j] = min(
                d[i-1,j] + d[i,j],
                d[i,j-1] + d[i,j],
                d[i-1,j-1] + d[i,j]
            )
    return d
    #return d[len(x)-1,len(y)-1]

def distance(str1, str2):
  d=dict()
  for i in range(len(str1)+1):
     d[i]=dict()
     d[i][0]=i
  for i in range(len(str2)+1):
     d[0][i] = i
  for i in range(1, len(str1)+1):
     for j in range(1, len(str2)+1):
        d[i][j] = min(d[i][j-1]+1, d[i-1][j]+1, d[i-1][j-1]+(not str1[i-1] == str2[j-1]))
  return d[len(str1)][len(str2)]

def lev(str1, str2):
    """
    docstring
    """
    col = dict()
    i = 0
    mat = matriz(str1, str2)
    for j in range(0,len(str1)):
        # Cada primer elemento vale su numero de fila
        if j == 0:
            col[j] = i
        else:
            # col[j-1] es el de arriba de (i,j)
            # col[j] es el de la izquierda de (i,j)
            # mat(i,j) es la comparacion de los caracteres en esa posicion
            col[j] = min(col[j-1]+1, col[j]+1, mat(i,j))
        i = i + 1
    return col[j]

def levenshtein(str1, str2):
    """
    Calcula la distancia de Levenshtein entre las cadenas x e y
    """
    mat = matriz(str1, str2)
    res = np.zeros(shape=(len(str1)+1,len(str2)+1))
    for i in range(0,len(str1)+1):
        for j in range(0,len(str2)+1):
            if i==0 or j==0:
                res[i,j] = res[i,j] + i + j
            else:
                # El mejor camino viene siempre dado por la diagonal
                res[i,j] = mat[i-1,j-1] + res[i-1,j-1]
    return res[len(str1),len(str2)]

def matriz(term, ref):
    """
    Prueba
    """
    vref = np.array(list(ref))
    return np.vstack([vref != letter for letter in term]) + 0


if __name__ == "__main__":
    print(matriz('campos', 'ejemplo'))
    print(levi('campos', 'ejemplo'))
    print(distance('campos','ejemplo'))
import numpy as np
def matriz(term, ref):
    """
    Prueba
    """
    vref = np.array(list(ref))
    return np.vstack([vref != letter for letter in term]) + 0


def levenshtein(term, ref):
    """
    Calcula la distancia de Levenshtein entre las cadenas term y ref
    """
    mat = matriz(term, ref)
    res = np.zeros(shape=(len(term)+1,len(ref)+1))
    for i in range(0,len(term)+1):
        for j in range(0,len(ref)+1):
            if i==0 or j==0:
                res[i,j] = res[i,j] + i + j
            else:
                
                res[i,j] =min(
                    mat[i-1,j-1] + res[i-1,j-1],
                    1 + res[i-1,j],
                    1 + res[i,j-1]
                )
                
    return res[len(term),len(ref)]

def levenshtein2(term, ref, threshold):
    """
    Calcula la distancia de Levenshtein entre las cadenas term y ref
    """
    mat = matriz(term, ref)
    res = np.zeros(shape=(len(term)+1,len(ref)+1))
    for i in range(0,len(term)+1):
        for j in range(0,len(ref)+1):
            if i==0 or j==0:
                res[i,j] = res[i,j] + i + j
            else:
                
                res[i,j] =min(
                    mat[i-1,j-1] + res[i-1,j-1],
                    1 + res[i-1,j],
                    1 + res[i,j-1]
                )
                if (res.diagonal() > threshold).any():
                    return None
                
    return res[len(term),len(ref)]


def levenshtein_active_states(ref,term,threshold):
    mat = matriz(term,ref)
    current = np.zeros((len(term)+1))
    prev = np.arange(0,len(term)+1)
    # prev representa la columna anterior
    for i in range(1,len(ref)+1):
        current[0] = prev[0] + 1
        for j in range(1,len(term) + 1):
            cond = ref[i-1] == term[j-1]
            current[j] = min(
                    cond * 1 + prev[j-1],
                    1 + prev[j],
                    1 + current[j-1]
                )
            if i == j and current[j]>threshold:
                return None
        prev = current
    return current[len(term)]


def damerau(ref,term,threshold):
    current = np.zeros((len(term)+1))
    prev = np.zeros((len(term)+1,2))
    prev[:,0] = np.arange(0,len(term)+1)
    # prev representa la columna anterior
    for i in range(1,len(ref)+1):
        current[0] = prev[0,1] + 1
        for j in range(1,len(term) + 1):
            cond = ref[i-1] == term[j-1]
            current[j] = min(
                    cond * 1 + prev[j-1],
                    1 + prev[j],
                    1 + current[j-1]
                )
            if i == j and current[j]>threshold:
                return None
        prev = current
    return current[len(term)]

def dp_restricted_damerau_backwards(x, y):
    """
    Calcula la distancia de Damerau Levenshtein Restringida entre las cadenas x y y
    """
    # Simula el infinito
    INF = len(x) + len(y)

    mat = matriz(x, y)
    res = np.zeros(shape=(len(x)+1,len(y)+1))

    for i in range(0,len(x)+1):
        for j in range(0,len(y)+1):
            if i==0 or j==0:
                res[i,j] = res[i,j] + i + j
            elif i == 1 or j == 1:
                res[i,j] =min(
                    mat[i-1,j-1] + res[i-1,j-1],
                    1 + res[i-1,j],
                    1 + res[i,j-1],
                )
            else:
                res[i,j] =min(
                    mat[i-1,j-1] + res[i-1,j-1],
                    1 + res[i-1,j],
                    1 + res[i,j-1],
                  1 + res[i-2,j-2] + (mat[i-2,j-1] + mat[i-1,j-2]) * INF
                )
    return res[len(x),len(y)]



if __name__ == "__main__":
    print(levenshtein('campos','ejemplo'))
    print(levenshtein2('algoritmo','algortimo',1))
    print(levenshtein_active_states('campos','ejemplo',4))
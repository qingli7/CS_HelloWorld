import sys

'''
programe of page three
n<=50, k_n<=10^8, m<=10^8
Back extract k_n four times and added them up to m
'''

MAX_N = 50
f = False
k = []


def extract():
    n = input("please input the number of pieces of paper n:")
    n = int(n)
    for i in range(n):
        print("please input paper character k[",i,"]:")
        j = input()
        j = int(j)
        k.insert(i,j)
    m = input("please inter the summation m :")
    m = int(m)
    add(n, k, m)

def add(n, k, m):
    for a in range(n):
        for b in range(n):
            for c in range(n):
                for d in range(n):
                    if k[a]+k[b]+k[c]+k[d] == m :
                        f = True
                        print(k[a],k[b],k[c],k[d])
    print(f)


if __name__ == "__main__":
    extract()
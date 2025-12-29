# function hitung input x number, output penjumlahan 
# 1 return 1
# 2 rerturn  1 + 2

# output = 0
# x = 6
# y = 0 
0, 1, 2, 3

#iter 1
# 0
# iter 2
# 0 + 1 = 1
# iter 3
# 1 + 2 = 3
# inter 4
# 3 + 3 = 6

def hasil_kal(x):
    y = 0
    for number in range(x+1):
        y = y + number

    print(y)


hasil_kal(2)

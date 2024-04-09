import time
import datetime
import string

def password(length):
    result = ''
    for i in range(length+1):
        moment = int(datetime.datetime.now().time().microsecond & 0b01111110)
        if moment<33: 
            moment = moment + 33 & 0b01111110
        result += chr(moment)
        time.sleep(1)
    print(result)

print("How long do you want your password to be?")
length_pas = int(input("Length of password: "))
for i in range(5): # работает медленно, цикл выставлен, чтобы результат был виден лучше
    password(length_pas)

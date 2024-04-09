import time
import datetime
import string

def password(length):
    result = ''
    for i in range(length+1): 
        moment = int(datetime.datetime.now().time().microsecond & 0b01111110) #берем значение микросекунды, побитовое домножение, чтобы было ограничено до 126 (количество символов ASCII без 127, который пробел)
        if moment<33: 
            moment = moment + 33 & 0b01111110 #Python считает символы ASCII до 32-го пробелами, прибавляем 33 и снова делаем побитовое домножение (для случая, если moment превысил 126)
        result += chr(moment) #числовое значение переходит в ASCII код и записывается посимвольно в строку
        time.sleep(1) #как уже поняли, рандом в моём случае берём по времени. чем значение time.sleep() меньше, тем больше вероятность попадания одинаковых символов в пароле 
    print(result)

print("How long do you want your password to be?")
length_pas = int(input("Length of password: "))
for i in range(5): # работает медленно, цикл выставлен, чтобы результат был виден лучше
    password(length_pas)

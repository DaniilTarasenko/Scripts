import secrets

while True:
    
    print('How many passwords you want')
    
    try:
        count = int(input())
    except ValueError:
        print('Error: Wrong value')
        continue
    if count>16:
        print('Error: The amount of passwords you can get must be 16 and less')
        continue
    elif count<0:
        print('Error: The amount of passwords must be a natural number')
        continue
    
    print('Fine, type in the required length of password')
    
    try:
        length = int(input())
    except ValueError:
        print('Error: Wrong value')
        continue
    if length>16:
        print('Error: The password must be 16-digits long and less')
        continue
    elif length<0:
        print('Error: The length of a password must be a natural number')
    
    for i in range(0, count):
        password = secrets.token_urlsafe(64)[0:length]
        print('Password ' + str(i+1) + ': ' + password)

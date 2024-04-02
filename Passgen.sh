!/bin/bash
read -p "Введите количество паролей: " num_passwords
read -p "Введите длину пароля: " password_length
for i in $(seq 1 $num_passwords)
do
    openssl rand -base64 48 | cut -c1-$password_length
done

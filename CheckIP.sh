#!/bin/bash
read -p "Введите IP-адреса для поиска (разделенные пробелом): " search_terms
for term in $search_terms; do
    if ip -br a | grep -q $term; then
        ip -br a | grep $term
    else
        echo "IP-адрес $term не найден."
    fi
done

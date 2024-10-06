#! /bin/bash

if [ "$#" != "1" ]
then
    echo "---------------------------------------------------------------------------------------------------------"
    echo "|Para executar o script, garanta que você está na raíz do seu projeto (onde seus códigos .l e .h estão)  |"
    echo "|Como único argumento do script, informe o caminho relativo onde estão os arquivos entradaX.c e saidaX_.c|"
    echo "|                         Exemplo: ./verifica_inconsistencias entradas_saidas/                           |"
    echo "---------------------------------------------------------------------------------------------------------"
    exit 2
fi

pasta_arquivos=$1
n_outs=5

for (( i=1; i<=${n_outs}; i++ ))
do
    leo_out="$pasta_arquivos/saida${i}_.txt"
    student_out="$pasta_arquivos/saida${i}.txt"

    # Run the program and generate the student output
    ./analex "${pasta_arquivos}/entrada${i}.c" > ${student_out}

    # Extract relevant data for Leo's output
    count_leo=$(grep -n "TABELA DE SIMBOLO" $leo_out | cut -d':' -f1)
    line_number_leo=$(wc -l < $leo_out)
    table_start_leo=$(expr $line_number_leo - $count_leo + 1)
    symbol_table_leo=$(tail -n $table_start_leo $leo_out)

    # Extract relevant data for student's output
    count_student=$(grep -n "TABELA DE SIMBOLO" $student_out | cut -d':' -f1)
    line_number_student=$(wc -l < $student_out)
    table_start_student=$(expr $line_number_student - $count_student + 1)
    symbol_table_student=$(tail -n $table_start_student $student_out)

    # Compare both outputs
    if [ "$symbol_table_student" == "$symbol_table_leo" ]
    then
        echo "entrada${i}.c resultou idêntico"
    else
        echo "entrada${i}.c resultou diferente"
    fi
done

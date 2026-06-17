@echo off
title Leitor ChatBAT

set URL=https://chatbat-39793-default-rtdb.firebaseio.com

:LOOP

cls

powershell -Command ^
"$dados=Invoke-RestMethod '%URL%/mensagens.json';" ^
"$dados.psobject.Properties.Value | ForEach-Object { '['+$_.hora+'] '+$_.nome+': '+$_.texto }"

timeout /t 3 >nul

goto LOOP
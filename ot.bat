@echo off
rem Oberon Templates. Copyright (c) Alexander Iljin, 2011
del %TMP%\ot_params.tmp 2>nul
:WriteParam
if "%~2" == "" goto :HandleParams
echo %~2>>%TMP%\ot_params.tmp
shift /2
goto :WriteParam

:HandleParams
if not exist %TMP%\ot_params.tmp goto :eof
sed -e "s@\(.*\)=\(.*\)@s/$(\1)/\2/@" <%TMP%\ot_params.tmp >%TMP%\ot_params.sed
rem RegExplanation:
rem The s@what@with@ command substitutes the 'what' text with 'with' text.
rem The 'what' part is essentially '(.*)=(.*)' with brackets escaped by '\'
rem matches with a string with the equals sign and makes the left part
rem available as '\1', and the right part available as '\2' in the 'with' text.
rem The 'with' part is 's/$(left)/right/', with 'left' taken from '\1' buffer
rem and 'right' taken from '\2' buffer.
rem Example: 'Item=Value' becomes 's/$(Item)/Value/'.
rem Note: regular expressions are 'greedy', which means that the rightmost
rem equals sign will be taken when the input string is split in two parts.
rem Example: 'Item=Value=X' becomes 's/$(Item=Value)/X/'.
sed -f %TMP%\ot_params.sed <%~dp0%1.ob2
del %TMP%\ot_params.tmp %TMP%\ot_params.sed

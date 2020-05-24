:: Called from Notepad++ Run  
:: [path_to_bat_file] "$(CURRENT_DIRECTORY)" "$(NAME_PART)"  

:: Change Drive and  to File Directory  
%~d1  
cd %1%

:: Run Cleanup  
call:cleanup  

:: FOR %%A IN (.\figs\*.svg) DO inkscape --export-pdf=.\figs\%%~nA.pdf %%A -D

:: Run pdflatex -&gt; bibtex -&gt; pdflatex -&gt; pdflatex  
pdflatex %2 --shell-escape 
biber  %2  
:: If you are using multibib the following will run bibtex on all aux files  
pdflatex %2  --shell-escape
:: FOR /R . %%G IN (*.aux) DO bibtex %%G 
pdflatex %2  --shell-escape

:: Run Cleanup  
call:cleanup  

:: Open PDF  
START "openpdf" "C:\Program Files\SumatraPDF\SumatraPDF.exe" %3 -reuse-instance 

kill pdflatex

:: Cleanup Function  
:cleanup  
del *.dvi
del *.out
del *.log 
del *.aux  
del *.toc
del *.lol
del *.lof
del *.lot
del *.tcp
del *.tps
del .\chapters\*.aux
del .\back\*.aux
del .\front\*.aux
del *.bbl    
del *.blg  
del *.brf  
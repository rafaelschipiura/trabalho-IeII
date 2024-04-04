
RMD=trabalho.Rmd

PDF=trabalho.pdf

all: $(PDF) 

.PHONY : all clean

$(PDF) : $(RMD)
	Rscript -e "rmarkdown::render('$(RMD)')"

clean :
	rm trabalho.pdf

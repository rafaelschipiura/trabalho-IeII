
RMD=trabalho.Rmd

PDF=trabalho.pdf

README=README.md

LEIAME=fonte-rdm.Rmd

all: $(PDF) $(README)

.PHONY : all clean

$(PDF) : $(RMD) 
	Rscript -e "rmarkdown::render('$(RMD)')"

$(README) : $(LEIAME)
	Rscript -e "rmarkdown::render('$(LEIAME)', output_file='$(README)')"

clean :
	rm trabalho.pdf *.log

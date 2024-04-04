
RMD=trabalho.Rmd

PDF=trabalho.pdf

README=README.md

all: $(PDF) $(README)

.PHONY : all clean

$(PDF) : $(RMD)
	Rscript -e "rmarkdown::render('$(RMD)', output_format='beamer_presentation')"

$(README) : $(RMD)
	Rscript -e "rmarkdown::render('$(RMD)', output_format='md_document', output_file='README.md')"

clean :
	rm trabalho.pdf

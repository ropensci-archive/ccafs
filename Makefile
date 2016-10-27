all: move rmd2md

move:
		cp inst/vign/ccafs_vignette.md vignettes;\
		cp -r inst/vign/img/ vignettes/img/

rmd2md:
		cd vignettes;\
		mv ccafs_vignette.md ccafs_vignette.Rmd

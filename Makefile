all: move rmd2md

move:
		cp inst/vign/ccafs_vignette.md vignettes;\
		cp inst/vign/amazon_s3_keys.md vignettes;\
		cp -r inst/vign/img/ vignettes/img/

rmd2md:
		cd vignettes;\
		mv ccafs_vignette.md ccafs_vignette.Rmd;\
		mv amazon_s3_keys.md amazon_s3_keys.Rmd

#! /bin/bash
#A makefile might be better in the long run...

echo "Converting images from XCF to PNG...";
	for file in ./xcf/*
	do
		base=`basename -s .xcf $file`; 
		echo "$file - $base";
		xcf2png $file -v -o ./png/$base.png;
	done

echo "Scaling selected images...";
	for file in ./png/*
	do
		base=`basename -s .png $file`;
		[[ $base == *correct* ]] && (convert $file -resize 400x400 $file)   
		[[ $base == solder* ]] && (convert $file -resize 400x400 $file)  
		[[ $base == kit ]] && (convert $file -resize 400x400 $file)  
		[[ $base == step* ]] && (convert $file -resize 400x400 $file)  
		[[ $base == fuse ]] && (convert $file -resize 200x200 $file)  
		[[ $base == header* ]] && (convert $file -resize 200x200 $file)  
		echo "Scaling $file";
	done

echo "Converting manual body to mediawiki...";
	pandoc user-manual.md --to=mediawiki -o user-manual.mediawiki;

echo "Making textual subsitutions for RepRap.org images...";
	sed -i 's/Image:.\/png\//File:/g' user-manual.mediawiki;

echo "Converting manual body to LaTeX...";
	pandoc user-manual.md --to=latex -o user-manual-body.tex;

echo "Generating PDF from LaTeX...";
	#run twice to get the TOC
	pdflatex user-manual.tex;
	pdflatex user-manual.tex;

echo "Moving user manual to ./pdf/...";
	mv user-manual.pdf ./pdf/user-manual.pdf;

echo "Cleaning Directory..."
	rm *.aux *.log *.out *.toc

echo "Complete!";


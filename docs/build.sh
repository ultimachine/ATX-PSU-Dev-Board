#! /bin/bash
echo "Converting manual body to mediawiki...";
pandoc user-manual.md --to=mediawiki -o user-manual.mediawiki;
echo "Making textual subsitutions for RepRap.org images and links...";

echo "Converting manual body to LaTeX.";
pandoc user-manual.md --to=latex -o user-manual-body.tex;
echo "Generating PDF from LaTeX.";
pdflatex user-manual.tex;
echo "Complete!";

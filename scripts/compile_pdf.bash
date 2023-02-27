#!/bin/bash

#######################################
# Compiles the document with pdflatex
# Arguments:
#  None
#######################################
function compile() {
  pdflatex -shell-escape main.tex
}

#######################################
# Compiles the bibliography and glossary
# Arguments:
#  None
#######################################
function make_bibliography() {
  biber main
  makeglossaries main
}

#######################################
# Removes all temporary files
# Arguments:
#  None
#######################################
function remove_unwanted_files_after_error() {
  rm -f main.{log,aux,bbl,blg,lof,lot,toc,cod,out,dia,pdf,bcf,run.xml,glo,glg,gls,ist}
}

#######################################
# Arguments:
#  None
#######################################
function main() {
  remove_unwanted_files_after_error
  compile
  make_bibliography

  # Compile the document again to include the bibliography references correctly
  # If the document is not compiled twice, '?' characters are shown in the cites instead of the number of the reference
  # See https://latex-tutorial.com/tutorials/bibtex/ for more information.
  compile
  compile

  mv main.{log,aux,bbl,blg,lof,lot,toc,cod,out,dia,pdf,bcf,run.xml,glo,glg,gls,ist} ../out
}

main

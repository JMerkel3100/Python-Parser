# Python-Parser
A parser for simple Python code developed using ANTLR

Jeffrey Merkel

Set up:
- install java
- install antlr
- create alias for antlr4
    > example in the quickstart section of antlr.org

Run in OS X Terminal:
- antlr4 -Dlanguage=Python3 pokePyth.g4 
- python pokePyth.py < "python file to be parsed"

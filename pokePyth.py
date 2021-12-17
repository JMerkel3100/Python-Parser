import antlr4
from antlr4.InputStream import InputStream
from pokePythLexer import pokePythLexer
from pokePythParser import pokePythParser
import sys

def main(argv):
    input_stream = None
    if len(sys.argv) > 1:
        input_stream = FileStream(sys.argv[1])
    else:
        input_stream = InputStream(sys.stdin.readline())
    lexer = pokePythLexer(input_stream) 
    stream = antlr4.CommonTokenStream(lexer) 
    parser = pokePythParser(stream) 
    tree = parser.block() 
    print(tree.toStringTree(recog=parser))

if __name__ == '__main__':
    main(sys.argv)

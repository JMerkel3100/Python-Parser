grammar pokePyth;

tokens {INDENT,DEDENT}

//   Parser Rules
block
	: statement*
	;

statement
	: ( expression
	| assign
	| COMMENT
	| print_func
	| range_func
	| BREAK
	| CONTINUE
	| complex_statement )?
	NEWLINE
	;

complex_statement
	: if_st
	| while_st
	| for_st
	;

complex_conditional
	: L_PAREN SPACE* conditional_statement SPACE* R_PAREN
	| SPACE* conditional_statement SPACE*
	;

assign
	: NAME SPACE* assign_op SPACE* item
	;

assign_op
	: ASSIGN
	| SUM_ASSIGN
	| SUB_ASSIGN
	| MULT_ASSIGN
	| DIV_ASSIGN
	| MOD_ASSIGN
	| XOR_ASSIGN
	| OR_ASSIGN
	| AND_ASSIGN
	;

conditional_statement
	: item SPACE* conditional SPACE* item ( SPACE+ ( 'and' | 'or' ) SPACE+ conditional_statement )*
	;

item
	: NAME
	| expression
	| number
	| STRING
	;

conditional
	: EQ
	| NOT_EQ
	| LT
	| GT
	| LT_EQ
	| GT_EQ
	;

if_st
	: IF    SPACE* complex_conditional SPACE* COLON NEWLINE INDENT block DEDENT NEWLINE
	 ( ELIF SPACE* complex_conditional SPACE* COLON NEWLINE INDENT block DEDENT NEWLINE )* 
	 ( ELSE SPACE* COLON NEWLINE INDENT block DEDENT NEWLINE)?
	;

while_st
	: WHILE complex_conditional COLON NEWLINE INDENT statement+ DEDENT
	;

//allows for non-closed '('
for_st
	: FOR SPACE* L_PAREN? SPACE* NAME SPACE* 'in' SPACE* range_func SPACE* R_PAREN? SPACE* COLON NEWLINE INDENT block DEDENT NEWLINE
	;

range_func
	: RANGE L_PAREN SPACE* number SPACE* COMMA SPACE* number SPACE* R_PAREN
	;

print_func
	: PRINT L_PAREN (SPACE* stringable (SPACE* '+' SPACE* stringable)* SPACE* ) R_PAREN
	;

stringable
	: STRING
	| str_typecast 
	;

expression
   	: number (( SUM | SUB | MULT | DIV | MOD | AND_OPER | OR_OPER | XOR_OPER ) number)*
   	;

number	
	: SUB? DIGIT+
	| NAME
	| int_typecast
	;

str_typecast
	: 'str' L_PAREN number R_PAREN
	;

//accepts weird occurrences like:    variable.93585 and int(23).972
int_typecast
	: 'int' L_PAREN ( number ( DOT DIGIT+ )? ) R_PAREN
	;


//   Lexer Rules
SUM	: '+' ;

SUB	: '-' ;

MULT	: '*' ;

DIV	: '/' ;

MOD 	: '%' ;

XOR_OPER	: '^' ;

OR_OPER	: '|' ;

AND_OPER	: '&' ;



ASSIGN	: '=' ;

SUM_ASSIGN	: '+=' ;

SUB_ASSIGN	: '-=' ;

MULT_ASSIGN	: '*=' ;

DIV_ASSIGN	: '/=' ;

MOD_ASSIGN	: '%=' ;

XOR_ASSIGN	: '^=' ;

OR_ASSIGN	: '|=' ;

AND_ASSIGN	: '&=' ;



LT	: '<' ;

LT_EQ	: '<=' ;

GT	: '>' ;

GT_EQ	: '>=' ;

EQ	: '==' ;

NOT_EQ	: '!=' ;



AND	: 'and' ;

OR	: 'or' ;

FOR	: 'for' ;

IF	: 'if' ;

ELSE	: 'else' ;

ELIF	: 'elif' ;

WHILE	: 'while' ;

BREAK 	: 'break' ;

CONTINUE	: 'continue' ;

RANGE	: 'range' ;

PRINT	: 'print' ;

NON_ZERO	: [1-9] ;

DIGIT	: [0-9] ;



L_ALPHA	: [a-z] ;

U_ALPHA	: [A-Z] ;

NAME	: L_ALPHA ( L_ALPHA | U_ALPHA | DIGIT | UNDERSCORE )* ;

STRING	: '"' ( L_ALPHA | U_ALPHA | DIGIT | SPACE | DOT | UNDERSCORE | COLON | COMMA | EX_POINT | Q_MARK )* '"' ;

COMMENT	: '#' ( L_ALPHA	| U_ALPHA | DIGIT | SPACE | EX_POINT | UNDERSCORE | COLON | COMMA | DOT | Q_MARK )* '\r' -> skip ;

UNDERSCORE	: '_' ;

COLON	: ':' ;

COMMA	: ',' ;

DOT	: '.' ;

Q_MARK	: '?' ;

EX_POINT	: '!' ;



L_PAREN	: '(' ;

R_PAREN : ')' ;

SPACE	: ' ' ;

TAB	: '\t' ;

NEWLINE 	: '\n' ;

WS	: [ \t\n\r] -> skip ;

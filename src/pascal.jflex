package ScannerP;

%%

%class      PascalLex
%public

%line
%column




%cupsym     ScannerP.PascalTok
%implements java_cup.runtime.Scanner.Scanner
%function   next_token
%type       PascalSym
%eofval{
	if(bracketCount == 0)
    	return new PascalSym(PascalTok.EOF);
    else {
    	Report.error("You forgot to close some of your { brackets! Compiler error at line "+yyline+", column "+yycolumn+".", yyline, yycolumn, -1);
    }
%eofval}
%eofclose

%{
    private PascalSym Symbol(int type) {
    	String sequence = yytext();
    	/*if(type == PascalTok.CHAR_CONST) {
    		sequence = sequence.substring(1, sequence.length()-1);
    	}*/
    
    	if(sequence.equals("''''")) {
    		return new PascalSym(type, yyline + 1, yycolumn + 1, "'");
    	}
        return new PascalSym(type, yyline + 1, yycolumn + 1, sequence);
    }
%}



%{
int bracketCount = 0;
%}

%eof{
%eof}

%state COMMENT


SingleLineComment = "--".*
SingleLineComment2 = "//".*
MultiLineComment = [<][-][-]([^-]|[-][^-]|[-][-][^>])*[-][-][>]
HEX = [0][x][a-fA-F0-9]+
StringConst = [\"][^\"]*[\"]
CharConst = ['][^'][']
%%


<COMMENT> {
	"}"								{ bracketCount --; 
									  if(bracketCount == 0) 
										yybegin(YYINITIAL); }	
	"{"								{ bracketCount++; }
	.								{}
	
	// whitespaces
	[ \n\t\r\f\v]+						{ }
	
}

<YYINITIAL> {


	"{"					    			{ bracketCount++; yybegin(COMMENT);  }
	"}"						    		{ Report.error("At least one too many } in your code!", yyline+1, yycolumn+1, -1); }
	
	// whitespaces
	[ \n\t\r\f\v]+						{ }
	
	// keywords
	"assign"							{ return Symbol(PascalTok.ASSIGN); }
    "and"						    	{ return Symbol(PascalTok.LAND); }
    "break"                          { return Symbol(PascalTok.BREAK);}
    "continue"						{ return Symbol(PascalTok.CONTINUE); }
	"begin"							{ return Symbol(PascalTok.BEGIN); }
	"array"							{ return Symbol(PascalTok.ARRAY); }
	"end"					    		{ return Symbol(PascalTok.END); }
	"do"						    	{ return Symbol(PascalTok.DO); }
	"of"						    	{ return Symbol(PascalTok.OF); }
	"if"					        		{ return Symbol(PascalTok.IF); }
	"else"							{ return Symbol(PascalTok.ELSE); }
	"not"					    		{ return Symbol(PascalTok.NOT); }
    "return"				    		{ return Symbol(PascalTok.RETURN); }
	"or"						    	{ return Symbol(PascalTok.LOR); }
	"function"						{ return Symbol(PascalTok.FUNCTION); }
	"while"							{ return Symbol(PascalTok.WHILE); }
	"program"						{ return Symbol(PascalTok.PROGRAM); }
	"var"					    		{ return Symbol(PascalTok.VAR); }
	"procedure"					{ return Symbol(PascalTok.PROCEDURE); }
	"then"							{ return Symbol(PascalTok.THEN); }
	// names of atomic data structures
	"boolean"						{ return Symbol(PascalTok.BOOL); }
	"char"							{ return Symbol(PascalTok.CHAR); }
	"integer"			    			{ return Symbol(PascalTok.INT); }
    "real"			        			{ return Symbol(PascalTok.REAL); }
    "string"                          { return Symbol(PascalTok.STRING);}

  "long" {
        return new Symbol(PascalTok.LONG, yytext());
    }
    {SingleLineComment} {}
    {SingleLineComment2} {}
    {MultiLineComment}  {}
    {StringConst} {
        return new Symbol(PascalTok.StringConst, yytext());
    }
    {CharConst} {
        return new Symbol(PascalTok.CharConst, yytext());
    }
		
	// constants of atomic data structures	
	"true"|"false"			            		{ return Symbol(PascalTok.BOOL_CONST); }
	[1-9][0-9]*						        { return Symbol(PascalTok.INT_CONST); }
	"0"	            							{ return Symbol(PascalTok.INT_CONST); }
	"0"[xX][1-9A-F][0-9A-F]*		{ return Symbol(PascalTok.HEX_CONST); }
    "0"[Xx]"0"                                  { return Symbol(PascalTok.HEX_CONST); }
    [1-9][0-9]*[.][0-9]+                 { return Symbol(PascalTok.REAL_CONST);}
	"0"[.][0-9]+                               { return Symbol(PascalTok.REAL_CONST);}

	// names of programs, constants, types, variables and subprograms
	[A-Za-z][A-Za-z_0-9]*			{ return Symbol(PascalTok.ID); }

	// other symbols
	":="							{ return Symbol(PascalTok.ASSIGN); }
	":"								{ return Symbol(PascalTok.COLON); }
	","								{ return Symbol(PascalTok.COMMA); }
	"."								{ return Symbol(PascalTok.DOT); }
	"["								{ return Symbol(PascalTok.LBR); }
	"("								{ return Symbol(PascalTok.LPR); }
	"]"								{ return Symbol(PascalTok.RBR); }
	")"								{ return Symbol(PascalTok.RPR); }
	";"								{ return Symbol(PascalTok.SEMI); }
	"+"							{ return Symbol(PascalTok.ADD); }
	"="							{ return Symbol(PascalTok.EQU); }
	">="							{ return Symbol(PascalTok.GEQ); }
	">"							{ return Symbol(PascalTok.GTH); }
	"<"							{ return Symbol(PascalTok.LTH); }
	"<="							{ return Symbol(PascalTok.LEQ); }
	"*"								{ return Symbol(PascalTok.MUL); }
	"<>"							{ return Symbol(PascalTok.NEQ); }
	"^"								{ return Symbol(PascalTok.XOR); }
	"-"							{ return Symbol(PascalTok.SUB); }
    "&"							{ return Symbol(PascalTok.BAND); }
    "|"								{ return Symbol(PascalTok.BOR); }
    "/"								{ return Symbol(PascalTok.DIV); }
    "%"							{ return Symbol(PascalTok.MOD); }
    "~"							{ return Symbol(PascalTok.LNOT); }

	.								{ Report.error("Character not recognizable as valid Pascal keyword, symbol, name, ID or constant.", yyline+1, yycolumn+1, -1); }

}

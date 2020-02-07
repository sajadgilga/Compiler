package ScannerP;

%%

%class      Scanner.PascalLex
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
    	ScannerP.report.Report.error("You forgot to close some of your { brackets! Compiler error at line "+yyline+", column "+yycolumn+".", yyline, yycolumn, -1);
    }
%eofval}
%eofclose

%{
    private PascalSym sym(int type) {
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
	"}"						    		{ ScannerP.report.Report.error("At least one too many } in your code!", yyline+1, yycolumn+1, -1); }
	
	// whitespaces
	[ \n\t\r\f\v]+						{ }
	
	// keywords
	"assign"							{ return sym(PascalTok.ASSIGN); }
    "and"						    	{ return sym(PascalTok.LAND); }
    "break"                          { return sym(PascalTok.BREAK);}
    "continue"						{ return sym(PascalTok.CONTINUE); }
	"begin"							{ return sym(PascalTok.BEGIN); }
	"array"							{ return sym(PascalTok.ARRAY); }
	"end"					    		{ return sym(PascalTok.END); }
	"do"						    	{ return sym(PascalTok.DO); }
	"of"						    	{ return sym(PascalTok.OF); }
	"if"					        		{ return sym(PascalTok.IF); }
	"else"							{ return sym(PascalTok.ELSE); }
	"not"					    		{ return sym(PascalTok.NOT); }
    "return"				    		{ return sym(PascalTok.RETURN); }
	"or"						    	{ return sym(PascalTok.LOR); }
	"function"						{ return sym(PascalTok.FUNCTION); }
	"while"							{ return sym(PascalTok.WHILE); }
	"program"						{ return sym(PascalTok.PROGRAM); }
	"var"					    		{ return sym(PascalTok.VAR); }
	"procedure"					{ return sym(PascalTok.PROCEDURE); }
	"then"							{ return sym(PascalTok.THEN); }
	// names of atomic data structures
	"boolean"						{ return sym(PascalTok.BOOL); }
	"char"							{ return sym(PascalTok.CHAR); }
	"integer"			    			{ return sym(PascalTok.INT); }
    "real"			        			{ return sym(PascalTok.REAL); }
    "string"                          { return sym(PascalTok.STRING);}

		
	// constants of atomic data structures	
	"true"|"false"			            		{ return sym(PascalTok.BOOL_CONST); }
	"''''"					        		        { return sym(PascalTok.CHAR_CONST); }
	"'''"					                       		{ ScannerP.report.Report.error("Invalid character. For ', use a sequence of four characters '.", yyline+1, yycolumn+1, -1); }
	['][\x20-\x26\x28-\x7E]?[']		{ return sym(PascalTok.CHAR_CONST); }
	['][^']*[']						                { ScannerP.report.Report.error("Invalid character definition.", yyline+1, yycolumn+1, -1); }
	[1-9][0-9]*						        { return sym(PascalTok.INT_CONST); }
	"0"	            							{ return sym(PascalTok.INT_CONST); }
	"0"[xX][1-9A-F][0-9A-F]*		{ return sym(PascalTok.HEX_CONST); }
    "0"[Xx]"0"                                  { return sym(PascalTok.HEX_CONST); }
    [1-9][0-9]*[.][0-9]+                 { return sym(PascalTok.REAL_CONST);}
	"0"[.][0-9]+                               { return sym(PascalTok.REAL_CONST);}

	// names of programs, constants, types, variables and subprograms
	[A-Za-z][A-Za-z_0-9]*			{ return sym(PascalTok.ID); }

	// other symbols
	":="							{ return sym(PascalTok.ASSIGN); }
	":"								{ return sym(PascalTok.COLON); }
	","								{ return sym(PascalTok.COMMA); }
	"."								{ return sym(PascalTok.DOT); }
	"["								{ return sym(PascalTok.LBR); }
	"("								{ return sym(PascalTok.LPR); }
	"]"								{ return sym(PascalTok.RBR); }
	")"								{ return sym(PascalTok.RPR); }
	";"								{ return sym(PascalTok.SEMI); }
	"+"							{ return sym(PascalTok.ADD); }
	"="							{ return sym(PascalTok.EQU); }
	">="							{ return sym(PascalTok.GEQ); }
	">"							{ return sym(PascalTok.GTH); }
	"<"							{ return sym(PascalTok.LTH); }
	"<="							{ return sym(PascalTok.LEQ); }
	"*"								{ return sym(PascalTok.MUL); }
	"<>"							{ return sym(PascalTok.NEQ); }
	"^"								{ return sym(PascalTok.XOR); }
	"-"							{ return sym(PascalTok.SUB); }
    "&"							{ return sym(PascalTok.BAND); }
    "|"								{ return sym(PascalTok.BOR); }
    "/"								{ return sym(PascalTok.DIV); }
    "%"							{ return sym(PascalTok.MOD); }
    "~"							{ return sym(PascalTok.LNOT); }

	.								{ ScannerP.report.Report.error("Character not recognizable as valid Pascal keyword, symbol, name, ID or constant.", yyline+1, yycolumn+1, -1); }

}

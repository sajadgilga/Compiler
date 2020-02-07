package Scanner;

public class Symbol extends java_cup.runtime.Symbol {
    public int type;
    public int line;
    public int column;
    public String sequence;

    public Symbol(int type, int line, int column, String sequence) {
        super(type, line, column, sequence);
        this.type = type;
        this.line = line;
        this.column = column;
        this.sequence = sequence;
    }

    public Symbol(int type) {
        super(type);
        this.type = type;
    }
}

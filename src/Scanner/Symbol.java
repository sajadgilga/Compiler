package Scanner;

public class Symbol extends java_cup.runtime.Symbol {
    public Integer type;
    public Integer line;
    public Integer column;
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

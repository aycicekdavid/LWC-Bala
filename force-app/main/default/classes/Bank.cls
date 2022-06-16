public interface Bank {
    public Decimal getInterestRate() { }
}

public BankOfAmerica implements Bank {
    public Decimal getInterestRate() {
        return 14.00;
    }
}

public Citi implements Bank {
    public Decimal getInterestRate() {
        return 11.00;
    }
}

public interface Queueable {
    public void execute(QueuableContext qc); 
}

public MyQueueable implements Queueable {
    
}

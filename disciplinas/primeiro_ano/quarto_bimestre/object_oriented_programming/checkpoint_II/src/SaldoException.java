public class SaldoException extends RuntimeException {
    public SaldoException(String saldo_insuficiente) {
        super ("Seu saldo é insuficiente para esta transação!");
    }
}

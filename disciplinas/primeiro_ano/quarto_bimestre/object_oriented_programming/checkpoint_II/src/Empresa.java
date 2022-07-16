import java.text.NumberFormat;
import java.util.Locale;

public abstract class Empresa extends BarclaysBank{
    // formatar para real
    Locale ptBr = new Locale("pt", "BR");

    private String nomeEmpresa;
    private String CNPJ;
    private String mercadoAtuacao;
    private double saldo;
    private double investimentoMensal;

    public Empresa(String nomeEmpresa, String CNPJ, String mercadoAtuacao) {
        this.nomeEmpresa = nomeEmpresa;
        this.CNPJ = CNPJ;
        this.mercadoAtuacao = mercadoAtuacao;
        this.saldo = 15000.00; // saldo inicial padrao
        this.investimentoMensal = 1500.00; // investimento inicial padrao
    }

    public String getNomeEmpresa() {
        return CNPJ;
    }

    public void setNomeEmpresa(String nomeEmpresa) {
        this.nomeEmpresa = nomeEmpresa;
    }

    public String getCNPJ() {
        return CNPJ;
    }

    public void setCNPJ(String CNPJ) {
        this.CNPJ = CNPJ;
    }

    public String getMercadoAtuacao() {
        return mercadoAtuacao;
    }

    public void setMercadoAtuacao(String mercadoAtuacao) {
        this.mercadoAtuacao = mercadoAtuacao;
    }

    public double getSaldo() {
        return saldo;
    }

    public void setSaldo(double saldo) {
        this.saldo = saldo;
    }

    public double getInvestimentoMensal() {
        return investimentoMensal;
    }

    public void setInvestimentoMensal(double investimentoMensal) {
        this.investimentoMensal = investimentoMensal;
    }

    public void sacar(double valorSaldo) throws SaldoException {
        try {
            if (valorSaldo > this.getSaldo()) {
                throw new SaldoException("Seu saldo é insuficiente para esta transação!");
            } else {
                this.setSaldo(this.getSaldo() - valorSaldo);
            }
        } catch (SaldoException e){
            System.out.print(e.getMessage());
        }
    }

    public void depositar(double valorSaldo) {
        saldo += valorSaldo;
    }

    public void transferir(double valorSaldo, Empresa empresa) {
        try {
            if (valorSaldo > this.getSaldo()) {
                throw new SaldoException("Seu saldo é insuficiente para esta transação!");
            } else {
                this.setSaldo(this.getSaldo() - valorSaldo);
                empresa.setSaldo(empresa.getSaldo() + valorSaldo);
            }
        } catch (SaldoException e) {
            System.out.println(e.getMessage());
        }
    }

    public void investir(double valorSaldo) {
        saldo -= valorSaldo;
        investimentoMensal += valorSaldo;
    }

    @Override
    public String toString() {
        String saldo = NumberFormat.getCurrencyInstance(ptBr).format(this.getSaldo());
        String investimentoMensal = NumberFormat.getCurrencyInstance(ptBr).format(this.getInvestimentoMensal());
        return "\nDados da empresa: " +
                "\nCódigo do Banco: " + this.getCodBanco() +
                "\nNome do Banco: " + this.getNomeBanco() +
                "\nCNPJ: " + this.getCNPJ() +
                "\nNome da empresa: " + this.getNomeEmpresa() +
                "\nCNPJ da empresa: " + this.getCNPJ() +
                "\nMercado de atuação: " + this.getMercadoAtuacao() +
                "\nSaldo da empresa: " + this.getSaldo() +
                "\nInvestimento mensal da empresa: " + this.getInvestimentoMensal();
    }
}

public class Main {
    public static void main(String[] args) {
        BarclaysBank barclaysBank = new BarclaysBank();

        ContaCorrente contaCorrente = new ContaCorrente(
          "SX Negócios",
                "14.981.108/0001-17",
                "plataforma de vendas"
        );

        ContaInvestimento contaInvestimento = new ContaInvestimento(
                "Exatron",
                "48.821.663/0001-01",
                "produtos elétricos"
        );

        // adiciona valores de depósito e saque na conta corrente
        contaCorrente.depositar(2000000.00);
        contaCorrente.sacar(2000.00);

        // investe e verifica a rentabilidade da conta de investimento
        contaInvestimento.investir(50000.00);
        contaInvestimento.rentabilidade();

        // adiciona as empresas a lista
        barclaysBank.adicionarEmpresa(contaCorrente);
        barclaysBank.adicionarEmpresa(contaInvestimento);

        // retorna as empresas em ordem de saldo
        barclaysBank.listarEmpresasSaldo();
    }
}

public class ContaInvestimento extends Empresa {
    public ContaInvestimento (String nomeEmpresa, String CNPJ, String mercadoAtuacao) {
        super(nomeEmpresa, CNPJ, mercadoAtuacao);
    }

    public Double rentabilidade() {
        double rentabilidadeInvestimento = 0;
        if (this.getInvestimentoMensal() > 20.000) {
            rentabilidadeInvestimento = 0.2;
        } else if (this.getInvestimentoMensal() > 100000.00) {
            rentabilidadeInvestimento = 0.4;
        } else {
            rentabilidadeInvestimento = 0.5;
        }
        return rentabilidadeInvestimento;
    }
}

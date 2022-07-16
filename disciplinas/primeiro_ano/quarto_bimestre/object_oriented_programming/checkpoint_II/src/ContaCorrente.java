import java.text.NumberFormat;
import java.util.Scanner;

public class ContaCorrente extends Empresa {
    private boolean solicitouCartao = false;

    public ContaCorrente(String nomeEmpresa, String CNPJ, String mercadoAtuacao) {
        super(nomeEmpresa, CNPJ, mercadoAtuacao);
    }

    public void solicitarCartao() {
        Scanner scanner = new Scanner(System.in);
        System.out.println(
                "Seja bem vindo(a), vamos realizar seu cadastro para solicitar seu cartão!" + System.lineSeparator() +
                        "Digite o nome da sua empresa: "
        );
        String nomeEmpresa = scanner.nextLine();
        System.out.println("Digite o CNPJ da empresa: ");
        String CNPJ = scanner.nextLine();
        System.out.println("Digite o mercado de atuação da empresa: ");
        String mercadoAtuacao = scanner.nextLine();
        System.out.println("Digite o valor desejado para o limite do cartão da empresa: ");
        double limite = scanner.nextDouble();
        String limiteCartao = NumberFormat.getCurrencyInstance(ptBr).format(limite);
        boolean limiteAprovado = limite < 20000.00;
        if (limiteAprovado) {
            System.out.println("O seu cadastro foi realizado com sucesso e o sistema já está processando a solicitação do seu cartão!");
        } else {
            System.out.println("Infelizmente o limite solicitado não é compatível com as diretrizes do banco.");
        }
    }
}

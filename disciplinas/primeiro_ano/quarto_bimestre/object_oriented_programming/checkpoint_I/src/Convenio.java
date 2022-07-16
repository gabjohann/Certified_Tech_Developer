public class Convenio extends Paciente {
    private final String numCarteirinha;
    private final String numCPF;

    public Convenio(
            String nomeCompleto,
            String dataNascimento,
            boolean primeiraConsulta,
            String numCarteirinha,
            String numCPF
    ) {
        super(nomeCompleto, dataNascimento, primeiraConsulta);
        this.numCarteirinha = numCarteirinha;
        this.numCPF = numCPF;
    }

    @Override
    public String cadastro() {
        if(this.isPrimeiraConsulta()) {
            return "Seja bem vindo(a), precisamos fazer seu cadastro rapidamente para você tornar-se nosso paciente";
        }
        return "Seja bem vindo(a) de volta " + getNomeCompleto() + "!";
    }

    @Override
    public String toString() {
        return "\nPaciente do convênio" +
                "\nNome do paciente: " + this.getNomeCompleto() + "," +
                "\nData de nascimento: " + this.getDataNascimento() + "," +
                "\nPaciente cadastrado? " + this.isPrimeiraConsulta() + "," +
                "\nNúmero da carteirinha: " + numCarteirinha + "," +
                "\nCPF:" + numCPF + "\n";
    }
}

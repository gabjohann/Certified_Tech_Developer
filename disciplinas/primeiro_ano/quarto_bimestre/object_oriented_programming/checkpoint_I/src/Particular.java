public class Particular extends Paciente {
    private final double valorConsulta;
    private final String CPF;

    public Particular(
            String nomeCompleto,
            String dataNascimento,
            boolean primeiraConsulta,
            double valorConsulta,
            String CPF) {
        super(nomeCompleto, dataNascimento, primeiraConsulta);
        this.valorConsulta = valorConsulta;
        this.CPF = CPF;
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
        return "\nPaciente particular" +
                "\nNome do paciente: " + this.getNomeCompleto() + "," +
                "\nData de nascimento: " + this.getDataNascimento() + "," +
                "\nPaciente cadastrado? "  + this.isPrimeiraConsulta() + "," +
                "\nValor da consulta: " + valorConsulta + "," +
                "\nCPF:" + CPF + "\n";
    }
}

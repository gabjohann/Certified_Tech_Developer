public abstract class Paciente {
    private final String nomeCompleto;
    private final String dataNascimento;
    private final boolean primeiraConsulta;

    public Paciente(String nomeCompleto, String dataNascimento, boolean primeiraConsulta) {
        this.nomeCompleto = nomeCompleto;
        this.dataNascimento = dataNascimento;
        this.primeiraConsulta = primeiraConsulta;
    }

    public String getNomeCompleto() {
        return nomeCompleto;
    }

    public String getDataNascimento() {
        return dataNascimento;
    }

    public boolean isPrimeiraConsulta() {
        return primeiraConsulta;
    }

    public abstract String cadastro();
}

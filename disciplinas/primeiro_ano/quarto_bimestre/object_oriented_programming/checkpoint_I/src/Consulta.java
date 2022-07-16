import java.time.LocalDate;
import java.util.LinkedList;
import java.util.List;

public class Consulta {
    private final LocalDate dataConsulta;
    private final String especialidade;
    private final String horario;

    private final List<Paciente> pacientes = new LinkedList<>();

    public Consulta(LocalDate dataConsulta, String especialidade, String horario) {
        this.dataConsulta = dataConsulta;
        this.especialidade = especialidade;
        this.horario = horario;
    }

    public void addPaciente(Paciente paciente) {
        pacientes.add(paciente);
    }

    @Override
    public String toString(){
        return "\nConsulta agendada:" +
                "\nData da consulta: "+ dataConsulta + "," +
                "\nEspecialidade:" + especialidade + "," +
                "\nHorário:" + horario + "," +
                "\nNome do paciente:" + pacientes;
    }
}

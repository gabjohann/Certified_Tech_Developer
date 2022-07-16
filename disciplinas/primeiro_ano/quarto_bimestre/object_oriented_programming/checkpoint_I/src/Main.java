import java.time.LocalDate;

public class Main {
    public static void main(String[] args) {

        // marcando consultas dos pacientes
        Consulta consulta_neuro = new Consulta(LocalDate.now(), "Neurologista", "09:20");
        Consulta consulta_dermato = new Consulta(LocalDate.now(), "Dermatologista", "10:30");
        Consulta consulta_nefro = new Consulta(LocalDate.now(), "Nefrologista", "14:00");
        Consulta consulta_uro = new Consulta(LocalDate.now(), "Urologista", "17:00");

        // cadastrando os pacientes
        Convenio paciente_01 = new Convenio(
                "Lucas Gabriel Johann",
                "19/04/2002",
                true,
                "194.202.547.450.006",
                "874.870.100-90"
        );

        Convenio paciente_02 = new Convenio(
                "Vivian de Goes",
                "02/03/2001",
                false,
                "240.709.064.160.002",
                "285.544.240-00"
        );

        Particular paciente_03 = new Particular(
                "Luci Ferrnandes",
                "02/11/1964",
                true,
                280.00,
                "367.608.220-64"
        );

        Particular paciente_04 = new Particular(
                "Marcelo Johann",
                "31/03/1973",
                false,
                300.00,
                "992.091.860-10"
        );
        
        // marcando as consultas dos pacientes cadastrados
        consulta_neuro.addPaciente(paciente_01);
        consulta_dermato.addPaciente(paciente_02);
        consulta_nefro.addPaciente(paciente_03);
        consulta_uro.addPaciente(paciente_04);

        System.out.println(paciente_01);
        System.out.println(paciente_02);
        System.out.println(paciente_03);
        System.out.println(paciente_04);
    }
}

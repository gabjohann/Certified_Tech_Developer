import java.util.Arrays;
import java.util.List;
import java.util.ArrayList;

public class BarclaysBank {
    private final Integer codBanco = 740;
    private final String nomeBanco = "Barclays Bank";
    private final String CNPJ = "44.973.490/0001-88";
    private List<Empresa> listarEmpresas;

    public BarclaysBank() {
        listarEmpresas = new ArrayList<Empresa>();
    }

    public void adicionarEmpresa(Empresa empresa) {
        listarEmpresas.add(empresa);
    }

    public Integer getCodBanco() {
        return codBanco;
    }

    public String getNomeBanco() {
        return nomeBanco;
    }

    public String getCNPJ() {
        return CNPJ;
    }

    public void listarEmpresasSaldo() {
        ArrayList<Empresa> empresasOrdemSaldo = new ArrayList<Empresa>(listarEmpresas);
        empresasOrdemSaldo.sort((Empresa empresa1, Empresa empresa2) -> {
            return Double.compare(empresa2.getSaldo(), empresa1.getSaldo());
        });
        for (Empresa empresa : empresasOrdemSaldo) {
            System.out.println(empresa.toString());
        }
    }
}

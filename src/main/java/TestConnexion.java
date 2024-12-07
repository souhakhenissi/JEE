import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class TestConnexion {
    public static void main(String[] args) {
        String url = "jdbc:postgresql://localhost:5432/boutique_db";
        String user = "postgres";
        String password = "souha3579";

        try (Connection conn = DriverManager.getConnection(url, user, password);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM public.utilisateurs")) {
            
            while (rs.next()) {
                System.out.println("Utilisateur : " + rs.getString("nom") + ", Email : " + rs.getString("email"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/InscriptionServlet")
public class InscriptionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public InscriptionServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer les données du formulaire
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("password");

        try (Connection conn = DatabaseConnection.getConnection()) {
            // Vérification si la connexion est valide
            if (conn == null) {
                request.setAttribute("errorMessage", "Problème de connexion à la base de données.");
                request.getRequestDispatcher("/inscription.jsp").forward(request, response);
                return;
            }

            // Vérifier si l'email existe déjà
            String checkEmailQuery = "SELECT * FROM utilisateurs WHERE email = ?";
            try (PreparedStatement stmt = conn.prepareStatement(checkEmailQuery)) {
                stmt.setString(1, email);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    // L'email existe déjà, afficher un message d'erreur
                    request.setAttribute("errorMessage", "Cet email est déjà utilisé.");
                    request.getRequestDispatcher("/inscription.jsp").forward(request, response);
                    return;
                }
            }

            // Insérer l'utilisateur dans la base de données
            String insertQuery = "INSERT INTO utilisateurs (nom, email, mot_de_passe, role) VALUES (?, ?, ?, 'utilisateur')";
            try (PreparedStatement stmt = conn.prepareStatement(insertQuery)) {
                stmt.setString(1, nom);
                stmt.setString(2, email);
                stmt.setString(3, motDePasse); // Attention : mot de passe en clair (non sécurisé)
                
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    // Succès : redirection vers la page de connexion
                    response.sendRedirect("connexion.jsp");
                } else {
                    request.setAttribute("errorMessage", "Une erreur est survenue, veuillez réessayer.");
                    request.getRequestDispatcher("/inscription.jsp").forward(request, response);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur SQL : " + e.getMessage());
            request.getRequestDispatcher("/inscription.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Une erreur est survenue : " + e.getMessage());
            request.getRequestDispatcher("/inscription.jsp").forward(request, response);
        }
    }
}

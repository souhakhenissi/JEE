

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
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ConnexionServlet
 */
@WebServlet("/ConnexionServlet")
public class ConnexionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ConnexionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT * FROM utilisateurs WHERE email = ? AND mot_de_passe = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, email);
                pstmt.setString(2, password); // Vous devriez sécuriser le mot de passe avec un hashage
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    // Créer une session pour l'utilisateur
                    HttpSession session = request.getSession();
                    session.setAttribute("utilisateur_id", rs.getInt("ID"));
                    session.setAttribute("utilisateur_nom", rs.getString("nom"));
                    session.setAttribute("role", rs.getString("role"));
                    response.sendRedirect("ClientServlet"); // Rediriger vers la page d'accueil après connexion
                } else {
                    // Si l'email ou le mot de passe est incorrect, afficher un message d'erreur
                    request.setAttribute("errorMessage", "Identifiants incorrects. Veuillez réessayer.");
                    request.getRequestDispatcher("connexion.jsp").forward(request, response);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur de connexion");
        }
	}

}



import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import boutique.Product;

/**
 * Servlet implementation class ClientServlet
 */
@WebServlet("/ClientServlet")
public class ClientServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ClientServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        // Initialiser le ProductDAO
        productDAO = new ProductDAO();
    }
    // Méthode GET pour récupérer et afficher les produits
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer les produits par catégorie
        List<Product> productListHommes = productDAO.getProductsByCategory("hommes");
        List<Product> productListFemmes = productDAO.getProductsByCategory("femmes");
        List<Product> productListEnfants = productDAO.getProductsByCategory("enfants");
        List<Product> productListAccessoires = productDAO.getProductsByCategory("accessoires");

        // Passer les listes de produits à la JSP
        request.setAttribute("productsHommes", productListHommes);
        request.setAttribute("productsFemmes", productListFemmes);
        request.setAttribute("productsEnfants", productListEnfants);
        request.setAttribute("productsAccessoires", productListAccessoires);

        // Rediriger vers la page JSP
        request.getRequestDispatcher("/client.jsp").forward(request, response);
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

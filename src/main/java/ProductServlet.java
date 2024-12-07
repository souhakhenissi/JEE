import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import boutique.Product;

@WebServlet("/ProductServlet")

public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

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
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

 // Méthode POST pour gérer l'ajout au panier
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
     // Récupérer les informations du produit ajouté
        String productName = request.getParameter("productName");
        double productPrice = Double.parseDouble(request.getParameter("productPrice"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        
        // Récupérer le panier de la session, ou en créer un nouveau s'il n'existe pas
        List<Map<String, Object>> panier = (List<Map<String, Object>>) request.getSession().getAttribute("panier");
        if (panier == null) {
            panier = new ArrayList<>();
        }
        
        // Vérifier si le produit est déjà dans le panier
        boolean found = false;
        for (Map<String, Object> item : panier) {
            if (item.get("nom").equals(productName)) {
                // Si le produit est déjà dans le panier, on augmente la quantité
                item.put("quantite", (int) item.get("quantite") + quantity);
                found = true;
                break;
            }
        }
        
        // Si le produit n'est pas trouvé, on l'ajoute
        if (!found) {
            Map<String, Object> newProduct = new HashMap<>();
            newProduct.put("nom", productName);
            newProduct.put("prix", productPrice);
            newProduct.put("quantite", quantity);
            panier.add(newProduct);
        }

        // Sauvegarder le panier dans la session
        request.getSession().setAttribute("panier", panier);

        // Rediriger vers la page panier.jsp
        response.sendRedirect("panier.jsp");
    }
}

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import boutique.Product;

public class ProductDAO {

    private static final Logger LOGGER = Logger.getLogger(ProductDAO.class.getName());

    // Requête pour récupérer les produits par catégorie
    private static final String GET_PRODUCTS_BY_CATEGORY_QUERY = 
        "SELECT * FROM products WHERE categorie = ? AND stock > 0";

    // Requête pour récupérer tous les produits en stock
    private static final String GET_ALL_PRODUCTS_QUERY = 
        "SELECT * FROM products WHERE stock > 0";

    // Requête pour récupérer un produit par son ID
    private static final String GET_PRODUCT_BY_ID_QUERY = 
        "SELECT * FROM products WHERE id = ?";

    // Requête pour récupérer la quantité d'un produit par ID
    private static final String GET_PRODUCT_QUANTITY_QUERY = 
        "SELECT stock FROM products WHERE id = ?";

    // Méthode pour récupérer les produits par catégorie
    public List<Product> getProductsByCategory(String category) {
        List<Product> productList = new ArrayList<>();
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(GET_PRODUCTS_BY_CATEGORY_QUERY)) {
            
            stmt.setString(1, category);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String nom = rs.getString("nom");
                    String description = rs.getString("description");
                    double prix = rs.getDouble("prix");
                    String image = rs.getString("image");
                    int stock = rs.getInt("stock");
                    String categorie = rs.getString("categorie");
                    
                    Product product = new Product(id, nom, description, prix, image, stock, categorie);
                    productList.add(product);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving products by category", e);
        }
        
        return productList;
    }

    // Méthode pour récupérer tous les produits en stock
    public List<Product> getAllProducts() {
        List<Product> productList = new ArrayList<>();
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(GET_ALL_PRODUCTS_QUERY);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                int id = rs.getInt("id");
                String nom = rs.getString("nom");
                String description = rs.getString("description");
                double prix = rs.getDouble("prix");
                String image = rs.getString("image");
                int stock = rs.getInt("stock");
                String categorie = rs.getString("categorie");
                
                Product product = new Product(id, nom, description, prix, image, stock, categorie);
                productList.add(product);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving all products", e);
        }
        
        return productList;
    }

    // Méthode pour récupérer un produit par son ID
    public Product getProductById(int productId) {
        Product product = null;
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(GET_PRODUCT_BY_ID_QUERY)) {
            
            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int id = rs.getInt("id");
                    String nom = rs.getString("nom");
                    String description = rs.getString("description");
                    double prix = rs.getDouble("prix");
                    String image = rs.getString("image");
                    int stock = rs.getInt("stock");
                    String categorie = rs.getString("categorie");
                    
                    product = new Product(id, nom, description, prix, image, stock, categorie);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving product by ID", e);
        }
        
        return product;
    }

    // Méthode pour récupérer la quantité d'un produit par ID
    public int getQuantity(int productId) {
        int quantity = 0;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(GET_PRODUCT_QUANTITY_QUERY)) {
            
            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    quantity = rs.getInt("stock");
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving product quantity by ID", e);
        }
        
        return quantity;
    }
}

package boutique;

public class cart {

    private Product product;  // Un produit
    private int quantity;     // Quantité de ce produit dans le panier

    // Constructeur
    public cart(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    // Getters et Setters
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    // Méthode pour calculer le prix total pour ce produit dans le panier
    public double getTotalPrice() {
        return product.getPrix() * quantity;
    }
}

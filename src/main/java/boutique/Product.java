package boutique;

public class Product {
    // Attributs
    private int id;
    private String nom;
    private String description;
    private double prix;
    private String image;
    private int stock;
    private String categorie; // Nouvel attribut catégorie

    // Constructeur par défaut
    public Product() {
    }

    // Constructeur avec tous les attributs
    public Product(int id, String nom, String description, double prix, String image, int stock, String categorie) {
        this.id = id;
        this.nom = nom;
        this.description = description;
        this.prix = prix;
        this.image = image;
        this.stock = stock;
        this.categorie = categorie; // Initialisation de catégorie
    }

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrix() {
        return prix;
    }

    public void setPrix(double prix) {
        this.prix = prix;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getCategorie() {
        return categorie;
    }

    public void setCategorie(String categorie) {
        this.categorie = categorie;
    }

    // Méthode toString
    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                ", description='" + description + '\'' +
                ", prix=" + prix +
                ", image='" + image + '\'' +
                ", stock=" + stock +
                ", categorie='" + categorie + '\'' +
                '}';
    }
}

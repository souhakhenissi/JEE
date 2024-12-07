<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Boutique en ligne</title>
    <!-- Intégration de Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
  <style>
    /* Style général */
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f4f4f4;
    }

    /* Menu de navigation */
    .navbar {
        display: flex;
        justify-content: space-between;
        padding: 30px;
        background-color: #333;
        color: white;
    }

    .navbar .menu {
        list-style: none;
        display: flex;
        margin: 0;
        padding: 0;
    }

    .navbar .menu li {
        margin: 0 10px;
    }

    .navbar .menu li a {
        color: white;
        text-decoration: none;
    }

    .user-section {
        display: flex;
        align-items: center;
    }

    .user-section .username, .user-section .cart {
        margin-left: 20px;
    }

    /* Description de la boutique */
    .store-description {
        padding: 20px;
        text-align: center;
        background-color: #f4f4f4;
    }

    .store-description h1 {
        margin: 0;
        color: #333;
    }

    .store-description p {
        color: #555;
        font-size: 16px;
    }

    /* Affichage des produits par catégorie */
    .category-section {
        padding: 20px;
           margin-bottom: 30px;
           background-color: #fff;
           border-radius: 10px;
           box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }

    .category-section h2 {
        text-align: center;
        color: #333;
    }

    .product-list {
        display: flex;
           flex-wrap: wrap;
           justify-content: space-evenly;
           gap: 20px;
           padding: 20px;
    }

    .product {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: center;
        width: 300px;
        background-color: #fff;
        border-radius: 5px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }

    .product img {
        max-width: 100%;
        height: auto;
        border-radius: 5px;
    }

    .add-to-cart-btn {
        background-color: #007bff;
        color: white;
        border: none;
        padding: 10px;
        cursor: pointer;
        border-radius: 5px;
    }

    .add-to-cart-btn:hover {
        background-color: #0056b3;
    }

    /* Footer */
    footer {
        padding: 10px;
        text-align: center;
        background-color: #333;
        color: white;
    }
</style>

</head>
<body>
    <!-- Menu de navigation -->
    <div class="navbar">
        <ul class="menu">
            <li><a href="#">Boutique</a></li>
        </ul>
        <div class="user-section">
            <div class="username">
                <i class="fas fa-user"></i>
                <%
                    String clientNom = (String) session.getAttribute("utilisateur_nom");
                    if (clientNom == null) {
                        response.sendRedirect("connexion.jsp");
                        return;
                    }
                %>
                <span><%= clientNom %></span>
            </div>
            <div class="cart">
                <i class="fas fa-shopping-cart"></i>
                <a href="panier.jsp">Mon panier</a>
            </div>
        </div>
    </div>

    <!-- Description de la boutique -->
    <div class="store-description">
        <h1>Bienvenue dans votre espace client !</h1>
        <p>Retrouvez vos produits favoris, ajoutez-les au panier et profitez d'une expérience de shopping fluide.</p>
    </div>

    <!-- Section des produits -->
    <% 
        List<boutique.Product> productsHommes = (List<boutique.Product>) request.getAttribute("productsHommes");
        List<boutique.Product> productsFemmes = (List<boutique.Product>) request.getAttribute("productsFemmes");
        List<boutique.Product> productsEnfants = (List<boutique.Product>) request.getAttribute("productsEnfants");
        List<boutique.Product> productsAccessoires = (List<boutique.Product>) request.getAttribute("productsAccessoires");
    %>

    <div class="category-section">
        <h2>Hommes</h2>
        <div class="product-list">
            <% if (productsHommes != null) {
                for (boutique.Product product : productsHommes) { %>
                    <div class="product">
                        <img src="<%= request.getContextPath() + "/images/" + product.getImage() %>" alt="<%= product.getNom() %>">
                        <h3><%= product.getNom() %></h3>
                        <p><%= product.getDescription() %></p>
                        <p>Prix : <%= product.getPrix() %> TND</p>
                        <button class="add-to-cart-btn" onclick="addToCart('<%= product.getId() %>')">Ajouter au panier</button>
                    </div>
            <% }
            } else { %>
                <p>Aucun produit disponible pour cette catégorie.</p>
            <% } %>
        </div>
    </div>

    <div class="category-section">
        <h2>Femmes</h2>
        <div class="product-list">
            <% if (productsFemmes != null) {
                for (boutique.Product product : productsFemmes) { %>
                    <div class="product">
                        <img src="<%= request.getContextPath() + "/images/" + product.getImage() %>" alt="<%= product.getNom() %>">
                        <h3><%= product.getNom() %></h3>
                        <p><%= product.getDescription() %></p>
                        <p>Prix : <%= product.getPrix() %> TND</p>
                        <button class="add-to-cart-btn" onclick="addToCart('<%= product.getId() %>')">Ajouter au panier</button>
                    </div>
            <% }
            } else { %>
                <p>Aucun produit disponible pour cette catégorie.</p>
            <% } %>
        </div>
    </div>

    <!-- Répétition similaire pour les catégories Enfants et Accessoires -->
    <div class="category-section">
        <h2>Enfants</h2>
        <div class="product-list">
            <% if (productsEnfants != null) {
                for (boutique.Product product : productsEnfants) { %>
                    <div class="product">
                        <img src="<%= request.getContextPath() + "/images/" + product.getImage() %>" alt="<%= product.getNom() %>">
                        <h3><%= product.getNom() %></h3>
                        <p><%= product.getDescription() %></p>
                        <p>Prix : <%= product.getPrix() %> TND</p>
                        <button class="add-to-cart-btn" onclick="addToCart('<%= product.getId() %>')">Ajouter au panier</button>
                    </div>
            <% }
            } else { %>
                <p>Aucun produit disponible pour cette catégorie.</p>
            <% } %>
        </div>
    </div>

    <div class="category-section">
        <h2>Accessoires</h2>
        <div class="product-list">
            <% if (productsAccessoires != null) {
                for (boutique.Product product : productsAccessoires) { %>
                    <div class="product">
                        <img src="<%= request.getContextPath() + "/images/" + product.getImage() %>" alt="<%= product.getNom() %>">
                        <h3><%= product.getNom() %></h3>
                        <p><%= product.getDescription() %></p>
                        <p>Prix : <%= product.getPrix() %> TND</p>
                        <button class="add-to-cart-btn" onclick="addToCart('<%= product.getId() %>')">Ajouter au panier</button>
                    </div>
            <% }
            } else { %>
                <p>Aucun produit disponible pour cette catégorie.</p>
            <% } %>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p>© 2024 Boutique en ligne - Tous droits réservés</p>
        <p>Pour toute question, contactez-nous via notre page de support.</p>
    </footer>

    <!-- Script pour ajouter un produit au panier -->
    <script>
        function addToCart(productId) {
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "AddToCartServlet", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    alert('Le produit a été ajouté au panier.');
                }
            };
            xhr.send("productId=" + productId);
        }
    </script>
</body>
</html>

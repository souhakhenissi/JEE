<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Boutique en ligne</title>
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
           background-color: #333;
           padding: 30px;
           align-items: center;
       }

       .navbar .menu {
           list-style-type: none;
           margin: 0;
           padding: 0;
           display: flex;
           align-items: center;
       }

       .navbar .menu li {
           margin: 0 20px;
       }

       .navbar .menu li a {
           color: white;
           text-decoration: none;
           font-size: 18px;
       }

       /* Boutons S'inscrire et Se connecter côte à côte à gauche */
       .navbar .auth-buttons {
           display: flex;
           gap: 15px; /* Espacement entre les boutons */
       }

       .navbar .signup-btn a, .navbar .login-btn a {
           color: white;
           text-decoration: none;
           font-size: 18px;
           padding: 10px 20px;
           background-color: #28a745;
           border-radius: 5px;
       }

       /* Description de la boutique */
       .store-description {
           text-align: center;
           margin: 20px;
       }

       .store-description h1 {
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
           background-color: white;
           border: 1px solid #ddd;
           border-radius: 10px;
           width: 250px;
           padding: 15px;
           text-align: center;
           box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
       }

       .product-image {
           width: 100%;
           height: auto;
           border-radius: 5px;
       }

       .add-to-cart-btn {
           padding: 10px 20px;
           background-color: #007bff;
           color: white;
           border: none;
           border-radius: 5px;
           cursor: pointer;
       }

       .add-to-cart-btn:hover {
           background-color: #0056b3;
       }

       /* Footer */
       footer {
           background-color: #333;
           color: white;
           text-align: center;
           padding: 20px;
           margin-top: 30px;
       }

       /* Message d'alerte pour l'inscription */
       .signup-message {
           display: none;
           position: fixed;
           top: 20%;
           left: 50%;
           transform: translateX(-50%);
           background-color: #f8d7da;
           color: #721c24;
           border: 1px solid #f5c6cb;
           padding: 20px;
           border-radius: 5px;
           box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
       }

       .signup-message button {
           background-color: #dc3545;
           color: white;
           padding: 5px 10px;
           border: none;
           border-radius: 5px;
           cursor: pointer;
       }
   </style>
</head>
<body>
   <!-- Menu de navigation -->
   <div class="navbar">
       <div class="menu">
           <li><a href='#'>Boutique</a></li>
       </div>
       <!-- Boutons "S'inscrire" et "Se connecter" à gauche -->
       <div class="auth-buttons">
           <div class="login-btn">
               <a href="connexion.jsp">Se connecter</a>
           </div>
           <div class="signup-btn">
               <a href="inscription.jsp">S'inscrire</a>
           </div>
       </div>
   </div>

   <!-- Description de la boutique -->
   <div class="store-description">
       <h1>Bienvenue dans notre boutique en ligne !</h1>
       <p>Découvrez une large sélection de produits de qualité, adaptés à tous les styles et toutes les catégories. Faites votre shopping en toute simplicité et ajoutez vos articles au panier. Pour finaliser votre achat, n'oubliez pas de vous inscrire !</p>
   </div>
   <!-- Affichage des produits par catégorie -->
   <div class="category-section">
       <h2>Hommes</h2>
       <div class="product-list">
           <c:forEach var="product" items="${productsHommes}">
               <div class="product">
                   <img src="images/${product.image}" class="product-image">
                   <h3>${product.nom}</h3>
                   <p>${product.description}</p>
                   <p>Prix : ${product.prix} TND</p>
                   <button class="add-to-cart-btn" onclick="addToCart('${product.id}')">Ajouter au panier</button>
               </div>
           </c:forEach>
       </div>
   </div>
   <div class="category-section">
       <h2>Femmes</h2>
       <div class="product-list">
           <c:forEach var="product" items="${productsFemmes}">
               <div class="product">
                   <img src="images/${product.image}" class="product-image">
                   <h3>${product.nom}</h3>
                   <p>${product.description}</p>
                   <p>Prix : ${product.prix} TND</p>
                   <button class="add-to-cart-btn" onclick="addToCart('${product.id}')">Ajouter au panier</button>
               </div>
           </c:forEach>
       </div>
   </div>
   <div class="category-section">
       <h2>Enfants</h2>
       <div class="product-list">
           <c:forEach var="product" items="${productsEnfants}">
               <div class="product">
                   <img src="images/${product.image}" class="product-image">
                   <h3>${product.nom}</h3>
                   <p>${product.description}</p>
                   <p>Prix : ${product.prix} TND</p>
                   <button class="add-to-cart-btn" onclick="addToCart('${product.id}')">Ajouter au panier</button>
               </div>
           </c:forEach>
       </div>
   </div>
   <div class="category-section">
       <h2>Accessoires</h2>
       <div class="product-list">
           <c:forEach var="product" items="${productsAccessoires}">
               <div class="product">
                   <img src="images/${product.image}" class="product-image">
                   <h3>${product.nom}</h3>
                   <p>${product.description}</p>
                   <p>Prix : ${product.prix} TND</p>
                   <button class="add-to-cart-btn" onclick="addToCart('${product.id}')">Ajouter au panier</button>
               </div>
           </c:forEach>
       </div>
   </div>
   
    <!-- Footer -->
   <footer>
       <p>© 2024 Boutique en ligne - Tous droits réservés</p>
       <p>Pour toute question, contactez-nous via notre page de support.</p>
   </footer>

   <div id="signup-message" class="signup-message">
       <p>Pour ajouter des articles au panier, vous devez d'abord vous inscrire ou vous connecter !</p>
       <button onclick="closeMessage()">Fermer</button>
   </div>

   <script>
       function addToCart(productId) {
           var isLoggedIn = false; // À définir selon l'état de connexion
           if (!isLoggedIn) {
               document.getElementById("signup-message").style.display = "block";
           } else {
               // Ajouter au panier (logique à implémenter)
           }
       }

       function closeMessage() {
           document.getElementById("signup-message").style.display = "none";
       }
   </script>
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="boutique.Product" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mon Panier</title>
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
            background-color: #333;
            padding: 30px;
            align-items: center;
        }

        /* Section du panier */
        .cart-container {
            margin: 20px;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .cart-container h2 {
            text-align: center;
            color: #333;
        }

        .cart-item {
            display: flex;
            justify-content: space-between;
            padding: 15px;
            border-bottom: 1px solid #ddd;
        }

        .cart-item img {
            width: 100px;
            height: auto;
            border-radius: 5px;
        }

        .cart-item-details {
            flex: 1;
            margin-left: 15px;
        }

        .cart-item-name {
            font-size: 18px;
            color: #333;
        }

        .cart-item-price {
            font-size: 16px;
            color: #555;
        }

        .cart-item-remove {
            color: #ff0000;
            cursor: pointer;
        }

        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .quantity-controls button {
            padding: 5px 10px;
            font-size: 14px;
            cursor: pointer;
            background-color: #f1f1f1;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .cart-summary {
            margin-top: 20px;
            text-align: right;
        }

        .checkout-btn {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }

        .checkout-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <div class="navbar">
        <ul class="menu">
            <li><a href="client.jsp">Boutique</a></li>
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

    <!-- Section Panier -->
    <div class="cart-container">
        <h2>Votre Panier</h2>
        <% 
            List<Product> cart = (List<Product>) session.getAttribute("cart");
            double totalPrice = 0.0;
            if (cart != null && !cart.isEmpty()) {
                for (Product product : cart) { 
                    totalPrice += product.getPrix(); // Calcul du total
        %>
            <div class="cart-item">
                <img src="<%= request.getContextPath() + "/images/" + (product.getImage() != null ? product.getImage() : "default_image.jpg") %>" alt="<%= product.getNom() %>">
                <div class="cart-item-details">
                    <div class="cart-item-name"><%= product.getNom() %></div>
                    <div class="cart-item-price"><%= product.getPrix() %> TND</div>
                </div>
                <div class="cart-item-quantity">
                    <form action="updateQuantity.jsp" method="post">
                        <input type="hidden" name="productId" value="<%= product.getId() %>">
                        <div class="form-group d-flex justify-content-between">
                            <button type="submit" name="action" value="increase" class="btn btn-sm btn-incre"><i class="fas fa-plus-square"></i></button>
                            <input type="text" name="quantity" class="form-control" value="<%= product.getQuantity() %>" readonly>
                            <button type="submit" name="action" value="decrease" class="btn btn-sm btn-decre"><i class="fas fa-minus-square"></i></button>
                        </div>
                    </form>
                </div>
                <div class="cart-item-remove">
                    <a href="removeFromCart.jsp?productId=<%= product.getId() %>" class="btn btn-sm btn-danger">Supprimer</a>
                </div>
            </div>
        <% 
                } 
            } else { 
        %>
            <p>Votre panier est vide.</p>
        <% 
            } 
        %>

        <div class="cart-summary">
            <h3>Total: <%= totalPrice %> TND</h3>
            <a class="checkout-btn" href="checkout.jsp">Passer à la caisse</a>
        </div>
    </div>

    <script>
        function changeQuantity(productId, delta) {
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "ChangeQuantityServlet", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    var newQuantity = xhr.responseText;
                    document.getElementById("quantity-" + productId).innerText = newQuantity;
                    location.reload(); // Recharger la page après modification de la quantité
                }
            };
            xhr.send("productId=" + productId + "&delta=" + delta);
        }

        function removeFromCart(productId) {
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "RemoveFromCartServlet", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    location.reload(); // Recharger la page après suppression
                }
            };
            xhr.send("productId=" + productId);
        }
    </script> 
</body>

</html>

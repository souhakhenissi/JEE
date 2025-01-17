

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ChangeQuantityServlet
 */
@WebServlet("/ChangeQuantityServlet")
public class ChangeQuantityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangeQuantityServlet() {
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
		 int productId = Integer.parseInt(request.getParameter("productId"));
	        int delta = Integer.parseInt(request.getParameter("delta"));
	        
	        Map<Integer, Integer> cartQuantities = (Map<Integer, Integer>) request.getSession().getAttribute("cartQuantities");
	        
	        if (cartQuantities == null) {
	            cartQuantities = new HashMap<>();
	        }
	        
	        int currentQuantity = cartQuantities.getOrDefault(productId, 0);
	        int newQuantity = currentQuantity + delta;
	        
	        if (newQuantity > 0) {
	            cartQuantities.put(productId, newQuantity);
	        }
	        
	        request.getSession().setAttribute("cartQuantities", cartQuantities);
	        response.getWriter().write(String.valueOf(newQuantity));
	    }
	}


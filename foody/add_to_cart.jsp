<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <% // ตรวจสอบว่ามีการกดปุ่ม Add to cart หรือไม่ if
(request.getParameter("add_to_cart") != null) { //
รับค่าชื่อสินค้าและราคาสินค้าจาก POST String productName =
request.getParameter("product_name"); double productPrice =
Double.parseDouble(request.getParameter("product_price")); //
เพิ่มสินค้าลงในตะกร้าสินค้า List<CartItem>
	cartItems = (List<CartItem
		>) session.getAttribute("cart_items"); if (cartItems == null) { cartItems =
		new ArrayList<>(); } cartItems.add(new CartItem(productName, productPrice));
		session.setAttribute("cart_items", cartItems); //
		แจ้งให้ผู้ใช้ทราบว่าเพิ่มสินค้าลงในตะกร้าสินค้าเรียบร้อยแล้ว
		request.setAttribute("message", "เพิ่มสินค้าลงในตะกร้าสินค้าเรียบร้อยแล้ว");
		} %>

		<!DOCTYPE html>
		<html lang="th">
			<head>
				<meta charset="UTF-8" />
				<title>Add to cart</title>
			</head>
			<body>
				<h1>Add to cart</h1>

				<c:if test="${not empty message}">
					<p class="message">${message}</p>
				</c:if>

				<form action="add_to_cart.jsp" method="post">
					<div>
						<label for="product_name">ชื่อสินค้า</label>
						<input type="text" name="product_name" id="product_name" />
					</div>
					<div>
						<label for="product_price">ราคาสินค้า</label>
						<input type="number" name="product_price" id="product_price" />
					</div>
					<div>
						<input type="submit" name="add_to_cart" value="Add to cart" />
					</div>
				</form>
			</body>
		</html> </CartItem
></CartItem>

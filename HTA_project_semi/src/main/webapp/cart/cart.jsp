<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>

<script type="text/javascript">

	var totalPrice=0;
	function allCheck(chBox) {
		let listCheck = document.getElementsByName("listCheck");
		let check = chBox.checked;
		totalPrice=parseInt(0);
		if (check) {﻿
			for (let i=0; i<listCheck.length; i++){
				if(listCheck[i].type == "checkbox") {
					listCheck[i].checked = true;
					totalPrice=parseInt(totalPrice)+parseInt(listCheck[i].value);
				}
			}
		} else {
			for (let i=0; i<listCheck.length; i++) {
				if(listCheck[i].type == "checkbox"){
					listCheck[i].checked = false;
					totalPrice=parseInt(0);
				}
			}
		}
		let span1=document.getElementById("total_price1");
		span1.innerHTML=totalPrice;
		let span2=document.getElementById("total_price2");
		span2.innerHTML=totalPrice;
	}

	function calc_total(chBox) {
		if(chBox.checked) {
			totalPrice=parseInt(totalPrice)+parseInt(chBox.value);
		}else {
			totalPrice=parseInt(totalPrice)-parseInt(chBox.value);
		}
		let span1=document.getElementById("total_price1");
		span1.innerHTML=totalPrice;
		let span2=document.getElementById("total_price2");
		span2.innerHTML=totalPrice;
	}
	
	function orderChd() {
		let listCheck = document.getElementsByName("listCheck");
		let listIdCart = document.getElementsByName("listIdCart");
		let param="?id_cart=";
		for (let i=0; i<listCheck.length; i++){
			if(listCheck[i].checked) {
				if(i<listCheck.length-1) {
				param+=listIdCart[i].value+","; 
				}else if(i==listCheck.length-1) {
					param+=listIdCart[i].value;
				}
			}
		}
		document.myForm.action="${cp}/order"+param+"&id_customer=${sessionScope.id_customer}";
		document.myForm.method="post"; 
		document.myForm.submit();
	}
	
	function orderAll() {
		let listIdCart = document.getElementsByName("listIdCart");
		let param="?id_cart=";
		for (let i=0; i<listIdCart.length; i++){
			if(i<listIdCart.length-1) {
			param+=listIdCart[i].value+","; 
			}else if(i==listIdCart.length-1) {
				param+=listIdCart[i].value;
			}
		}
		document.myForm.action="${cp}/order"+param+"&id_customer=${sessionScope.id_customer}";
		document.myForm.method="post"; 
		document.myForm.submit();
	}
</script>

<main id="cart_wrapper" role="main">
	<div id="cart_container" class="container">
		<h3>장바구니</h3>
		<div id="cart_list_wrap">
			<input id="allCheck" type="checkbox" onclick="allCheck(this)"/>
			<label for="allCheck">전체선택</label>
			<table>
				<tr>
					<th style="width:600px;">상품정보</th>
					<th style="width:150px;">가격</th>
					<th style="width:150px;">수량</th>
					<th style="width:150px;">합계</th>
					<th style="width:70px;">삭제</th>
				</tr>
				<c:forEach var="vo" items="${list}" varStatus="status">
				<tr class="cart_list_tr">
					<td>
						<div class="cart_list_info flex-start">
							<div class="cart_list_info_left flex-between">
								<c:set var="list_price" value="${vo.price*vo.item_count}"/>
								<input type="hidden" name="listIdCart" 
										value="${vo.id_cart}">
								<input type="checkbox" name="listCheck" 
										value="${list_price}" onchange="calc_total(this)">
								<span>${status.count}</span>
								<img src="${cp}/img_cover/${vo.id_item}.jpg" class="cart_img_cover">
							</div>
							<div class="span_wrap">
								<a href="${cp}/detail?id_item=${vo.id_item}"><span>${vo.title}</span><br>
								<span>(ISBN: </span>
								<span class="idItemSpan">${vo.id_item})</span></a>
							</div>
						</div>
					</td>
					<td>
						<p><span>${vo.price}&nbsp;</span>원</p>
					</td>
					<td>
						<form action="${cp}/cartEdit">
							<input type="number" value="${vo.item_count}" id="item_count" name="item_count" min="1" max="${vo.stock}">
							<br>
							<span> (재고수량 ${vo.stock}) </span>
							<br> 
							<input type="hidden" value="${vo.id_item}" name="id_item">
							<input type="submit" value="변경">
						</form>
					</td>
					<td><c:out value="${list_price}"/> 원</td>
					<td>
						<form action="${cp}/cartDelete">
							<input type="hidden" value="${vo.id_item}" name="id_item">
							<input type="submit" value="삭제">
						</form>
					</td>
				</tr>
				</c:forEach>
			</table>
			<table id="table2">
				<tr>
					<th style="width:410px;">총 상품가격</th>
					<th style="width:300px;">배송비</th>
					<th style="width:410px;">결제 예정금액</th>
				</tr>
				<tr>
					<th>
						<p><span id="total_price1">0</span> 원</p>
					</th>
					<th>
						<p><span>0</span> 원</p>
					</th>
					<th>
						<p><span id="total_price2">0</span> 원</p>
					</th>
				</tr>
			</table>
			<div class="order_btn_wrap" class="flex-between">
				<form name="myForm">
					<input type="submit" value="선택한 상품 주문하기" class="order_btn"  onclick="orderChd()">
					<input type="submit" value="전체 상품 주문하기" class="order_btn"  onclick="orderAll()">
				</form>
			</div>
		</div>	
	</div>
</main>



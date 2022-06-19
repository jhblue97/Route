function logout(){
	if(confirm("로그아웃하시겠습니까?")){
		location.href="/logout.jsp";
	}
	
}

function delMemberChk(){
	//회원 탈퇴 의사를 확인하고 
	//탈퇴의 경우 deleteMember.jsp 로 보내기
	
}

function addMemberChk(){
// 비밀번호 일치 여부 확인

if($('#pw').val()!=$('#pw2').val()){
	
	alert('비밀번호가 일치하지 않습니다.');
	return false;
}
	alert('chk!');
	return false;
	
// 이메일 합치기	
	
// 	
}

function removeConfirm(pid){
	if(confirm("상품을 삭제 하시겠습니까?")){
		//product 폴더의 productRemoveProc.jsp로 상품아이디 전달
		location.href="/product/productRemoveProc.jsp?pid="+pid;
	}
}


function addToCart(){
	
	if(confirm("장바구니에 추가하시겠습니까?")){	
			
			$('form').submit();			
	}
}
/*function checkProduct(){
	
	//상품명 : 4자~20자 (특수문자는 _ - 가능)
	//상품가격 : 숫자만 가능, 소수점 둘째 자리까지
	// 재고수 : 숫자만 가능
	
	var pnameReg = /^[\w|가-힣|\-| ]{4,20}$/; // 상품명 : 4자~20자
	 
	var priceReg = /\d/; //상품 가격 : 숫자만 가능 
	 
	var priceRegPoint = /^\d+(?:[.]?[\d]?[\d])?$/; // 소수점 둘째 
	
	var stockReg = /\d/; //재고수 : 숫자만 가능
	
	console.log('checkProduct()');
	
	if(!pnameReg.test($('#pname').val())){
		alert('[상품명]은 4~20자 이내로 입력해주세요. \n  특수문자는 _,-, 공백만 가능');
		$('#pname').focus();
	}
	
	

	
	if(!priceReg.test($('#price').val())){
		alert('[상품가격] \n 숫자로 입력해주세요.');
		$('#price').focus();
	}else if ($('#price').val()<0){ // 음수 확인 
		 alert('[상품 가격] \n 양수로 입력해주세요.');
		$('#price').focus();
	} else if (!priceRegPoint.test($('#price').val())){
		 alert('[상품 가격] \n 소수점 둘째자리까지만 입력해주세요.');
		$('#price').focus();
	} 		//자릿수 확인
	 
		
	if(!stockReg.test($('#stock').val())){
		alert('[재고수] \n 숫자로 입력해주세요.');
		$('#stock').focus();
	}
	
	$('form').submit(); //폼 데이터 전송
	
	
}  */


function checkUser(){
	if($('#idCheck').val() == 'N'){
		
		alert('IDの重複チェックを確認してください。');
		return;
	}
	if($('#nickname').val()  == ''){
		
		alert('ニックネームを確認してください。');
		return;
	}
		if($('#email').val()  == ''){
		
		alert('emailを確認してください。');
		return;
	}
	
			if($('#phone').val()  == ''){
		
		alert('phoneを確認してください。');
		return;
	}
	
		
	$('#boardWrite').submit(); //폼 데이터 전송
}
<?php

$response = array();
$con = mysqli_connect('localhost:3306', 'root', 'fanelesibonge','triple8') or die(mysqli_error($con));

$_POST = json_decode(file_get_contents('php://input'), true);
if(isset($_POST['name']) && isset($_POST['phone'])){
	$name = $_POST['name'];
	$phone = $_POST['phone'];

	$sql = "SELECT * FROM user WHERE user_name = '$name' AND user_phone = '$phone'";
	$query = mysqli_query($con, $sql);
	$result = mysqli_fetch_array($query);

	if($result > 0){
		//found in database and there is only one entry
		$response["success"] = 1;
		$response["userName"] = $result["user_name"];
		$response["userSurname"] = $result["user_surname"];
		$response["userPhone"] = $result["user_phone"];
		$response["bankAccNum"] = $result["bank_acc_num"];
		$response["bankName"] = $result["bank_name"];
		$response["money"] = $result["money_amount"];
		$response["message"] = "Login successful.";
	}else{
		$response["success"] = 0;
		$response["message"] = "Login not successful. Register first.";
	}
}else{
	$response["success"] = 0;
	$response["message"] = "Required fields missing.";
}

echo json_encode($response);
?>
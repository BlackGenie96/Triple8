<?php

$response = array();
$con = mysqli_connect('localhost','root', 'fanelesibonge', 'triple8') or die(mysqli_error($con));

$json = file_get_contents('php://input');
$data = json_decode($json, true);

if(isset($data['name']) && isset($data['phoneNum']) && isset($data['accNum']) && isset($data['bankName'])){
	$name = $data['name'];
	$surname = $data['surname'];
	$phoneNum = $data['phoneNum'];
	$bankName = $data['bankName'];
	$accNum = $data['accNum'];

	$sql = "SELECT * FROM user WHERE user_name = '$name' AND user_phone = '$phoneNum' AND bank_acc_num = '$accNum'";
	$query = mysqli_query($con, $sql) or die(mysqli_error($con));
	$array = mysqli_fetch_array($query);
	if($array > 0){
		//found in database
		$response["success"] = 0;
		$response["message"] = "Already registered.";
		
	}else{
		//not found, insert into table
		$sql = "INSERT INTO user(user_name,user_surname,user_phone,create_time,bank_acc_num,bank_name, money) VALUES('$name','$surname', '$phoneNum', CURRENT_TIMESTAMP, '$accNum', '$bankName',0)";
		
		if(mysqli_query($con, $sql) or die(mysqli_error($con))){
			$response["success"] = 1;
			$response["message"] = "Account created successfully.";
		}else{
			$response["success"] = 0;
			$response["message"] = "Please try again.";
		}
	}
}else{
	$response["success"] = 0;
	$response["message"] = "Required fields missing.";
}

echo json_encode($response);


?>
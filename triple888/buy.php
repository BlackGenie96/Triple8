<?php
$response = array();

	$con = mysqli_connect('localhost', 'root', 'fanelesibonge', 'triple8') or die(mysqli_error($con));

	//retrieve json data
	$_POST = json_decode(file_get_contents('php://input'), true);

	if(isset($_POST['name']) && isset($_POST['phone']) && isset($_POST['bankAccNum']) && isset($_POST['tokens'])){
		//add data to variables
		$name = $_POST['name'];
		$phone = $_POST['phone'];
		$accNum = $_POST['bankAccNum'];
		$tokens = $_POST['tokens'];

		//query 
		$sql = "UPDATE user SET money_amount = money_amount + '$tokens' WHERE user_name = '$name' && user_phone = '$phone' && bank_acc_num = '$accNum'";
      		if(mysqli_query($con, $sql) or die(mysqli_error($con))){
                   
                    //retrieve all data about this user includin the updated money amoun
                    $sql = "SELECT * FROM user WHERE bank_acc_num = '$accNum' && user_phone = '$phone'";
                    $query = mysqli_query($con, $sql);
                    $array = mysqli_fetch_array($query);

                    if($query > 0){
                        //data has been retrieved successfully
                        //send back the row with the updated information
                        $response["id"] = 1;
                        $response["name"] = $array["user_name"];
                        $response["surname"] = $array["user_surname"];
                        $response["phone"] = $array["user_phone"];
                        $response["bankName"] = $array["bank_name"];
                        $response["bankAccNum"] = $array["bank_acc_num"];
                        $response["money_amount"] = $array["money_amount"];
                    }else{
                        $response["message"] .= " => Problem retrieving user data.";
                        $response["success"] = 0;
                    }
		}else{
                    $response["success"] = 0;
                    $response["message"] = "Problem buying tokens. Please try again or contact our Customer Service.";
                }
	}else{
            $response["success"] = 0;
            $response["message"] = "Required fields missing.";
        }

	echo json_encode($response);


<?php
require_once __DIR__ . '/oneEight.php';
require_once __DIR__ . '/doubleEight.php';
require_once __DIR__ . '/tripleEight.php';

$response = array();
$con = mysqli_connect("localhost", "root", "fanelesibonge", "triple8") or die(mysqli_error($con));

    $oneEight = new OneEight();
    $doubleEight = new DoubleEight();
    $tripleEight = new TripleEight();

	//Adding users to the play table in the database
    function addToPlay($con, $phone, $name, $number, $money_amount){
        $userId = getUserId($con, $phone, $name);
        $sql = "INSERT INTO play_general(user_name,user_phone,play_time,play_num, user_user_id) VALUES ('$name', '$phone',CURRENT_TIMESTAMP, '$number', '$userId')";
        $moneySql = "UPDATE user SET money_amount = '$money_amount' WHERE user_phone = '$phone'";
        mysqli_query($con, $sql);
        mysqli_query($con, $moneySql);
    }

    //function to get userId from database
    function getUserId($con, $phone, $name){
        $sql = "SELECT * FROM user WHERE user_name = '$name' AND user_phone = '$phone'";
        $query = mysqli_query($con, $sql);
        $array = mysqli_fetch_array($query);

        if($array > 0){
            $userId = $array["user_id"];
        }

        return $userId;
    }

    //function to facilitate the playing of the game
 	function play($con, OneEight $oneEight,TripleEight $tripleEight, $response, $name, $phone, $money){
        //first get the count for all three digits
 		$countOne  = $oneEight->getCount();

 		//next get the count of the users in the play table in the database
 		$sql = "SELECT * FROM play_general";
 		$query = mysqli_query($con, $sql);
 		$countOfUsers = $query->num_rows;
 		
 		switch($countOfUsers){
 			case $countOne:

 				$uno = $oneEight->getFirstNumbers();
 				$dos = $oneEight->getEight();
 				$tres = $oneEight->getOtherNumbers();

 				addToPlay($con, $phone, $name, $uno.$dos.$tres, $money);
 				
                $response["number"] = $uno.$dos.$tres;
 				$response["success"] = 1;
 				$response["message"] = "You have won: \nE 200.00";

 				echo json_encode($response);
 				break;
 			default:

 				$aaa = $oneEight->getFirstNumbers();
 				$bbb = $tripleEight->getSecondNumbers();
 				$ccc = $tripleEight->getThirdNumbers();

 				$response["success"] = 1;
 				$response["number"] = $aaa.$bbb.$ccc;
 				$response["message"] = "Not winner. Try again.";

                addToPlay($con, $phone, $name, $aaa.$bbb.$ccc, $money);
 				
                echo json_encode($response);

 				break;

 		}
 	}


    //get json input stream
    $_POST = json_decode(file_get_contents('php://input'),true);

    /*
    $_POST['play'] = "1";
    $_POST['name'] = "Phiwo";
    $_POST['phone'] = "79990188";
    $_POST['money'] = 1500;
    */
    
    //program starts running here
    if(isset($_POST['play']) && isset($_POST['name']) && isset($_POST['phone']) && isset($_POST['money'])){
        $name = $_POST['name'];
        $phone = $_POST['phone'];
        $money = $_POST['money'];

        play($con, $oneEight,$tripleEight,$response, $name, $phone, $money);
    }else{
        $response["success"] = 0;
        $response["message"] = "Required fields missing.";

        echo json_encode($response);
    }
?>
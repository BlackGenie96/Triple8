<?php

	/*	

		File 		: getUserPlays.php
		Created on 	: 11 Jan 2020, 06:00 a.m.
		author 		: Fanelesibonge Malaza

		Description : This script gets all the entries where a user with [userName,userSurname, phone, 
		bankName, accNum] and sends the results back as a response. The data will first be confirmed with 
		user table, then using the foreign key to maintain integrity, get the rest of the data from all
		the other tables. This data is then sorted using the date and time, the most recent entry being the
		first in the user activity list on the flutter application.

	*/

	/**************************************************************************
	 *						Variable declarations
	 *************************************************************************/
	$response = array();
	$list = array();
	$con = mysqli_connect("localhost","root", "fanelesibonge", "triple8") or die(mysqli_error($con));

	//get input from the flutter app in json format
	$_POST = json_decode(file_get_contents('php://input'), true);

	/*$_POST['name'] = "Phiwo";
	$_POST['surname'] = "Malaza";
	$_POST['phone'] = "79990188";
	$_POST['bankAccNum'] = "60277218767877";
	$_POST['bankName'] = "Fnb";
	$_POST['money'] =  174;
	/**************************************************************************
	 *						Program starts here
	 *************************************************************************/

	if(isset($_POST['name']) && isset($_POST['surname']) && isset($_POST['phone']) && isset($_POST['bankAccNum']) && isset($_POST['money'])){
		$name = $_POST['name'];
		$surname = $_POST['surname'];
		$phone = $_POST['phone'];
		$bankAccNum = $_POST['bankAccNum'];
		$money = $_POST['money'];

		checkUserRegistration($name, $surname, $phone, $bankAccNum, $money);
		$found = $response["found"];
		if($found == true){
			//user was found in the database
			//get the relevant lists for the different categories for this user.
			getPlayGeneral();
			getPlayPremium();
			getPlayGold();

			//the plays have been retrieved. Echo the json response
		}else{
			//user registration has problems 
			//Administrator should check any registration issues with the user.
			$response["success"] = 0;
			$response["message"] = "Something here.";
		}
	}else{
		$response["success"] = 0;
		$response["message"] = "Required fields missing.";
	}

	echo json_encode($list);

	/**************************************************************************
	 *						Function definitions
	 **************************************************************************/

	//Function checkUserRegistration checks if the registration information from the application aligns with the data in the database
	function checkUserRegistration($username, $userSurname, $phone, $bankAccNum, $money){
		//global variables
		global $con;
		global $response;
		//query
		$sql = "SELECT * FROM user WHERE user_name = '$username' AND user_surname = '$userSurname' AND user_phone = '$phone' AND bank_acc_num = '$bankAccNum' AND money_amount = '$money'";
		$query = mysqli_query($con, $sql) or die(mysqli_error($con));
		$array = mysqli_fetch_array($query);

		if($array > 0){
			$response["found"] = true;
			$response["userId"] = $array["user_id"];
			$response["userName"] = $array["user_name"];
			$response["userSurname"] = $array["user_surname"];
			$response["userPhone"] = $array["user_phone"];
			$response["bankName"] = $array["bank_name"];
			$response["bankAccNum"] = $array["bank_acc_num"];
			$response["money"] = $array["money_amount"];
		}else{
			$response["found"] = false;
			$response["success"] = 0;
			$response["message"] = "User could not be confirmed in the database.";
		}
	}        

	//Function getPlayGeneral gets a list of entries the user played under the general category
	//Cost : E 2.00
	function getPlayGeneral(){
		//global variables
		global $con;
		global $response;
		global $list;

		//initialize local variables
		$id = $response["userId"];

		//query
		$sql = "SELECT * FROM play_general WHERE user_user_id = '$id'";
		$query = mysqli_query($con, $sql) or die(mysqli_error($con));
		$array = mysqli_fetch_array($query);

		if($array > 0){
			//probably more than one entry
			do{
				//declare an array to store data and push into json $response variable
				$result = array();
				$result["playId"] = $array["general_id"];
				$result["userName"] = $array["user_name"];
				$result["userPhone"] = $array["user_phone"];
				$result["playTime"] = $array["play_time"];
				$result["playNum"] = $array["play_num"];
				$result["playCost"] = 2;

				array_push($list, $result);
			}while($array = mysqli_fetch_array($query));
		}
	}

	//Function getPlayPremium gets a list of entries the user played under the premium category
	//Cost : E 5.00
	function getPlayPremium(){
		//global variables
		global $con;
		global $response;
		global $list;

		//var declarations
		$id = $response["userId"];

		//query 
		$sql = "SELECT * FROM play_premium WHERE user_user_id = '$id'";
		$query = mysqli_query($con, $sql);
		$array = mysqli_fetch_array($query);

		if($array > 0){
			//probably more than one value
			do{
				$result = array();
				$result["playId"] = $array["premium_id"];
				$result["userName"] = $array["user_name"];
				$result["userPhone"] = $array["user_phone"];
				$result["playTime"] = $array["play_time"];
				$result["playNum"] = $array["play_num"];
				$result["playCost"] = 5;

				array_push($list, $result);
			}while($array = mysqli_fetch_array($query));
		}
	}

	//Function getPlayGold gets a list of entries the user played under the gold category
	//Cost : E 10.00
	function getPlayGold(){
		//global variables
		global $con;
		global $response;
		global $list;

		//variable declaration
		$id = $response["userId"];

		//query
		$sql = "SELECT * FROM play_gold WHERE user_user_id = '$id'";
		$query = mysqli_query($con, $sql);
		$array = mysqli_fetch_array($query);

		if($array > 0){
			do{
				$result = array();
				$result["playId"] = $array["gold_id"];
				$result["userName"] = $array["user_name"];
				$result["userPhone"] = $array["user_phone"];
				$result["playTime"] = $array["play_time"];
				$result["playNum"] = $array["play_num"];
				$result["playCost"] = 10;

				array_push($list, $result);
			}while($array = mysqli_fetch_array($query));
		}
	}

?>
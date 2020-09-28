<?php

class TripleEight{
	
	private $number;

	public function __construct(){
		$this->number = 0;
	}
	
	private function setCount(){
		$this->number = 30;//125000;
	}

	public function getCount(){
		$this->setCount();
		return $this->number;
	}

	public function getTrippleEight(){
		$found = false;

		do{
			$result = mt_rand(111,999);
			$sResult = "{$result}";
			if(preg_match("/^888/", $sResult) or preg_match("/888$/", $sResult)){
                    $found = true;
                    return $sResult;
                }
		}while($found != true);
	}

	public function getOtherNumbers(){
		do{

			$found = false;
            $result = mt_rand(1111,9999);
            $sResult = "{$result}";
            
            if(preg_match("/\d8\d/", $sResult)){
                $found = false;
            }elseif(preg_match("/8$/", $sResult)){
            
                $found = false;
            }elseif(preg_match("/^8/", $sResult)){
                $found = false;
            }else{
                $found = true;
                return $sResult;
            }	
        }while($found != true);
	}

	public function getThirdNumbers(){
		do{

			$found = false;
            $result = mt_rand(111,999);
            $sResult = "{$result}";
            
            if(preg_match("/\d8\d/", $sResult)){
                $found = false;
            }elseif(preg_match("/8$/", $sResult)){
            
                $found = false;
            }elseif(preg_match("/^8/", $sResult)){
                $found = false;
            }else{
                $found = true;
                return $sResult;
            }	
        }while($found != true);
	}

	public function getSecondNumbers(){
		do{

			$found = false;
            $result = mt_rand(11,99);
            $sResult = "{$result}";
            
            if(preg_match("/\d8\d/", $sResult)){
                $found = false;
            }elseif(preg_match("/8$/", $sResult)){
            
                $found = false;
            }elseif(preg_match("/^8/", $sResult)){
                $found = false;
            }else{
                $found = true;
                return $sResult;
            }	
        }while($found != true);
	}
}

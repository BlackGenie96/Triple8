<?php

class OneEight{

	private $number;

	function __construct(){
		$this->number = 0;
	}

	//this means the count can only be set in the constructor
	private function setCount(){
		$this->number = 47;		//after 400 people have played,a number with one 8 appears 
	}

	public function getCount(){
		$this->setCount();
		return $this->number;
	}

	public function getEight(){
		
		do{
			$found = false;
			$result = mt_rand(1,9);
        	$sResult = "{$result}";
			if(preg_match("/^8/", $sResult) or preg_match("/8$/", $sResult)){
           		$found = true;
        		return $sResult;
        	}else if(preg_match("/88$/", $sResult) or preg_match("/^88/", $sResult)){
        		$found = false;
        	}
		}while($found != true);
	}

	public function getFirstNumbers(){
		do{

			$found = false;
            $result = mt_rand(11111,99999);
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
}

?>
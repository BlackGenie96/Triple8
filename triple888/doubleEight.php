<?php

class DoubleEight{

	private $number;

	public function __construct(){
		$this->number = 0;
	}

	private function setCount(){
		$this->number = 32;//5000;
	}

	public function getCount(){

		$this->setCount();
		return $this->number;
	}

	public function getDoubleEight(){
		$found = false;
		do{
			$result = mt_rand(11,99);
            $sResult = "{$result}";
			if(preg_match("/^88/", $sResult) or preg_match("/88$/", $sResult)){
                    $found = true;
                    $doubleEight = new DoubleEight();
                    return $sResult;

                }elseif(preg_match("/(\d)*8(\d)*8/", $sResult)){
                    $found = false;
                }	
		}while( $found != true);
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
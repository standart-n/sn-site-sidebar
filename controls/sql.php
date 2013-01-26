<?php class sql extends sn {
	
public static $request;

function __construct() {

}

public static function claims($s="") {
	$s.="select * from `standart_dataClaims` where (1=1) order by post_dt desc limit ".app::$skip.",".app::$limit." ";
	self::$request=$s;
	return $s;
}

public static function pagination($s="") {
	$s.="select COUNT(*) as count_id from `standart_dataClaims` where (1=1) order by post_dt desc ";
	self::$request=$s;
	return $s;
}

public static function edit($s="") {
	$s.="update `standart_dataClaims` SET `status`='".iconv("UTF-8","cp1251",url::$message)."' where (id=".url::$id.") ";
	self::$request=$s;
	return $s;
}

} ?>

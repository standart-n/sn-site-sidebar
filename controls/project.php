<?php class project extends sn {

function __construct() {
	session_start();
}

public static function engine() {
	//if (signin::check()) {
		load("index.tpl");
		// assign('pagination',app::pagination());
		// assign('prev',app::$prev);
		// assign('next',app::$next);
		// assign('page',app::$page);
		// innerHTML("#pagination",fetch("pagination.tpl"));
		// assign('claims',app::claims());
		// innerHTML("#claims",fetch("claims.tpl"));
		//echo sql::$request;
		echo html();
	// } else {
	// 	load("index.tpl");
	// 	innerHTML("#signin",fetch("signin.tpl"));
	// 	//echo sql::$request;
	// 	echo html();
	// }
}	

public static function signin($j=array()) {
	if (signin::check()) {
		$j['response']=true;
		//$j['key']=signin::$key;
		// assign('pagination',app::pagination());
		// assign('prev',app::$prev);
		// assign('next',app::$next);
		// assign('page',app::$page);
		// $j['pagination']=fetch("pagination.tpl");
		// assign('claims',app::claims());
		// $j['claims']=fetch("claims.tpl");
	} else {
		$j['response']=false;
	}
	$j['callback']="afterSignin";
	return $j;
}

public static function edit($j=array()) {
	if (signin::check()) {
		app::edit();
		//claims::getDataFromUrl();
		//$j['alert']=sql::$request;
		$j['response']=true;
	} else {
		$j['response']=false;
	}
	return $j;
}

} ?>

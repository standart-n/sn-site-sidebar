<?php class project extends sn {

function __construct() {
	session_start();
}

public static function engine() {
	//if (signin::check()) {
		load("index.html");
		// assign('pagination',app::pagination());
		// assign('prev',app::$prev);
		// assign('next',app::$next);
		// assign('page',app::$page);
		// innerHTML("#pagination",fetch("pagination.html"));
		// assign('claims',app::claims());
		// innerHTML("#claims",fetch("claims.html"));
		//echo sql::$request;
		echo html();
	// } else {
	// 	load("index.html");
	// 	innerHTML("#signin",fetch("signin.html"));
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
		// $j['pagination']=fetch("pagination.html");
		// assign('claims',app::claims());
		// $j['claims']=fetch("claims.html");
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

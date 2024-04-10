
<?php

/*
Secure Email Function by Juan Karlo Aquino de Guzman
Website: http://www.karlo.ph.tc and http://www.abs-cbn.ph.tc
E-mail: http://www.karlo.ph.tc/send.php

Usage: showEmail("support@microsoft.com",0); OR showEmail("support@microsoft.com",1); <-- example
Types:
0 = ordinary random
1 = more secure random

To include to a script:

include_once("email_secure.php");
*/

function showEmail($email,$type) {
if(!strstr($email,"@") || !strstr($email,".")) {
echo("<div align=\"center\" style=\"font-family: Verdana; font-size: 12px; font-weight: bold; color: white; background-color: black; padding: 4px;\">Your e-mail is invalid!</div>");
}else {
$email_split=split("@",$email);
if($type===0) {
$random1=str_shuffle(strtolower(metaphone(sha1(mt_rand(11111,99999)))));
$random2=str_shuffle(strtolower(metaphone(sha1(mt_rand(11111,99999)))));
$randomAT=str_shuffle(str_shuffle($random1).str_shuffle($random2));
}else {
$random1=str_shuffle(strtolower(metaphone(uniqid(md5(mt_rand(11111,99999))))));
$random2=str_shuffle(strtolower(metaphone(uniqid(md5(mt_rand(11111,99999))))));
$randomAT=str_shuffle(str_shuffle($random1).str_shuffle($random2));
}

$atSign=rawurlencode("@");
$first=rawurlencode($email_split[0]);
$second=rawurlencode($email_split[1]);
echo "&lt;script language=\"javascript\" type=\"text/javascript\"><!--\nvar $random1=unescape('$first');var $random2=unescape('$second');var $randomAT=unescape('$atSign');document.write($random1+$randomAT+$random2);\n//--></script>";
}
}

?>

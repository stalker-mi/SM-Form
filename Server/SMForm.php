<?

mysql_connect("localhost" , "lesnajapol_stdnt" , "stdnt123" )OR DIE ("Не могу создать соединение"); 
mysql_select_db("lesnajapol_stdnt") or die(mysql_error()); 
mysql_set_charset("utf8");


if(isset($_GET['input'])){

echo '<form name="loginform" action="SMForm.php?login" method="post">
			<p>Логин<br /><input type="text" name="login" value="" size="25" /></p>
			<p>Пароль<br /> <input type="password" name="password" value="" size="25" /></p>
			<input type="submit" name="submit" value="Войти &raquo;" />
		</form>';


}

if(isset($_GET['login'])){
	
	$eroor=false;
	$login=$_POST['login']; 
	$password=$_POST['password'];

	if($login=="") {
		echo "Ошибка логина\n";
		$eroor=true;
	}

	if($password=="") {
		echo "Ошибка пароля\n";
		$eroor=true;
	}
	
	if(!$error){
		$password=md5($password);
		$q = "SELECT * FROM SMForm_users WHERE login='$login' AND password='$password'";
		$r =mysql_query($q) or die(mysql_error()); 
		$o = mysql_fetch_array($r);
		if($o['id']){
			echo "Вы вошли как ".$login."\n";
			echo "Здравствуйте ".$o['name']." ".$o['surname']."\n";
			echo "Ваш пол ";
			if($o['sex']=="m") echo "мужской\n"; else echo "женский\n";
			echo "e-mail:".$o['email']."\n";
		}
		else{
			echo "Неверный логин или пароль\n";
		}
	}


}


if(isset($_GET['reg'])){
	$eroor=false;
	$name=$_POST['name'];
	$surname=$_POST['surname'];
	$sex=$_POST['sex'];
	$email=$_POST['email'];
	$login=$_POST['login']; 
	$password=$_POST['password'];

	if($name=="" || !preg_match ("/^[а-яА-ЯёЁa-zA-Z0-9]/", $name)) {
		echo "Ошибка имени\n";
		$eroor=true;
	}

	if($surname=="" || !preg_match ("/^[а-яА-ЯёЁa-zA-Z0-9]{2,}$/", $surname)) {
		echo "Ошибка фамилии\n";
		$eroor=true;
	}
	if($sex=="" || preg_match ("/^[mj]$/", $sex)) {
		echo "Ошибка пола\n";
		$eroor=true;
	}
	if($email=="" || !preg_match ("/^(\S+)@([a-z0-9-]+)(\.)([a-z]{2,4})(\.?)([a-z]{0,4})+$/", $email)) {
		echo "Ошибка email\n";
		$eroor=true;
	}
	if($login=="" || !preg_match ("/^[a-zA-Z][a-zA-Z0-9-_\.]{1,10}$/", $login)) {
		echo "Ошибка логина\n";
		$eroor=true;
	}
	if($password=="" || !preg_match ("/^[a-zA-Z0-9-_*.#%$!&@]{5,}$/", $password)) {
		echo "Ошибка пароля\n";
		$eroor=true;
	}

	$q = "SELECT id FROM SMForm_users WHERE login='$login'";
	$r =mysql_query($q) or die(mysql_error()); 
	$o = mysql_fetch_array($r);
	if($o['id']) {
		$eroor=true;
		echo "Пользователь с таким логином уже существует\n";
	}

	$q = "SELECT id FROM SMForm_users WHERE email='$email'";
	$r =mysql_query($q) or die(mysql_error()); 
	$o = mysql_fetch_array($r);
	if($o['id']) {
		$eroor=true;
		echo "Пользователь с таким email уже существует\n";
	}

	if(!$error){
	$password=md5($password);
	$q = "INSERT INTO SMForm_users (name,surname,sex,email,login,password) VALUES('$name','$surname','$sex','$email','$login','$password')";
	$r =mysql_query($q) or die(mysql_error()); 
	if($r) echo "Данные успешно добавлены";
	}
}


?>
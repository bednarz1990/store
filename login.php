<?php
include "db.php";

session_start();

# skrypt logujacy usera
if(isset($_POST["email"]) && isset($_POST["password"])){
	$email = mysqli_real_escape_string($con,$_POST["email"]);
	$password = md5($_POST["password"]);
	$sql = "SELECT * FROM user_info WHERE email = '$email' AND password = '$password'";
	$run_query = mysqli_query($con,$sql);
	$count = mysqli_num_rows($run_query);
	// jesli rekord jest juz na bazie wtedy zwroci 1
 	if($count == 1){
		$row = mysqli_fetch_array($run_query);
		$_SESSION["uid"] = $row["user_id"];
		$_SESSION["name"] = $row["first_name"];
		$ip_add = getenv("REMOTE_ADDR");
		// stworzony cookkie na logi form.php tzn ze user jest niezalogowany
 			if (isset($_COOKIE["product_list"])) {
				$p_list = stripcslashes($_COOKIE["product_list"]);
				// dekoding z cookiesa do listy
				$product_list = json_decode($p_list,true);
				for ($i=0; $i < count($product_list); $i++) { 
					//sprawdzenie czy produkt jest dodany do zamowienia	
					$verify_cart = "SELECT id FROM cart WHERE user_id = $_SESSION[uid] AND p_id = ".$product_list[$i];
					$result  = mysqli_query($con,$verify_cart);
					if(mysqli_num_rows($result) < 1){
						// jesli uzytkownik dodaje 1 raz produkt to robimy update w bazie z poprawnym ID
 						$update_cart = "UPDATE cart SET user_id = '$_SESSION[uid]' WHERE ip_add = '$ip_add' AND user_id = -1";
						mysqli_query($con,$update_cart);
					}else{
						//jesli produkt jest dostepny w bazie to go usuwamy
 						$delete_existing_product = "DELETE FROM cart WHERE user_id = -1 AND ip_add = '$ip_add' AND p_id = ".$product_list[$i];
						mysqli_query($con,$delete_existing_product);
					}
				}
				//usuwanie cookiesa uzytkownika
				setcookie("product_list","",strtotime("-1 day"),"/");
				// jesli user loguje sie z koszyka to wysylamy go do logowania cart login
 				echo "cart_login";
				exit();
				
			}
			//jesli user sie zaloguje to wrzucamy komunikat z sukcesem
 			echo "login_success";
			exit();
		}else{
			echo "<span style='color:red;'>Login lub hasło jest nieprawidłowy</span>";
			exit();
		}
	
}

?>
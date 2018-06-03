<?php

//fetch_comment.php

$connect = new PDO('mysql:host=localhost;dbname=ecom', 'root', '');

$product_id = '';
$product_id = (int)$_POST["produktId"];
if(empty($_POST["produktId"]))
{
$error .= '<p class="text-danger">Produkt jest niewłaściwy</p>';
}
else
{
$product_id = (int)$_POST["produktId"];

}

$query = "
SELECT * FROM tbl_comment 
WHERE parent_comment_id = '0' AND product_id = '".$product_id."'
ORDER BY comment_id DESC 
";

$statement = $connect->prepare($query);

$statement->execute();

$result = $statement->fetchAll();
$output = '';
foreach($result as $row)
{
 $output .= '
 <div class="panel panel-default">
  <div class="panel-heading">Przez <b>'.$row["comment_sender_name"].'</b>  <i>'.$row["date"].'</i></div>
  <div class="panel-body">'.$row["comment"].'</div>
  <div class="panel-footer" align="right"><button type="button" class="btn btn-default reply" id="'.$row["comment_id"].'">Odpowiedź</button></div>
 </div>
 ';
 $output .= get_reply_comment($connect, $row["comment_id"], 0, $product_id);
}

echo $output;

function get_reply_comment($connect, $parent_id = 0, $marginleft = 0, $product_id )
{
 $query = "
 SELECT * FROM tbl_comment WHERE parent_comment_id = '".$parent_id."' AND product_id = '".$product_id."'
 ";
 $output = '';
 $statement = $connect->prepare($query);
 $statement->execute();
 $result = $statement->fetchAll();
 $count = $statement->rowCount();
 if($parent_id == 0)
 {
  $marginleft = 0;
 }
 else
 {
  $marginleft = $marginleft + 48;
 }
 if($count > 0)
 {
  foreach($result as $row)
  {
   $output .= '
   <div class="panel panel-default" style="margin-left:'.$marginleft.'px">
    <div class="panel-heading">Przez <b>'.$row["comment_sender_name"].'</b> on <i>'.$row["date"].'</i></div>
    <div class="panel-body">'.$row["comment"].'</div>
    <div class="panel-footer" align="right"><button type="button" class="btn btn-default reply" id="'.$row["comment_id"].'">Odpowiedź</button></div>
   </div>
   ';
   $output .= get_reply_comment($connect, $row["comment_id"], $marginleft, $product_id );
  }
 }
 return $output;
}

?>
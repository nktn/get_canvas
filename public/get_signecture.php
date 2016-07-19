<?php
//canvasデータがPOSTで送信されてきた場合
$canvas = $_POST["acceptImage"];

//ヘッダに「data:image/png;base64,」が付いているので、それは外す
$canvas = preg_replace("/data:[^,]+,/i","",$canvas);

//残りのデータはbase64エンコードされているので、デコードする
$canvas = base64_decode($canvas);

//まだ文字列の状態なので、画像リソース化
$image = imagecreatefromstring($canvas);

//画像として保存（ディレクトリは任意）
imagesavealpha($image, TRUE);
$now = date("YmdHis");
imagepng($image, '/tmp/'.$now.'.png');
?>

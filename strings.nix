{
  logotxt = builtins.toFile "logo.txt" ''
    $1  \\  $2\\ //
    $1 ==\\__$2\\/ $1//
    $2   //   $2\\$1//
    $2==//     $1//==
    $2 //$1\\$2___$1//
    $2// $1/\\  $2\\==
      $1// \\  $2\\
  '';
}
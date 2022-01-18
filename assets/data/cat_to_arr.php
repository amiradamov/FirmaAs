<?php
$filedata = file_get_contents('all_prod.json');
$details = json_decode($filedata);
$n_group = array_column($details, 'GROUP_NAME');
print_r($n_group);
$n = "";
foreach ($n_group as $n_grou) {
    if($n_grou != $n){
        print_r("'$n_grou'".", ");
    }
    $n = $n_grou;
}
?>
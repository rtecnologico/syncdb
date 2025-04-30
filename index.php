<?php 

			$host = "localhost";
			$username = "root";
			$password = "";
			$database = "devbd";
			

/* Você deve ativar o relatório de erros para mysqli antes de tentar fazer uma conexão */
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

$mysqli = mysqli_connect('localhost', 'root', '', 'syncdb');

/* Defina o conjunto de caracteres desejado após estabelecer uma conexão */
mysqli_set_charset($mysqli, 'utf8mb4');

printf("Success... %s\n", mysqli_get_host_info($mysqli));

		$sql_bancos = "SELECT * FROM `bancos`";
		$sql_bancos_resp = $mysqli->query($sql_bancos);
		
		$sql_tabelas = "SELECT * FROM tabelas";
		$sql_tabelas_resp = $mysqli->query($sql_tabelas);
		$array_tabelas = array();
		$array_tabelas_nomes = array();
				if ($sql_tabelas_resp && $sql_tabelas_resp->num_rows > 0) {
					$tabela_up = true;
					//$tabelas = $sql_tabelas_resp->fetch_assoc();
						while ($row = $sql_tabelas_resp->fetch_assoc()) {
							array_push($array_tabelas,$row['id']);
							array_push($array_tabelas_nomes,$row['nome']);
						}
						
				}
				
        if ($sql_bancos_resp && $sql_bancos_resp->num_rows > 0) {
			while ($row = $sql_bancos_resp->fetch_assoc()) {

			$host = $row['local'];
			$username = $row['login'];
			$password = $row['senha'];
			$database = $row['nome'];
			
            $conn_db = new mysqli($host, $username, $password, $database);
            $conn_db->set_charset("utf8mb4");
            if (!$conn_db) {
                echo 'Cannot connect to database server '.$database;
                exit;
            }else{
							
				if ($tabela_up == true) {

					for ($i = 0; $i < count($array_tabelas); $i++) {

						$id_tabela = $array_tabelas[$i];
						$nome_tabela = $array_tabelas_nomes[$i];
						
						$sql_campos = "SELECT * FROM `campos` WHERE tabela = $id_tabela";
						$sql_campos_resp = $mysqli->query($sql_campos);
						$campos_cons = "";
						
						$sql_if_table = "SHOW TABLES LIKE '$nome_tabela'";
						$exec_consul = $conn_db->query($sql_if_table);
							if($exec_consul->num_rows == 0){
								
						if($sql_campos_resp->num_rows > 0){
							while ($row = $sql_campos_resp->fetch_assoc()) {
								
								if($row['nome']){
									$nome_campo = $row['nome'];
								}
													$tipo_temp = "";
								if($row['tipo'] == "TEXT"){
									$tipo_campo = $row['tipo'];
									$valor_campo = "65.535";
									$tipo_temp = $tipo_campo." ";
									$tipo_campo = $tipo_temp;
								}else{
									$tipo_campo = $row['tipo'];
									$valor_campo = $row['valor'];									
									$tipo_temp = $tipo_campo."(".$valor_campo.")";
									$tipo_campo = $tipo_temp;									
								}
																
								if($row['autoincrement'] && $row['autoincrement'] == 1){
									$autoincrement = "AUTO_INCREMENT";
								}else{
									$autoincrement = "";
								}
								
								if($row['primarydb'] && $row['primarydb'] == 1){
									$primarydb = ", PRIMARY KEY ($nome_campo)";
								}else{
									$primarydb = "";
								}
								
								if($row['nulo'] && $row['nulo'] == 1){
									$nulo = "DEFAULT NULL";
								}else{
									$nulo = "NOT NULL";
								}
								
								$campos_cons .= $nome_campo." ".$tipo_campo." ".$nulo." ".$autoincrement.",";
														
								}						
							
								$xy = strlen($campos_cons) - 1;
								$campos_cons = substr($campos_cons,0,$xy);
								$campos_cons = $campos_cons." ".$primarydb;

									$sql_create = "CREATE TABLE IF NOT EXISTS ".$nome_tabela." (".$campos_cons.") DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;";
									echo $sql_create;						
									$conn_db->query($sql_create);

								}
							}else{

								$result = $conn_db->query("SELECT * FROM $nome_tabela");
								if (!$result) {
									die('Query failed: ' . mysql_error());
								}
								$array_campos_existe = array();
								/* Get field information for all columns */
								while ($finfo = $result->fetch_field()) {
									array_push($array_campos_existe,$finfo->name);
								}
							
								while ($row = $sql_campos_resp->fetch_assoc()) {
								
								if($row['nome']){
									$nome_campo = $row['nome'];
								}
								if(!in_array($nome_campo,$array_campos_existe)){
									$tipo_temp = "";
								if($row['tipo'] == "TEXT"){
									$tipo_campo = $row['tipo'];
									$valor_campo = "65.535";
									$tipo_temp = $tipo_campo." ";
									$tipo_campo = $tipo_temp;
								}else{
									$tipo_campo = $row['tipo'];
									$valor_campo = $row['valor'];									
									$tipo_temp = $tipo_campo."(".$valor_campo.")";
									$tipo_campo = $tipo_temp;
									}
																
								if($row['autoincrement'] && $row['autoincrement'] == 1){
									$autoincrement = "ALTER TABLE $nome_tabela MODIFY `id` int NOT NULL AUTO_INCREMENT";
								}else{
									$autoincrement = "";
								}
								
								if($row['primarydb'] && $row['primarydb'] == 1){
									$primarydb = ", PRIMARY KEY ($nome_campo)";
								}else{
									$primarydb = "";
								}
								
								if($row['nulo'] && $row['nulo'] == 1){
									$nulo = "DEFAULT NULL";
								}else{
									$nulo = "NOT NULL";
								}

								$campos_cons .= "ADD ".$nome_campo." ".$tipo_campo." ".$nulo.",";
								}
								
							}
								$xy = strlen($campos_cons) - 1;
								$campos_cons = substr($campos_cons,0,$xy);
								
								echo "ALTER TABLE $nome_tabela $campos_cons ";
								$conn_db->query("ALTER TABLE $nome_tabela $campos_cons ");
								
								//$conn_db->query("ALTER TABLE $nome_tabela ADD PRIMARY KEY (`id`)");
								
								$result->close();
								
						}
					
					}
				}
			}
			

			}
		}

?>


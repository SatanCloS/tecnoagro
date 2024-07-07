<!DOCTYPE html>
<html>
<head>
	<title></title>
	

</head>
<body>

	<label for="selectOption">Selecciona una opción:</label>
	
	<select class="select2" id="selectOption">
		<option value="opcion1">Opción 1</option>
		<option value="opcion2">Opción 2</option>
		<option value="opcion3">Opción 3</option>
	</select>

</body>
</html>

<script>
	$(document).ready(function () {
		$('.select2').select2();
	});
</script>
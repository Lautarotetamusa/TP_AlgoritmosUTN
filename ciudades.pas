{$INCLUDE clientes}

// ---------------------------------------------------- //
// Busca si el codigo de la ciudad existe en el archivo //
// ---------------------------------------------------- //


// ----------------------------------------------
// Ordena las ciudades por codigo de menor a mayor
// Ordenamiento O(n^2)
// ----------------------------------------------
procedure OrdenarCiudades();
VAR
	i, j, n : integer;
	a, b, aux : ciudad;
BEGIN

	n := filesize(ciudades);
	for i:= 0 to n do
	begin
		for j := i+1 to n-1 do
		begin
			seek(ciudades, i);
			read(ciudades, a);

			seek(ciudades, j);
			read(ciudades, b);

			if a.COD_ciudad > b.COD_ciudad then
			// cambiar
			begin
				aux := a;
				a := b;
				b := aux;

				seek(ciudades, i);
				write(ciudades, a);

				seek(ciudades, j);
				write(ciudades, b);
			end;
		end;
	end;
END;

procedure ShowCiudad(a : ciudad);
begin
	writeln(' COD: ', a.COD_ciudad);
	writeln(' Nombre: ', a.nombre);
end;


// -----------------------------------------------
// Ingresa las ciudades en el archivo ciudades.dat
// COD_ciudad se guarda como un string[3]
//     no importa como lo ingreses
// Verifica que la ciudad no este ya guardada
// -----------------------------------------------
procedure AltaCiudades();
VAR
	confirmacion : char;
	_ciudad : ciudad;
	//!cod_ciudad : string;
	i : integer;
BEGIN
		assign(ciudades, 'data/ciudades.dat');
		reset(ciudades);

		//posicionarse al final del archivo
		i := filesize(ciudades);
		repeat
			Cartel('CIUDADES');

		  writeln('Desea Ingresar una ciudad (s o n): ');
			readln(confirmacion);
			if UpperCase(confirmacion) = 'S' then
			begin
				// Ingreso COD ciudad //
				_ciudad.COD_ciudad := IngresoCOD('CIUDADES', 'ciudad', true);
				// ---------------------------

				//  Ingreso Nombre  //
				Cartel('CIUDADES');
				write(' Nombre ciudad: '); readln(_ciudad.nombre);
				// ------------ //
				
				//!Sacar esto antes de subir
				Cartel('CIUDADES');
				write(' consultas: '); readln(_ciudad.consultas);

				// Guardar en archivo //
				seek(ciudades, i);
				write(ciudades, _ciudad);
				i := i+1;
				// ----------------- //

				writeln(' Ciudad ingresada correctamente, presione para continuar');
				ShowCiudad(_ciudad);
				readln();
			end;
		until (UpperCase(confirmacion) = 'N');
		OrdenarCiudades();
		close(ciudades);
		menuEmpresas();
END;

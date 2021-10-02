{$INCLUDE empresas}

// -------- BusquedaCiudad (ciudad) ------------
// Return true si la ciudad esta en ciudades.dat
// False si no ---------------------------------
function BusquedaCiudad(a : ciudad) : boolean;
VAR
	i : integer;
	n : integer;
	_ciudad : ciudad;
BEGIN
	//assign(ciudades, 'data/ciudades.dat');
	//reset(ciudades);

	i := 0;
	n := filesize(ciudades);
	while(i < n) do
	begin
		seek(ciudades, i);
		read(ciudades, _ciudad);
		if (_ciudad.COD_ciudad = a.COD_ciudad) or (UpperCase(_ciudad.nombre) = UpperCase(a.nombre)) then
			exit(true);

		i := i + 1;
	end;

	//close(ciudades);
	exit(false);
END;

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
				Cartel('ciudades');

				// * Leemos las variables * //
				// Leer codigo ciudad //
				_ciudad.COD_ciudad := IngresoCodigo('ciudades');

				Cartel('ciudades');

				// Leer Nombre //
				write(' Nombre ciudad: '); readln(_ciudad.nombre);
				Cartel('ciudades');

				// * Verificar que no este agregada esa ciudad * //
				if BusquedaCiudad(_ciudad) then
				begin
					writeLn(' La ciudad ya existe');
					sleep(1500);
					clrscr;
				end
				else
				begin
				  // Guardar la ciudad en el archivo //
					seek(ciudades, i);
					write(ciudades, _ciudad);
					i := i + 1;

					writeln(' Ciudad ingresada correctamente, presione para continuar');
					ShowCiudad(_ciudad);
					readln();
					clrscr;
				end;
			end;
		until (UpperCase(confirmacion) = 'N');

		OrdenarCiudades();

		close(ciudades);
END;

{$INCLUDE empresas}

// -------- BusquedaCiudad (ciudad) ------------
// Return true si la ciudad esta en ciudades.dat
// False si no ---------------------------------
function BusquedaCiudad(a : ciudad) : boolean;
VAR
	i : integer;
	n : integer;
	elem : ciudad;
BEGIN
	//assign(ciudades, 'data/ciudades.dat');
	//reset(ciudades);

	i := 0;
	n := filesize(ciudades);
	while(i < n) do
	begin
		seek(ciudades, i);
		read(ciudades, elem);
		if (elem.COD_ciudad = a.COD_ciudad) or (UpperCase(elem.nombre) = UpperCase(a.nombre)) then
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

// -----------------------------------------------
// Ingresa las ciudades en el archivo ciudades.dat
// COD_ciudad se guarda como un string[3]
//     no importa como lo ingreses
// Verifica que la ciudad no este ya guardada
// -----------------------------------------------
procedure AltaCiudades();
VAR
	confirmacion : char;
	elem : ciudad;
	i : integer;
BEGIN
		assign(ciudades, 'data/ciudades.dat');
		reset(ciudades);

		//posicionarse al final del archivo
		i := filesize(ciudades);
		repeat
			Cartel('ciudades');

		  writeln('Desea Ingresar una ciudad (s o n): ');
			readln(confirmacion);
			if UpperCase(confirmacion) = 'S' then
			begin
				Cartel('ciudades');

				// * Leemos las variables * //
				// Leer codigo ciudad //
				elem.COD_ciudad := IngresoCodigo('ciudades');

				Cartel('ciudades');

				// Leer Nombre //
				write('Nombre ciudad: '); readln(elem.nombre);
				Cartel('ciudades');

				// * Verificar que no este agregada esa ciudad * //
				if BusquedaCiudad(elem) then
				begin
					writeLn('La ciudad ya existe');
					sleep(1500);
					clrscr;
				end
				else
				begin
				  // Guardar la ciudad en el archivo //
					seek(ciudades, i);
					write(ciudades, elem);
					i := i + 1;

					writeln('Ciudad ingresada con exito!');
					writeln('[COD: ', elem.COD_ciudad, ']    [Nombre:', elem.nombre, ']');
					sleep(1500);
					clrscr;
				end;
			end;
		until (UpperCase(confirmacion) = 'N');

		OrdenarCiudades();

		close(ciudades);
END;

{$INCLUDE tipos}


function BuscarCiudad(a : string) : boolean;
VAR
	i, n : integer;
	_ciudad : ciudad;
BEGIN
	assign(ciudades, 'data/ciudades.dat');
	reset(ciudades);

	n := filesize(ciudades);

	for i:=0 to n-1 do
	begin
		seek(ciudades, i);
		read(ciudades, _ciudad);

		if _ciudad.COD_ciudad = UpperCase(a) then
			exit(true);
	end;

	close(ciudades);

	exit(false);
END;

// ------------------- ShowEmpresa() --------------------
// Muestra los datos de una empresa pasada como parametro
// ------------------------------------------------------
procedure ShowEmpresa(e : empresa);
begin
	writeln('COD_empresa: ', e.cod_empresa);
	writeln('nombre: ', e.nombre);
	writeln('direccion: ', e.direccion);
	writeln('telefono: ', e.telefono);
	writeln('mail: ', e.mail);
	writeln('COD_ciudad: ', e.cod_ciudad);
end;

procedure AltaEmpresas();
VAR
	_empresa : empresa;
	i : integer;
	cod_ciudad   : string;
	confirmacion : char;
BEGIN
	assign(empresas, 'data/empresas.dat');
	reset(empresas);

	//posicionarse al final del archivo
	i := filesize(empresas);
	repeat
		Cartel('empresas');

		writeln('Desea Ingresar una empresa (s o n): ');
		readln(confirmacion);
		if UpperCase(confirmacion) = 'S' then
		begin

			_empresa.cod_empresa := IngresoCodigo('empresa');

			//Ingreso
			Cartel('empresas');
			write('Nombre: '); readln(_empresa.nombre);

			Cartel('empresas');
			write('Direccion: '); readln(_empresa.direccion);

			Cartel('empresas');
			write('telefono: '); readln(_empresa.telefono);

			Cartel('empresas');
			write('Mail: '); readln(_empresa.mail);

			// * Ingreso COD ciudad * //
			repeat
				cod_ciudad := IngresoCodigo('ciudad');

				if not(BuscarCiudad(cod_ciudad)) then
				begin
					writeln('La ciudad ingresada no existe');
					sleep(1500);
				end;
			until (length(cod_ciudad) = 3) and BuscarCiudad(cod_ciudad);
			// ---------------------- //

			// * Guardar _empresa en el archivo empresas * //
			_empresa.cod_ciudad := cod_ciudad;

			seek(empresas, i);
			write(empresas, _empresa);

			writeln('Empresa ingresada correctamente');
			ShowEmpresa(_empresa);
			sleep(2000);
			// ------------------------------------------- //

		end;
	until UpperCase(confirmacion) = 'N';

	close(empresas);
END;

{$INCLUDE ciudades}


function BuscarEmpresa(cod : string) : boolean;
VAR
	i, n : integer;
	_emp : empresa;
BEGIN
	assign(empresas, 'data/empresas.dat');
	reset(empresas);

	n := filesize(empresas);

	for i:=0 to n-1 do
	begin
		seek(empresas, i);
		read(empresas, _emp);

		if _emp.COD_empresa = UpperCase(cod) then
			exit(true);
	end;

	exit(false);
END;


// ------------------- ShowEmpresa() -------------------- //
// Muestra los datos de una empresa pasada como parametro //
// ------------------------------------------------------ //
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


	repeat
		//posicionarse al final del archivo
		i := filesize(empresas);

		Cartel('EMPRESAS');

		writeln(' Desea Ingresar una empresa? (s o n): ');
		write(' ');
		readln(confirmacion);
		if UpperCase(confirmacion) = 'S' then
		begin

			Cartel('EMPRESAS');
			_empresa.cod_empresa := IngresoCodigo('empresa');

			//Ingreso
			Cartel('EMPRESAS');
			write(' Nombre: '); readln(_empresa.nombre);

			Cartel('EMPRESAS');
			write(' Direccion: '); readln(_empresa.direccion);

			Cartel('EMPRESAS');
			write(' Telefono: '); readln(_empresa.telefono);

			Cartel('EMPRESAS');
			write(' Mail: '); readln(_empresa.mail);

			// * Ingreso COD ciudad * //
			repeat
				Cartel('EMPRESAS');
				cod_ciudad := IngresoCodigo('ciudad');

				if not(BuscarCiudad(cod_ciudad)) then
				begin
					writeln('La ciudad ingresada no existe, presione para continuar');
					readln();
				end;
			until BuscarCiudad(cod_ciudad);
			close(ciudades);
			// ---------------------- //

			// * Guardar _empresa en el archivo empresas * //
			_empresa.cod_ciudad := cod_ciudad;

			seek(empresas, i);
			write(empresas, _empresa);

			Cartel('EMPRESA');
			writeln(' Empresa ingresado correctamente, presione para continuar');
			showEmpresa(_empresa);
			readln();
			// ------------------------------------------- //

		end;
	until UpperCase(confirmacion) = 'N';

	close(empresas);
END;

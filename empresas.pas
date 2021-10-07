{$INCLUDE ciudades}


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

			// * Ingreso COD empresa * //
			_empresa.cod_empresa := IngresoCOD('EMPRESAS', 'empresa', true);
			// ----------------------- //

			// * Ingreso COD ciudad * //
			assign(ciudades, 'data/ciudades.dat');
			reset(ciudades);
			if filesize(ciudades) <> 0 then 
				_empresa.COD_ciudad := IngresoCOD('EMPRESAS', 'ciudad')
			else
			begin
				WriteLn('No hay ciudades, ingrese ciudades. Presione una tecla para continuar.');
				close(ciudades);
				readln();
				menuEmpresas();
			end;
			Close(ciudades);

			// ---------------------- //

			//Ingreso
			Cartel('EMPRESAS');
			write(' Nombre: '); readln(_empresa.nombre);

			Cartel('EMPRESAS');
			write(' Direccion: '); readln(_empresa.direccion);

			Cartel('EMPRESAS');
			write(' Telefono: '); readln(_empresa.telefono);

			Cartel('EMPRESAS');
			write(' Mail: '); readln(_empresa.mail);


			// * Guardar _empresa en el archivo empresas * //
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
	menuEmpresas();
END;

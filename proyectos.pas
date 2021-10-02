{$INCLUDE ciudades}

function BuscarEmpresa(a : string) : boolean;
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

		if _emp.COD_empresa = UpperCase(a) then
			exit(true);
	end;

	close(empresas);

	exit(false);
END;

function IngresoCaracter( nombre : string; options : array of char ) : char;
var
	i, n : integer;
	etapa : char;
	correcto : boolean;
begin
	n := length(options);
	correcto := false;

	repeat
		Cartel('proyecto');
		write('[ ');
		for i:=0 to n-1 do
		begin
			write(options[i], ' - ');
		end;
		writeln(' ]');

		write(nombre, ': '); readln(etapa);
		etapa := UpCase(etapa);

		for i:=0 to n-1 do
		begin
			if( etapa = options[i] ) then
				correcto := true;
		end;

		if not correcto then
		begin
			writeln('Codigo de ',nombre,' incorrecto');
			sleep(2000);
		end;
	until correcto;


	exit(etapa);
end;

procedure AltaProyectos();
var
		confirmacion : char;
		_proyecto : proyecto;
		cod_ciudad : string;
		cod_empresa: string;
		etapa 		 : char;
		tipo   		 : char;
begin
	assign(proyectos, 'data/proyectos.dat');
	reset(proyectos);

	repeat
		Cartel('proyecto');

		writeln('Desea Ingresar un proyecto (s o n): ');
		readln(confirmacion);
		if UpperCase(confirmacion) = 'S' then
		begin

				_proyecto.COD_proy := IngresoCodigo('proyecto');

				// * Ingreso COD empresa * //
				repeat
					cod_empresa := IngresoCodigo('empresa');

					if not(BuscarEmpresa(cod_empresa)) then
					begin
						writeln('La empresa ingresada no existe');
						sleep(1500);
					end;
				until BuscarEmpresa(cod_empresa);

				_proyecto.cod_emp := cod_empresa;
				// ----------------------- //


				// * Ingreso COD ciudad * //
				repeat
					cod_ciudad := IngresoCodigo('ciudad');

					if not(BuscarCiudad(cod_ciudad)) then
					begin
						writeln('La ciudad ingresada no existe');
						sleep(1500);
					end;
				until (length(cod_ciudad) = 3) and BuscarCiudad(cod_ciudad);

				_proyecto.cod_ciudad := cod_ciudad;
				// ---------------------- //


				// * Ingreso etapa * //
				etapa := IngresoCaracter('Etapa', ['P', 'O', 'T']);
				// ----------------- //


				// * Ingreso tipo * //
				tipo := IngresoCaracter('Tipo', ['C', 'D', 'O', 'L']);
				// ----------------- //
		end;
	until UpperCase(confirmacion) = 'N';

	close(proyectos);
end;

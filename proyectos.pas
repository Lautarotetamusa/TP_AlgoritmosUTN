{$INCLUDE empresas}

function Buscarproyecto(a : string) : boolean;
VAR
	i, n : integer;
	_emp : proyecto;
BEGIN
	assign(proyectos, 'data/proyectos.dat');
	reset(proyectos);

	n := filesize(proyectos);

	for i:=0 to n-1 do
	begin
		seek(proyectos, i);
		read(proyectos, _emp);

		if _emp.COD_proy = UpperCase(a) then
			exit(true);
	end;

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
		write(' [ ');
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
			writeln(' Codigo de ',nombre,' incorrecto');
			sleep(2000);
		end;
	until correcto;


	exit(etapa);
end;


procedure ShowProyecto(a : proyecto);
var
	i : integer;
	cantidades : array [0..2] of string = ('productos', 'consultas', 'vendidos');
begin
	writeln(' COD proy: ', a.COD_proy);
	writeln(' COD emp: ', a.COD_emp);
	writeln(' COD ciudad: ', a.COD_ciudad);
	writeln(' etapa: ', a.etapa);
	writeln(' tipo: ', a.tipo);
	writeln(' Cantidades:');
	for i:=0 to 2 do
	begin
		writeln(' cantidades de ', cantidades[i], ': ', a.cantidades[i]);
	end;

end;
procedure AltaProyectos();
var
		confirmacion : char;
		_proyecto : proyecto;
		cod_ciudad : string;
		cod_proyecto: string;
		cod_emp     : string;
		i : integer;
		cantidades : array [0..2] of string = ('productos', 'consultas', 'vendidos');
begin
	assign(proyectos, 'data/proyectos.dat');
	reset(proyectos);

	repeat
		i := filesize(proyectos);
		Cartel('PROYECTO');

		writeln(' Desea Ingresar un proyecto (s o n): ');
		readln(confirmacion);
		if UpperCase(confirmacion) = 'S' then
		begin

				// * Ingreso COD proyecto * //
				repeat
					Cartel('PROYECTO');
					cod_proyecto := IngresoCodigo('proyecto');

					if Buscarproyecto(cod_proyecto) then
					begin
						writeln(' El proyecto ingresado ya existe, presione para continuar');
						readln();
					end;
				until not Buscarproyecto(cod_proyecto);

				_proyecto.COD_proy := cod_proyecto;
				// ----------------------- //

				// * Ingreso COD empresa * //
				repeat
					Cartel('PROYECTO');
					cod_emp := IngresoCodigo('empresa');

					if not(BuscarEmpresa(cod_emp)) then
					begin
						writeln(' La empresa ingresado no existe, presione para continuar');
						readln();
					end;
				until BuscarEmpresa(cod_emp);

				_proyecto.COD_emp := cod_emp;
				close(empresas);
				// ----------------------- //


				// * Ingreso COD ciudad * //
				repeat
					Cartel('PROYECTO');
					cod_ciudad := IngresoCodigo('ciudad');

					if not(BuscarCiudad(cod_ciudad)) then
					begin
						writeln('La ciudad ingresada no existe, presione para continuar');
						readln();
					end;
				until BuscarCiudad(cod_ciudad);

				_proyecto.cod_ciudad := cod_ciudad;
				// ---------------------- //


				// * Ingreso etapa * //
				_proyecto.etapa := IngresoCaracter(' Etapa', ['P', 'O', 'T']);
				// ----------------- //


				// * Ingreso tipo * //
				_proyecto.tipo := IngresoCaracter(' Tipo', ['C', 'D', 'O', 'L']);
				// ----------------- //

				// * Ingreso Cantidades * //
				for i := 0 to 2 do
				begin
					Cartel('PROYECTO');
					write(' Cantidad de ', cantidades[i],': '); readln(_proyecto.cantidades[i])
				end;
				// ---------------------- //

				write(proyectos, _proyecto);

				writeln(' Proyecto ingresada correctamente, presione para continuar');
				ShowProyecto(_proyecto);
				readln();
		end;
	until UpperCase(confirmacion) = 'N';

	close(proyectos);
end;

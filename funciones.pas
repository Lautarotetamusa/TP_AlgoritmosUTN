// * Archivo con funciones que se usan en el resto de archivos * //

{$INCLUDE tipos}

procedure Cartel(message : string);
BEGIN

	clrscr;
	writeln('  _______________________');
	writeln(' |  ___________________  |');
	writeln(' | |                   | |');
	writeln(' | |   ALTA ', message,'   | |');
	writeln(' | |___________________| |');
	writeln(' |_______________________|');
	writeln('');
END;

function BuscarCiudad(a : string) : boolean;
VAR
	i: integer;
	n : int64;
	_ciudad : ciudad;
BEGIN

	n := filesize(ciudades);

	for i:=0 to n-1 do
	begin
		seek(ciudades, i);
		read(ciudades, _ciudad);

		if _ciudad.COD_ciudad = UpperCase(a) then
			exit(true);
	end;

	exit(false);
END;

function BuscarEmpresa(a : string)   : boolean;
VAR
	i : integer;
	n : int64;
	_emp : empresa;
BEGIN

	n := filesize(empresas);

	for i:=0 to n-1 do
	begin
		seek(empresas, i);
		read(empresas, _emp);

		if _emp.COD_empresa = UpperCase(a) then
			exit(true);
	end;

	exit(false);
END;

function BuscarProducto(a : string) : boolean;
var
	i: integer;
	n : int64;
	_prod : producto;
begin

	n := filesize(productos);

	for i:=0 to n-1 do
	begin
		seek(productos, i);
		read(productos, _prod);

		if _prod.COD_prod = UpperCase(a) then
			exit(true);
	end;

	exit(false);
end;

function BuscarProyecto(a : string) : boolean;
VAR
	i, n : integer;
	_emp : proyecto;
BEGIN
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

function BuscarCOD(cod, tipo : string) : boolean;
VAR
	result : boolean;
BEGIN

	result := false;

	case (tipo) of
		'ciudad'  : result := BuscarCiudad(cod);
		'empresa' : result := BuscarEmpresa(cod);
		'proyecto': result := BuscarProyecto(cod);
		'producto': result := BuscarProducto(cod);
		else writeln(' error tipo incorrecto');
	end;

	exit(result);
END;

// ------------------------------------------------------------- //
// * Hace los chequeos necesarios del ingreso de cualquier COD * //
// ------------------------------------------------------------- //
function IngresoCodigo(alta, cartel : string) : string;
VAR
	return : string;
BEGIN
	repeat
	clrscr;
	writeln('  _______________________');
	writeln(' |  ___________________  |');
	writeln(' | |                   | |');
	writeln(' | |   ALTA ', alta,'   | |');
	writeln(' | |___________________| |');
	writeln(' |_______________________|');
	writeln('');
		writeln(' [ 3 letras mayusculas ]');
		write(' COD ', cartel, ' : '); readln(return);

		if (length(return) <> 3) then
		begin
			WriteLn('El codigo debe tener 3 letras');
			sleep(1500)
		end;
	until (length(return) = 3);

	exit(UpperCase(return));
END;



function IngresoCOD(nombreAlta, nombreCOD : string) : string; overload;
var
	COD : string;
begin
	repeat
		COD := IngresoCodigo(nombreAlta, nombreCOD);

		if not BuscarCOD(COD, nombreCOD) then
		begin
			writeLn(' ',nombreCOD,' NO existe, presione para continuar');
			readln();
		end;
	until (BuscarCOD(COD, nombreCOD));

	exit(COD);
end;

function IngresoCOD(nombreAlta, nombreCOD : string; e : boolean) : string; overload;
var
	COD : string;
begin

	repeat
		COD := IngresoCodigo(nombreAlta, nombreCOD);

		if BuscarCOD(COD, nombreCOD) then
		begin
			writeLn(' ',nombreCOD,' YA existe, presione para continuar');
			readln();
		end;
	until not (BuscarCOD(COD, nombreCOD));

	exit(COD);
end;

function BuscarNombreEmpresa(a : string)   : String;
	VAR
		i : integer;
		n : int64;
		_emp : empresa;
	BEGIN
		n := filesize(empresas);
	for i:=0 to n-1 do
	begin
		seek(empresas, i);
		read(empresas, _emp);
		if _emp.COD_empresa = UpperCase(a) then
			exit(_emp.nombre);
		end;
	END;

function BuscarNombreCiudad(a : string) : String;
	VAR
		i: integer;
		n : int64;
		_ciudad : ciudad;
	BEGIN
		n := filesize(ciudades);
		for i:=0 to n-1 do
		begin
			seek(ciudades, i);
			read(ciudades, _ciudad);
			if _ciudad.COD_ciudad = UpperCase(a) then
				exit(_ciudad.nombre);
		end;
	END;

procedure dibujarHorizontales(h:integer);
	var
		i:integer;
	begin
	  	for i:=3 to 46 do
			begin
			gotoxy(i,h);
			write('_');
		end;
	end;

procedure dibujarVerticales(h:integer);
	begin
		gotoxy(2,h); write('|');
		gotoxy(9,h); write('|');
		gotoxy(27,h); write('|');
		gotoxy(47,h); write('|');
	end;

// * Archivo con funciones que se usan en el resto de archivos * //

PROGRAM funciones;
USES crt,sysutils, contra;
var
intentos:integer;

procedure Cartel(message : string);
BEGIN

	clrscr;
	writeln('  _______________________');
	writeln(' |  ___________________  |');
	writeln(' | |                   | |');
	writeln(' | |   MENU ', message,'   | |');
	writeln(' | |___________________| |');
	writeln(' |_______________________|');
	writeln('');
END;

// ------------------------------------------------------------- //
// * Hace los chequeos necesarios del ingreso de cualquier COD * //
// ------------------------------------------------------------- //
function IngresoCodigo(cartel : string) : string;
VAR
	return : string;
BEGIN
	repeat

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

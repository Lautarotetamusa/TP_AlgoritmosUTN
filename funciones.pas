// * Archivo con funciones que se usan en el resto de archivos * //

PROGRAM tipos;
<<<<<<< HEAD
USES crt, sysutils;

// ----------------------------------------- //
// Muestra el cartel con el nombre del param //
// ----------------------------------------- //
=======
USES crt,sysutils,contra;
var
intentos:integer;
>>>>>>> bf390b0e0e70e2b7d819555ac572d37d69a0ba03
procedure Cartel(message : string);
BEGIN
	clrscr;
	
	writeln('  _______________________');
	writeln(' |  ___________________  |');
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
		clrscr;
		writeln('  _______________________');
		writeln(' |  ___________________  |');
		writeln(' | |   ALTA ', cartel,'   | |');
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

// * Archivo con funciones que se usan en el resto de archivos * //

PROGRAM tipos;
USES crt, sysutils;

// ----------------------------------------- //
// Muestra el cartel con el nombre del param //
// ----------------------------------------- //
procedure Cartel(message : string);
BEGIN
	clrscr;

	writeln('╔═══════════════════════╗');
	writeln('║     Alta ', message,'     ║');
	writeln('╚═══════════════════════╝');
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

		writeln('╔═══════════════════════╗');
		writeln('║     Alta ', cartel,'     ║');
		writeln('╚═══════════════════════╝');

		writeln('[ 3 letras mayusculas ]');
		write('COD ', cartel, ' : '); readln(return);

		if (length(return) <> 3) then
		begin
			WriteLn('El codigo debe tener 3 letras');
			sleep(1500)
		end;
	until (length(return) = 3);

	exit(UpperCase(return));
END;

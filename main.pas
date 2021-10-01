{$INCLUDE ciudades}

procedure menuPrincipal();forward;
procedure menuEmpresas();
	var
		descartable:char;
	begin
		clrscr;
		writeln('  _______________________');
		writeln(' |  ___________________  |');
		writeln(' | |   MENU EMPRESAS   | |');
		writeln(' | |___________________| |');
		writeln(' |_______________________|');
		writeln('');

		WriteLn(' 1. Alta de CIUDADES');
		WriteLn(' 2. Alta de EMPRESAS');
		WriteLn(' 3. Alta de PROYECTOS');
		WriteLn(' 4. Alta de PRODUCTOS');
		WriteLn(' 5. ESTADISTICAS');
		WriteLn(' 0. Volver al menu principal');
		write(' ');
		ReadLn(descartable);

		case (descartable) of
			'1':AltaCiudades();
			'2':AltaEmpresas();
			'3':WriteLn('ALTA');
			'4':WriteLn('ALTA');
			'5':WriteLn('ALTA');
			'0':menuPrincipal();
			else WriteLn(descartable,' NO ES UNA OPCION VALIDA')
	end;
	end;

procedure menuClientes();
	var
		descartable:char;
	begin
		clrscr;
		writeln('  _______________________');
		writeln(' |  ___________________  |');
		writeln(' | |   MENU CLIENTES   | |');
		writeln(' | |___________________| |');
		writeln(' |_______________________|');
		writeln('');
		WriteLn(' 1. Alta de CLIENTE');
		WriteLn(' 0. Volver al menu principal');
		write(' ');
		ReadLn(descartable);

		case (descartable) of
			'1':WriteLn('ALTA');
			'0':menuPrincipal();
			else WriteLn(descartable,' NO ES UNA OPCION VALIDA')
		end;
	end;

procedure menuPrincipal();
	var 
		descartable:char;
	begin
		clrscr;
		writeln('  _______________________');
		writeln(' |  ___________________  |');
		writeln(' | |   MENU PRINCIPAL  | |');
		writeln(' | |___________________| |');
		writeln(' |_______________________|');
		writeln('');

		WriteLn(' 1. Menu Empresas');
		WriteLn(' 2. Menu Clientes');
		WriteLn(' 0. Salir');
		write(' ');
		ReadLn(descartable);

		case (descartable) of
			'1': menuEmpresas();
			'2': menuClientes();
			'0': halt();
			else WriteLn(descartable, ' NO ES UNA OPCION VALIDA')
		end;
	end;

// ----------------------------
// * Programa principal *
// ---------------------------
BEGIN
	// AssignFiles();
	while 1 = 1 do
	begin
		clrscr;
		menuPrincipal();
	end;	
END.

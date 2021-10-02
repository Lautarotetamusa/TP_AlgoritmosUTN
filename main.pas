{$INCLUDE ciudades}

procedure menuPrincipal();forward;
function contra():string;forward;
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
			'1':if (intentos<3) then
				begin
					if autenticacion(contra(),1) then
						menuEmpresas()
					else
					begin
						intentos:= intentos+1;
						writeln(' ');
						writeln(' CLAVE INCORRECTA, ',3-intentos,' INTENTOS RESTANTES, presione una tecla para continuar');
						readln();
					end;
				end
				else
				begin
					writeln(' INTENTOS AGOTADOS, presione una tecla para volver');
					readln();
				end;
			'2':if autenticacion(contra(),2) then
					menuClientes()
				else
				begin
					writeln(' ');
                	writeln(' CLAVE INCORRECTA, presione una tecla para continuar');
                	readln();
				end;
			'0': halt();
			else WriteLn(descartable, ' NO ES UNA OPCION VALIDA')
		end;
	end;
    
//Camufla la contra para que no se vea cuando se escribe
function contra():string;
	var
	    clave:string;
	    ch:char;
	begin
	    clave:='';
	    writeln(' INGRESE CLAVE:');
		write(' ');
	    ch:=readkey;
	    while ch <>#13 do
	    begin
	        clave:=clave+ch;
	        write('*');
	        ch:=readkey;
	    end;
	    contra:=clave;
	end;





// ----------------------------
// * Programa principal *
// ---------------------------
BEGIN
	intentos:=0;
	// AssignFiles();
	while 1 = 1 do
	begin
		clrscr;
		menuPrincipal();
	end;	
END.

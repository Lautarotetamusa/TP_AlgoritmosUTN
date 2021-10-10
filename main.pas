{$INCLUDE productos}



function contra():string;forward;

procedure menuEmpresas();
	var
		descartable:char;
	begin
		Cartel('EMPRESAS');

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
			'3':AltaProyectos();
			'4':AltaProductos();
			'5':estadisticas();
			'0':menuPrincipal();
			else WriteLn(descartable,' NO ES UNA OPCION VALIDA')
	end;
	end;

procedure menuClientes();
	var
		descartable:char;
	begin
		Cartel('CLIENTES');
		WriteLn(' 1. Alta de CLIENTE');
		Writeln(' 2. Consulta de Proyectos');
		WriteLn(' 0. Volver al menu principal');
		write(' ');
		ReadLn(descartable);

		case (descartable) of
			'1':altaClientes();
			'0':menuPrincipal();
			'2':consultaProyectos();
			else WriteLn(descartable,' NO ES UNA OPCION VALIDA')
		end;
	end;

procedure consultaProyectos();
	var
		descartable:char;
		i, pos: integer;
		fs: int64;
		prod,aux :producto;

		proy: proyecto;
		_cod:string;
		procedure consultaProyecto();
			var
				cod:string;
				i:integer;
				fs:int64;
				_proy:proyecto;
				_prod:producto;
				function BuscarTipoProyecto(a : string) : proyecto;
					VAR
						i, n : integer;
						_emp : proyecto;
					BEGIN
						n := filesize(proyectos);

						for i:=0 to n-1 do
						begin
							seek(proyectos, i);
							read(proyectos, _emp);

							if (uppercase(a)=_emp.COD_proy) then

								exit(_emp);
						end;
						WriteLn(' No se encontro proyecto con el codigo especificado.');
						ReadLn();
						consultaProyecto();
						close(ciudades);
						close(proyectos);
						close(empresas);
						close(ciudades);
					END;
				function BuscarTipoProducto(a : string) : producto;
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
								exit(_prod);
						end;
						Writeln(' No se encontro producto con el codigo especificado.');
						ReadLn();
						close(productos);
						close(ciudades);
						close(proyectos);
						close(empresas);
						consultaProyectos();
					end;
			begin
				
				WriteLn('');
				WriteLn('');
				WriteLn(' Ingrese el codigo del Proyecto que quiere consultar: ');
				ReadLn(cod);

				_proy:=BuscarTipoProyecto(cod);
				clrscr;
				
				gotoxy(3,2);write('Cod');
				gotoxy(8,2);write('Empresa');
				gotoxy(24,2);write('Ciudad');
				gotoxy(3,3);write(_proy.COD_proy);
				gotoxy(8,3);write(Uppercase(BuscarNombreEmpresa(_proy.COD_emp)));
				gotoxy(24,3);write(Uppercase(BuscarNombreCiudad(_proy.COD_ciudad)));
				gotoxy(3,5);writeln('Productos de este proyecto ');
				writeln('  (codigo - detalles - precio): ');

				Assign(productos,'data/productos.dat');
				Reset(productos);
				fs:=FileSize(productos);
				dibujarHorizontales(4);
				dibujarHorizontales(7);

				pos:=8;
				for i:=0 to fs-1 do
				begin
					Seek(productos,i);
					Read(productos, _prod);
					if (_prod.COD_proy = _proy.COD_proy) and (_prod.estado=False) then
					begin
						gotoxy(2,pos); write('|');
						gotoxy(4,pos);write(_prod.COD_prod);
						gotoxy(9,pos);write('|');
						gotoxy(11,pos);write(_prod.detalle);
						gotoxy(27,pos); write('|');
						gotoxy(29,pos);write(_prod.precio:9:2,' $');
						gotoxy(47,pos); write('|');
						pos:=pos+1;
					end;
				end;
				gotoxy(2,pos);write('Ingrese el codigo del producto que quiere comprar:');
				readln(_cod);
				prod := BuscarTipoProducto(_cod);
				clrscr;
				writeln('Esta seguro que quiere comprar');
				writeln( prod.detalle,' por ', prod.precio:9:2, '$ (s - n): ');
				ReadLn(cod);
				if (uppercase(cod)='S') then
				begin
					prod.estado:=True;
				
					for i:=0 to (FileSize(productos)-1) do
					begin
						seek(productos,i);
						read(productos,aux);
						if aux.COD_prod = prod.COD_prod then
						begin
							seek(productos,Filepos(productos)-1);
							write(productos,prod);
						end;
					end;
					ReadLn();
				end;
				close(ciudades);
				close(empresas);
				close(proyectos);
				close(productos);	
				menuClientes();	
			end;
	begin
		clrscr;

		repeat
			write(' Ingrese tipo de proyecto(c - d - o - l): ');
			textcolor(yellow);
			write('H para SALIR');
			writeln(' ');
			textcolor(white);	
			gotoxy(2,wherey);readln(descartable);
			if uppercase(descartable)='H' then
			begin
				menuClientes();
			end;
		until (uppercase(descartable)='C') or (uppercase(descartable)='D') or (uppercase(descartable)='O') or (uppercase(descartable)='L');
		
		assign(proyectos,'data/proyectos.dat');		
		Reset(proyectos);
		Assign(empresas,'data/empresas.dat');
		reset(empresas);
		Assign(ciudades,'data/ciudades.dat');
		reset(ciudades);
		fs:= FileSize(proyectos);
		
		pos:= 6;
		clrscr;
		gotoxy(10,2);
		write(' PROYECTOS DE TIPO ');
			case uppercase(descartable) of
			'C':write('CASAS');
			'D':write('DEPARTAMENTOS');
			'O':write('OFICINAS');
			'L':write('LOTEOS');
		end;
		writeln('');
		gotoxy(7,3);
		write(' (Codigo - Empresa - Ciudad): ');
	
		dibujarHorizontales(pos-2);
		dibujarVerticales(pos-1);

		for i:=0 to fs-1 do
		begin
			seek(proyectos, i);
			read(proyectos, proy);
			
			if proy.tipo = Uppercase(descartable) then 
			begin
				gotoxy(2,pos); write('|');
				gotoxy(4,pos);write(proy.COD_proy);
				gotoxy(9,pos);write('|');
				gotoxy(11,pos);write(Uppercase(BuscarNombreEmpresa(proy.COD_emp)));
				gotoxy(27,pos); write('|');
				gotoxy(29,pos);write(Uppercase(buscarNombreCiudad(proy.COD_ciudad)));
				gotoxy(47,pos); write('|');
				pos := pos+1;
			end;
		end;

		dibujarVerticales(pos);
		dibujarHorizontales(pos);
		consultaProyecto();





		close(ciudades);
		close(proyectos);
		close(empresas);
	end;



procedure menuPrincipal();
	var
		descartable:char;
	begin
		clrscr;
		writeln('  _______________________');
		writeln(' |  ___________________  |');
		writeln(' | |                   | |');
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

// ---------------------------------------------------------
// * Camufla la contra para que no se vea cuando se escribe *
// ----------------------------------------------------------
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


// -----------------------
// * Programa principal *
// -----------------------
BEGIN
	intentos:=0;
	while 1 = 1 do
	begin
		clrscr;
		menuPrincipal();
	end;
END.

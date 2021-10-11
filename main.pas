{$INCLUDE productos}
{
	TRABAJO PRACTICO #3
	
	Integrantes:
		Lautaro Teta Musa
		Laureano Oliva

}


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
		repeat
			Cartel('CLIENTES');
			WriteLn(' 1. Alta de CLIENTE');
			Writeln(' 2. Ingreso Clientes');
			WriteLn(' 0. Volver al menu principal');
			write(' ');
			ReadLn(descartable);
		until (descartable = '1') or (descartable ='2') or (descartable='0');

		case (descartable) of
			'1':altaClientes();
			'0':menuPrincipal();
			'2':ingresoClientes();
			else WriteLn(descartable,' NO ES UNA OPCION VALIDA')
		end;
	end;

procedure consultaProyectos(mail:string);
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
				i,j:integer;
				fs:int64;
				_proy:proyecto;
				_prod:producto;
				procedure actulaizarConsultas(pro:producto);
				var
					j,i:integer;
					aux:empresa;
					_pro:proyecto;
					ciu:ciudad;
				begin

				
					for j:=0 to (filesize(proyectos)-1) do
					begin
						seek(proyectos,j);
						read(proyectos,_proy);
						if (_proy.COD_proy = pro.COD_proy) then
						begin

							_proy.cantidades[1]:=_proy.cantidades[1]+1;
							seek(proyectos,filepos(proyectos)-1);
							write(proyectos,_proy);
							for i:=0 to (FileSize(empresas)-1) do
							begin
								seek(empresas,i);
								read(empresas,aux);
								if(aux.COD_empresa = _proy.COD_emp) then
								begin
									aux.consultas:= aux.consultas+1;
									seek(empresas,filepos(empresas)-1);
									write(empresas,aux);
								end;
							end;
							for i:=0 to (filesize(ciudades)-1) do
							begin
								seek(ciudades,j);
								read(ciudades,ciu);
								if (ciu.COD_ciudad = _proy.COD_ciudad) then
								begin
									ciu.consultas:= ciu.consultas +1;
									seek(ciudades,filepos(ciudades)-1);
									write(ciudades,ciu);
								end;
							end;
						end;
					end;
				end;


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
						close(ciudades);
						close(proyectos);
						close(empresas);
						close(ciudades);
						consultaProyecto();
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
						consultaProyectos(mail);
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
				actulaizarConsultas(prod);
				clrscr;
				writeln('Esta seguro que quiere comprar?');
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
							for j:=0 to (filesize(proyectos)-1) do
							begin
								seek(proyectos,i);
								read(proyectos,_proy);
								if (_proy.COD_proy = prod.COD_proy) then
								begin
									_proy.cantidades[0]:=_proy.cantidades[0]-1;
									_proy.cantidades[2]:=_proy.cantidades[2]+1;
									seek(proyectos,filepos(proyectos)-1);
									write(proyectos,_proy);
								end;
							end;
							writeln('La venta se a completado con exito.');
							write(' Un Mail sera enviado a :');textcolor(yellow); WriteLn(mail) ;textcolor(white);
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

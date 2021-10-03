{$INCLUDE proyectos}

function BuscarProducto(cod : string) : boolean;
var
	i, n : integer;
	_prod : producto;
begin
	assign(productos, 'data/productos.dat');
	reset(productos);

	n := filesize(productos);

	for i:=0 to n-1 do
	begin
		seek(productos, i);
		read(productos, _prod);

		if UpperCase(cod) = _prod.COD_prod then
			exit(true);
	end;

	exit(false);
end;

procedure AltaProductos();
var
		confirmacion : char;
		estado : char;
		estado_correcto : boolean;
		_producto : producto;
		cod_proy : string;
		cod_prod : string;
		i : integer;
begin
	assign(productos, 'data/productos.dat');
	reset(productos);

	repeat
		//posicionarse al final del archivo
		i := filesize(productos);
		Cartel('PRODUCTO');

		writeln(' Desea Ingresar un producto (s o n): ');
		readln(confirmacion);
		if UpperCase(confirmacion) = 'S' then
		begin

				// Ingreso COD_prod //
				repeat
					Cartel('PRODUCTO');
					cod_prod := IngresoCodigo('producto');

					if BuscarProducto(cod_prod) then
					begin
						writeln(' El producto ya existe, presione cualquier tecla para continuar..');
						readln();
					end;
				until not BuscarProducto(cod_prod);

				_producto.COD_prod := cod_prod;
				// -------------- //

				// Ingreso COD_proy, verifica que exista
				repeat
					Cartel('PRODUCTO');
					cod_proy := IngresoCodigo('proyecto');

					if not Buscarproyecto(cod_proy) then
					begin
						writeln(' El proyecto NO existe, presione cualquier tecla para continuar..');
						readln();
					end;
				until Buscarproyecto(cod_proy);
				close(proyectos);

				_producto.COD_proy := cod_proy;
				// -------------------------------------

				// Precio de venta
				Cartel('PRODUCTO');
				write(' Precio de venta: '); readln(_producto.precio);
				// ---------------

				// Estado {vendido S/N}
				repeat
					Cartel('PRODUCTO');
					write(' Estado {vendido S/N} : '); readln(estado);

					estado_correcto := (UpperCase(estado) = 'S') or (UpperCase(estado) = 'N');
					if  not estado_correcto then
					begin
						writeln(' Estado incorrecto, presione para continuar');
						readln();
					end;
				until estado_correcto;

				if UpperCase(estado) = 'S' then
					_producto.estado := true;

				if UpperCase(estado) = 'N' then
					_producto.estado := false;
				// --------------------- //
		end;

	until UpperCase(confirmacion) = 'N';

	close(productos);
end;

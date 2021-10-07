{$INCLUDE proyectos}

procedure ShowProducto(a : producto);
begin
	writeln(' detalle: ', a.detalle);
	writeln(' COD_prod: ', a.COD_prod);
	writeln(' COD_proy: ', a.COD_proy);
	writeln(' estado: ', a.estado);
	writeln(' precio: ', a.precio); 
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
					_producto.COD_prod := IngresoCOD('PRODUCTO', 'producto', true);
				// -------------- //

				// Ingreso COD_proy, verifica que exista
					_producto.COD_proy := IngresoCOD('PRODUCTO', 'proyecto');
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


				// Ingreso Detalle //
				writeln(' Detalle: '); readln(_producto.detalle);
				// --------------- //

				// * Guardar _producto en el archivo producto * //
				seek(productos, i);
				write(productos, _producto);

				Cartel('EMPRESA');
				writeln(' Producto ingresado correctamente, presione para continuar');
				showProducto(_producto);
				readln();
				// ------------------------------------------- //
		end;

	until UpperCase(confirmacion) = 'N';
	close(productos);
	menuEmpresas();
end;

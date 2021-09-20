
{$INCLUDE empresas}


// ----------------------------
// * Asignacion de archivos *
// ---------------------------
procedure AssignFiles();
BEGIN
		assign(empresas, 'data/empresas.dat');
		assign(clientes, 'data/clientes.dat');
		assign(proyectos, 'data/proyectos.dat');
		assign(productos, 'data/productos.dat');
END;



// ----------------------------
// * Programa principal *
// ---------------------------
BEGIN
	// AssignFiles();

	 clrscr;

	 AltaEmpresas();

	 //AltaCiudades();
END.

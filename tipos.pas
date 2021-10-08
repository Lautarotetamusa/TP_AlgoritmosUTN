

PROGRAM tipos;
USES crt,sysutils, contra;
var
intentos:integer;
procedure menuPrincipal();forward;
procedure menuEmpresas();forward;
procedure menuClientes();forward;
//-----------------------------------
// * Declaracion de tipos de datos *
//-----------------------------------
// ciudad
// empresa
// cliente
// proyecto
// producto
// ---------------------------------
type

		 ciudad = RECORD
				nombre 		 : array[0..20] of char;
				COD_ciudad : array[0..3] of char;
				consultas: integer;
		 END;
		 empresa = RECORD
		 		direccion		: array[0..40] of char;
		 		mail 				: array[0..30] of char;
				nombre 			: array[0..20] of char;
				telefono		: array[0..20] of char;
				COD_empresa : array[0..3] of char;
				COD_ciudad	: array[0..3] of char;
				consultas: integer;
		 END;
		 cliente = RECORD
		 		nombre_apellido : array[0..40] of char;
		 		mail 						: array[0..30] of char;
				dni : longint;
		 END;
		 proyecto = RECORD
		 		// ----- cantidades -----
		 		// [0] cant de productos
				// [1] cant de consultas
				// [2] cant de vendidos
				// ---------------------
				cantidades : array[0..3] of integer;
		 		COD_proy   : array[0..3] of char;
				COD_emp  	 : array[0..3] of char;
				COD_ciudad : array[0..3] of char;
				etapa    : char;
				tipo 		 : char;
				consultas: integer;
		 END;
		 producto = RECORD
		 		detalle : array[0..49] of char;
		 		COD_prod :  array[0..3] of char;
				COD_proy :  array[0..3] of char;
				estado : boolean;
				precio : real;
		 END;

 // ----------------------------
 // * declaracion de archivos *
 // ----------------------------

 var
 		ciudades : FILE of ciudad;
		empresas : FILE of empresa;
		clientes : FILE of cliente;
		proyectos: FILE of proyecto;
		productos: FILE of producto;

{$INCLUDE estadisticas}

procedure showCliente(c:cliente);
    begin
        writeln(' Nombre: ', c.nombre_apellido);
        writeln(' Mail: ', c.mail);
        writeln(' DNI: ', c.dni);
    end;

procedure menuclientesregistrados(mail:string);
var
    descartable:char;
begin
    repeat
        writeln();
        writeln(' Ingrese la opcion que quiera consultar: ');
        writeln(' 1. CONSULTAR PROYECTOS');
        writeln(' 0. VOLVER AL MENU CLIENTES');
        readln(descartable);
    until (descartable='1') or (descartable='0');

    case descartable of
        '1':consultaProyectos(mail);
        '0':menuClientes();
    end;

end;

procedure ingresoClientes();
var
    i:integer;
    userinput:string;
    error:integer;
    _dni:longint;
    aux:cliente;
begin
    clrscr;
    assign(clientes,'data/clientes.dat');
    reset(clientes);
    repeat
        writeln('Ingrese su DNI: ');
        readln(userinput);
        val(userinput,_dni,error);
    until error = 0;
    for i:=0 to (filesize(clientes)-1) do
    begin
        seek(clientes,i);
        read(clientes,aux);
        if _dni=aux.dni then
        begin
            clrscr;
            close(clientes);
            writeln(' Bienvenidos ', UpperCase(aux.nombre_apellido));
            menuclientesregistrados(aux.mail); 
        end
        else
        begin
            textcolor(yellow);
            writeln(' Cliente con DNI ' , _dni , ' Inexistente ');
            textcolor(white);
            writeln(' Registrese en Alta Clientes');
            readln();
            close(clientes);
            menuclientes();
        end;
    end;
    close(clientes);
end;


function buscarClienteExiste(a:longint):Boolean;
var
    i:integer;
    aux:cliente;
begin
    for i:=0 to (fileSize(clientes)-1) do
    begin
        seek(clientes,i);
        read(clientes,aux);
        if aux.dni = a then
        begin
            exit(True);
        end;
    end;
    exit(false);
end;

procedure altaClientes();
    var
        _cliente:cliente;
        i:integer;
        descartable:char;
    begin
        assign(clientes, 'data/clientes.dat');
        reset(clientes);

        i:= filesize(clientes);
        repeat
            Cartel('CLIENTES');
            writeln(' Desea registrar un nuevo Cliente? (s o n): ');
            write(' ');
            readln(descartable);
            if UpperCase(descartable) = 'S' then
            begin
                Cartel('CLIENTES');
                write(' Nombre: '); readln(_cliente.nombre_apellido);

                Cartel('CLIENTES');
               write(' Mail: '); readln(_cliente.mail);

                Cartel('CLIENTES');
                write(' Dni: ');readln(_cliente.dni);

                if (buscarClienteExiste(_cliente.dni)) then
                begin
                    clrscr;
                    writeln('');
                    textcolor(yellow);
                    writeln(' El  DNI ',_cliente.dni, ' pertenece a un CLIENTE REGISTRADO PREVIAMENTE ' );
                    textcolor(white);
                    writeln(' Si desea Ingrsar, sellecione en el menu Ingreso de cliente');
                    ReadLn();
                    close(clientes);
                    altaClientes();
                end
                else
                begin
                    seek(clientes,i);
                    write(clientes,_cliente);
                    writeln(' Cliente ingresado correctamente, presione para continuar');
                    showCliente(_cliente);
                    readln();
                end;
            end;
            close(clientes);
        until UpperCase(descartable) = 'N';
        menuClientes();
    end;

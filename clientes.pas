{$INCLUDE estadisticas}

procedure showCliente(c:cliente);
    begin
        writeln(' Nombre: ', c.nombre_apellido);
        writeln(' Mail: ', c.mail);
        writeln(' DNI: ', c.dni);
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
                write(' Dni: '); readln(_cliente.dni);

                seek(clientes,i);
                write(clientes,_cliente);

                writeln(' Cliente ingresado correctamente, presione para continuar');
                showCliente(_cliente);
                readln();

            end;
        until UpperCase(descartable) = 'N';
        close(clientes);
        menuClientes();
    end;

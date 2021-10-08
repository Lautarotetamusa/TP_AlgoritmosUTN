{$INCLUDE funciones}

procedure estadisticasEmpresas();
    var
        empr:empresa;
        fs:int64;
        i,pos:integer;
    begin
        Assign(empresas,'data/empresas.dat');
        reset(empresas);
        fs:=filesize(empresas);
        pos:=5;
        clrscr;
        writeln(' Empresas con mas de 10 consultas: ');
        for i:=3 to 50 do
        begin
            gotoxy(i,pos-3);
            Write('_');
            gotoxy(i,pos-1);
            write('_');
        end;
        

        gotoxy(2,pos-2);write('|');
        gotoxy(7,pos-2); Write('NOMBRE');
        gotoxy(23,pos-2);write('|');
        gotoxy(28,pos-2); Write('Nro. CONSULTAS');
        gotoxy(2,pos-1); Write('|');
        gotoxy(23,pos-1);write('|');

        gotoxy(51,pos-2);write('|');
        gotoxy(51,pos-1);write('|');
        while not eof(empresas) do
        begin
            for i:= 0 to fs-1 do
            begin
                read(empresas,empr);
                if empr.consultas > 10 then
                begin
                    gotoxy(2,pos);
                    write('|');
                    gotoxy(4,pos);
                    Write(empr.nombre);
                    gotoxy(23,pos);
                    Write('|');
                    gotoxy(25,pos);
                    Write(empr.consultas);
                    gotoxy(51,pos);write('|');
                    pos:=pos+1;
                end;
            end;
            gotoxy(2,pos);Write('|');
            gotoxy(23,pos);Write('|');
            gotoxy(51,pos);Write('|');
            for i:=3 to 50 do
            begin
                gotoxy(i,pos);
                write('_');
            end;
            gotoxy(1,pos+2);
        end;
        close(empresas);
    end;

procedure estadisticasCiudades();
    var
        ciud, aux:ciudad;
        fs:int64;
        i:integer;
    begin
        Assign(ciudades,'data/ciudades.dat');
        reset(ciudades);
        fs:=FileSize(ciudades);
        Write(' Ciudad con mas consultas de proyectos: ');
        for i:= 0 to fs-1 do
        begin
            seek(ciudades,i);
            read(ciudades,ciud);
            if ciud.consultas > aux.consultas then
                aux:=ciud;
        end;
        Write(aux.nombre,' Consultas: ', aux.consultas);
    end;



{
procedure estadisticasProyectos();
    }

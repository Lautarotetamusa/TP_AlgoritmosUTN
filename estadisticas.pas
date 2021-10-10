{$INCLUDE funciones}
procedure estadisticasProyectos(a:integer);forward;
procedure estadisticasEmpresas();
    var
        empr:empresa;
        fs:int64;
        i,pos:integer;
    begin
        Assign(empresas,'data/empresas.dat');
        reset(empresas);
        fs:=filesize(empresas);
        pos:=9;
        gotoxy(2,5);writeln(' Empresas con mas de 10 consultas: ');
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
        estadisticasProyectos(pos+4);
    end;

procedure estadisticasCiudades();
    var
        ciud, aux:ciudad;
        i:integer;
    begin
        Assign(ciudades,'data/ciudades.dat');
        reset(ciudades);
        writeln('');
        Write(' CIUDAD CON MAYOR CONSULTAS: ');
        for i:= 0 to FileSize(ciudades)-1 do
        begin
            seek(ciudades,i);
            read(ciudades,ciud);
            if ciud.consultas > aux.consultas then
                aux:=ciud;
        end;
        textcolor(yellow);
        Write(aux.nombre);
        textcolor(white);
        write(' Consultas: ');
        textcolor(yellow);
        write(aux.consultas);
        textcolor(white);
        writeln('');
        close(ciudades);
        dibujarhorizontales(3);
    end;




procedure estadisticasProyectos(a:integer);
    var
        i:integer;
        proy:proyecto;
        pos:integer;
    begin
        Assign(proyectos,'data/proyectos.dat');
        reset(proyectos);
        write(' PROYECTOS TOTALMENTE VENDIDOS: ');
        WriteLn(' ');
        pos:=a;
        for i:=0 to FileSize(proyectos)-1 do
        begin
            seek(proyectos,i);
            read(proyectos,proy);
            if proy.cantidades[0]=0 then
            begin
                gotoxy(3,pos);write(proy.COD_proy);
                gotoxy(8,pos);write('|');
                assign(empresas,'data/empresas.dat');
                reset(empresas);
                gotoxy(10,pos);write(BuscarNombreEmpresa(proy.COD_emp));
                close(empresas);
                gotoxy(25,pos);write('|');
                gotoxy(26,pos);write(proy.cantidades[2]);
            end;
        end;
        close(proyectos);
        end;

procedure estadisticas();
    begin
        clrscr();
        estadisticasCiudades();
        estadisticasEmpresas();
        readln();
    end;

















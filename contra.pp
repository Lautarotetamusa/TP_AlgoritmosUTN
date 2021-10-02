unit contra;
interface
    function autenticacion(clave:string;menu:integer):boolean;
implementation

    uses crt;
    //Compara la contra para ver si es correcta, devuelve un booleano
    function autenticacion(clave:string;menu:integer):boolean;
    const 
        claveEmpresas:string='empresas';
        claveClientes:string='clientes';
    begin
        case (menu) of
        1:begin
            if clave = claveEmpresas then
                autenticacion:= True
            else
                autenticacion:= False;
        end;
        2:begin
            if clave = claveClientes then
                autenticacion:= True
            else
                autenticacion:= False;
        end;
        end;
    end;    
end.
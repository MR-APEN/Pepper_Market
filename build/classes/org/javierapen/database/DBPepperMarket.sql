 drop database if exists DBPepperMarket;
create database DBPepperMarket;
use DBPepperMarket;

-- set global time_zone = "-06:00";

create table Clientes(
	codigoCliente int not null,
    nitCliente varchar(10) not null,
    nombreCliente varchar(50) not null,
    apellidoCliente varchar(50) not null,
    direccionCliente varchar(150),
    telefonoCliente varchar(8),
    correoCliente varchar(45),
    primary key PK_codigoCliente(codigoCliente)
);

create table Proveedores(
	codigoProveedor int not null,
    nitProveedor varchar(10) not null,
    nombreProveedor varchar(60) not null,
    apellidoProveedor varchar(50) not null,
    direccionProveedor varchar(150),
    razonSocial varchar(60),
    contactoPrincipal varchar(100),
    paginaWeb varchar(50),
    primary key PK_codigoProveedor(codigoProveedor)
);

create table TipoProducto(
	codigoTipoProducto int not null,
    descripcion varchar(45),
    primary key PK_codigoTipoProducto(codigoTipoProducto)
);

create table Compras(
	numeroDocumento int not null,
    fechaDocumento date,
    descripcion varchar(60),
    totalDocumento decimal(10,2),
    primary key PK_numeroDocumento(numeroDocumento)
);

create table CargoEmpleado(
	codigoCargoEmpleado int not null,
    nombreCargo varchar(45),
    descripcionCargo varchar(45),
    primary key PK_codigoCargoEmpleado(codigoCargoEmpleado)
);

create table Empleados(
	codigoEmpleado int not null,
    nombreEmpleado varchar(50),
    apellidoEmpleado varchar(50),
    sueldo decimal (10,2),
    direccion varchar(150),
    turno varchar(15),
    CargoEmpleado_codigoCargoEmpleado int not null,
    constraint FK_CargoEmpleado_CargoEmpleado foreign key (CargoEmpleado_codigoCargoEmpleado) references CargoEmpleado(codigoCargoEmpleado)
);
-- ---------------------------------------------- CLIENTES -----------------------------------------------------------------

Delimiter $$
create procedure sp_AgregarClientes(in codigoCliente int ,nitCliente varchar(10),nombreCliente varchar(50),apellidoCliente varchar(50),direccionCliente varchar(150),telefonoCliente varchar(8),correoCliente varchar(45))
	Begin
		Insert Into Clientes(codigoCliente,nitCliente,nombreCliente,apellidoCliente,direccionCliente,telefonoCliente,correoCliente)
        values (codigoCliente,nitCliente,nombreCliente,apellidoCliente,direccionCliente,telefonoCliente,correoCliente);
	End $$
Delimiter ;

call sp_AgregarClientes(01,'180181','Harol','Luna','San Raymundo','28651030','harol@gmail.com');
call sp_AgregarClientes(02,'117481','Rafael','Samayoa','Amatitlan','0121030','rafa@gmail.com');


Delimiter $$
	create procedure sp_ListarClientes()
    Begin
		select 
        C.codigoCliente,
        C.nitCliente,
        C.nombreCliente,
        C.apellidoCliente,
        C.direccionCliente,
        C.telefonoCliente,
        C.correoCliente
        from Clientes C;
	End $$
Delimiter ;

call sp_ListarClientes();



Delimiter $$
	create procedure sp_BuscarClientes(in  _codigoCliente int)
    Begin
		select 
        C.nitCliente,
        C.nombreCliente,
        C.apellidoCliente,
        C.direccionCliente,
        C.telefonoCliente,
        C.correoCliente
        from Clientes C
        Where codigoCliente = _codigoCliente;
	End $$
Delimiter ;

call sp_BuscarClientes(1);


Delimiter $$
	create procedure sp_EliminarClientes(in _codigoCliente int)
    Begin
		Delete from Clientes
        Where codigoCliente = _codigoCliente;
	End $$
Delimiter ;



Delimiter $$
	create procedure sp_EditarClientes( in _codigoCliente int , _nitCliente varchar(10), _nombreCliente varchar(50), _apellidoCliente varchar(50),
    _direccionCliente varchar(150), _telefonoCliente varchar(8), _correoCliente varchar(45))
    Begin
		Update Clientes C
			set
		C.nitCliente = _nitCliente,
        C.nombreCliente = _nombreCliente,
        C.apellidoCliente = _apellidoCliente,
        C.direccionCliente = _direccionCliente,
        C.telefonoCliente = _telefonoCliente,
        C.correoCliente = _correoCliente
        Where codigoCliente = _codigoCliente;
	End $$
Delimiter ;

-- ---------------------------------------- PROVEEDORES------------------------------
-- ------------------------------------ AGREGAR--------------------------------------
Delimiter $$
	create procedure sp_AgregaProveedores(in codigoProveedor int, nitProveedor varchar(10), nombreProveedor varchar(60), apellidoProveedor varchar(50),
	direccionProveedor varchar(150), razonSocial varchar(60), contactoPrincipal varchar(100), paginaWeb varchar(50))
	Begin
		Insert into proveedores(codigoProveedor,nitProveedor,nombreProveedor,apellidoProveedor,direccionProveedor,razonSocial,contactoPrincipal,paginaWeb)
        values(codigoProveedor,nitProveedor,nombreProveedor,apellidoProveedor,direccionProveedor,razonSocial,contactoPrincipal,paginaWeb);
	End $$
Delimiter ;

call sp_AgregaProveedores(01,"1233","JUAN","LOPEZ","Zona 12 Villa Nueva","Poder ser el mayor distribuidor","JUAN CARLOS 1111-2222","HTTP/COCACOLA");
-- ----------------------------------- LISTAR ---------------------------------------
Delimiter $$
	create procedure sp_ListarProveedores()
    Begin
		Select
        P.codigoProveedor,
        P.nitProveedor,
        P.nombreProveedor,
        P.apellidoProveedor,
        P.direccionProveedor,
        P.razonSocial,
        P.contactoPrincipal,
        P.paginaWeb
        From Proveedores P;
	End $$
Delimiter ;

call sp_ListarProveedores();
-- ----------------------------------- BUSCAR -----------------------------------------
Delimiter $$
	create procedure sp_BuscarProveedores(in _codigoProveedor int)
    Begin
		Select
		P.codigoProveedor,
		P.nitProveedor,
		P.nombreProveedor,
		P.apellidoProveedor,
		P.direccionProveedor,
		P.razonSocial,
		P.contactoPrincipal,
		P.paginaWeb
		From Proveedores P
		Where codigoProveedor = _codigoProveedor;
    End $$
Delimiter ;

-- ---------------------------------- ELIMINAR ---------------------------------------
Delimiter $$
	create procedure sp_EliminarProveedores(in _codigoProveedor int)
    Begin
		Delete from Proveedores
        Where codigoProveedor = _codigoProveedor;
	End $$
Delimiter ;

-- --------------------------------- EDITAR ------------------------------------------
Delimiter $$
	create procedure sp_EditarProveedores(in _codigoProveedor int, _nitProveedor varchar(10), _nombreProveedor varchar(60), _apellidoProveedor varchar(50),
    _direccionProveedor varchar(150), _razonSocial varchar(60), _contactoPrincipal varchar(100), _paginaWeb varchar(50))
    Begin
		Update Proveedores P
        set
        nitProveedor = _nitProveedor,
        nombreProveedor = _nombreProveedor,
        apellidoProveedor = _apellidoProveedor,
        direccionProveedor = _direccionProveedor,
        razonSocial = _razonSocial,
        contactoPrincipal = _contactoPrincipal,
        paginaWeb = _paginaWeb
        Where codigoProveedor = _codigoProveedor;
	End $$
Delimiter ;
        
--  ------------------------------------------ TIPO PRODUCTO ---------------------------------------------
-- ------------------------------------ AGREGAR--------------------------------------
Delimiter $$
	create procedure sp_AgregarTipoProducto(in codigoTipoProducto int , descripcion varchar(45))
	Begin
		Insert into tipoproducto(codigoTipoProducto,descripcion) values
        (codigoTipoProducto,descripcion);
	End $$
Delimiter ;

call sp_AgregarTipoProducto(01,"Manzana Verde de EEUU");

-- ----------------------------------- LISTAR ---------------------------------------
Delimiter $$
	create procedure sp_ListarTipoProducto()
    Begin
		Select 
        TP.codigoTipoProducto,
        TP.descripcion
        From tipoproducto TP;
	End $$
Delimiter ;

-- ----------------------------------- BUSCAR -----------------------------------------
Delimiter $$
	create procedure sp_BuscarTipoProducto(in codigoTipoProducto int)
    Begin
		Select
        TP.descripcion
        From tipoproducto TP
        Where codigoTipoProducto = codigoTipoProducto;
	End $$
Delimiter ;

-- ---------------------------------- ELIMINAR ---------------------------------------
Delimiter $$
	create procedure sp_EliminarTipoProducto(in codigoTipoProducto int)
    Begin
		Delete from tipoproducto
        Where codigoTipoProducto = codigoTipoProducto;
	End $$
Delimiter ;

-- --------------------------------- EDITAR ------------------------------------------
Delimiter $$
	create procedure sp_EditarTipoProducto(in _codigoTipoProducto int, _descripcion varchar(45))
    Begin
		Update TipoProducto
        set 
        descripcion = _descripcion
        Where codigoTipoProducto = _codigoTipoProducto;
	End $$
Delimiter ;

-- ---------------------------------------- COMPRAS ------------------------------
-- ------------------------------------ AGREGAR--------------------------------------
Delimiter $$
	create procedure sp_AgregarCompras(in numeroDocumento int, fechaDocumento date, descripcion varchar(60),totalDocumento decimal(10,2))
    Begin
		Insert into compras(numeroDocumento,fechaDocumento,descripcion,totalDocumento)
        values (numeroDocumento,fechaDocumento,descripcion,totalDocumento);
	End $$
Delimiter ;

call sp_AgregarCompras(01,"2024-02-12","Paquete de manzanas",199.99);
call sp_AgregarCompras(02,"2024-01-05","Paquete de mangos",149.99);

-- ----------------------------------- LISTAR ---------------------------------------
Delimiter $$
	create procedure sp_ListarCompras()
	Begin
		Select
        C.numeroDocumento,
        C.fechaDocumento,
        C.descripcion,
        C.totalDocumento
        From Compras C;
	End $$
Delimiter ;

-- ----------------------------------- BUSCAR -----------------------------------------
Delimiter $$
	create procedure sp_BuscarCompras(in numeroDocumento int)
    Begin
		Select
        C.fechaDocumento,
        C.descripcion,
        C.totalDocumento
        From Compras C
        Where numeroDocumento = numeroDocumento;
	End $$
Delimiter ;

-- ---------------------------------- ELIMINAR ---------------------------------------
Delimiter $$
	create procedure sp_EliminarCompras(in _numeroDocumento int)
    Begin
		Delete from Compras
        Where numeroDocumento = _numeroDocumento;
	End $$
Delimiter ;

-- --------------------------------- EDITAR ------------------------------------------
Delimiter $$
	create procedure sp_EditarCompras(in _numeroDocumento int, _fechaDocumento date, _descripcion varchar(60), _totalDocumento decimal(10,2))
    Begin
		Update Compras
        set
        fechaDocumento = _fechaDocumento,
        descripcion = _descripcion,
        totalDocumento = _totalDocumento
        Where numeroDocumento = _numeroDocumento;
	End $$
Delimiter ;

-- ---------------------------------------- CARGO EMPLEADO ------------------------------
-- ------------------------------------ AGREGAR--------------------------------------
Delimiter $$
	create procedure sp_AgregarCargoEmpleado(in codigoCargoEmpleado int, nombreCargo varchar(45),descripcionCargo varchar(45))
    Begin
		Insert into cargoempleado(codigoCargoEmpleado,nombreCargo,descripcionCargo)
        values (codigoCargoEmpleado,nombreCargo,descripcionCargo);
	End $$
Delimiter ;

call sp_AgregarCargoEmpleado(01,"Gerente Administrativo","Control del local");
-- ----------------------------------- LISTAR ---------------------------------------
Delimiter $$
	create procedure sp_ListarCargoEmpleado()
    Begin
		Select
        CE.codigoCargoEmpleado,
        CE.nombreCargo,
        CE.descripcionCargo
        From cargoempleado CE;
	End $$
Delimiter ;

-- ----------------------------------- BUSCAR -----------------------------------------
Delimiter $$
	create procedure sp_BuscarCargoEmpleado(in _codigoCargoEmpleado int)
    Begin
		Select
        CE.nombreCargo,
        CE.descripcionCargo
        From CargoEmpleado CE
        Where codigoCargoEmpleado = _codigoCargoEmpleado;
	End $$
Delimiter ;

-- ---------------------------------- ELIMINAR ---------------------------------------

Delimiter $$
	create procedure sp_EliminarCargoEmpleado(in _codigoCargoEmpleado int)
    Begin
		Delete from CargoEmpleado
        Where codigoCargoEmpleado = _codigoCargoEmpleado;
	End $$
Delimiter ;

-- --------------------------------- EDITAR ------------------------------------------
Delimiter $$
	create procedure sp_EditarCargoEmpleado(in _codigoCargoEmpleado int, _nombreCargo varchar(45), _descripcionCargo varchar(45))
	Begin
		Update CargoEmpleado
        set
        nombreCargo = _nombreCargo,
        descripcionCargo = _descripcionCargo
        Where codigoCargoEmpleado = _codigoCargoEmpleado;
	End $$
Delimiter ;


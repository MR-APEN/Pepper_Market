	drop database if exists DBPepperMarket;
create database DBPepperMarket;
use DBPepperMarket;

 set global time_zone = "-06:00";

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
    codigoCargoEmpleado int not null,
    primary key PK_codigoEmpleados(codigoEmpleado),
    constraint FK_CargoEmpleado_CargoEmpleado foreign key (codigoCargoEmpleado) references CargoEmpleado(codigoCargoEmpleado)
);

create table Productos(
	codigoProducto varchar(15),
    descripcionProducto varchar(45),
    precioUnitario decimal(10,2),
    precioDocena decimal(10,2),
    precioMayor decimal(10,2),
	existencia int,
    codigoTipoProducto int,
    codigoProveedor int,
    primary key PK_codigoProducto(codigoProducto),
    constraint FK_Productos_TipoProducto foreign key (codigoTipoProducto)  references TipoProducto(codigoTipoProducto),
    constraint FK_Productos_Proveedores foreign key (codigoProveedor) references Proveedores(codigoProveedor)    
);

create table DetalleCompra(
	codigoDetalleCompra int,
    costoUnitario decimal(10,2),
    cantidad int,
    codigoProducto varchar(15),
    numeroDocumento int,
    primary key PK_codigoDetalleCompra(codigoDetalleCompra),
    constraint FK_DetalleCompra_Productos foreign key (codigoProducto) references Productos(codigoProducto),
    constraint FK_DetalleCompra_Compras foreign key (numeroDocumento) references Compras(numeroDocumento)
);

create table TelefonoProveedor(
	codigoTelefonoProveedor int,
    numeroPrincipal varchar(8),
    numeroSecundario varchar(8),
    observaciones varchar(45),
    codigoProveedor int,
    primary key PK_codigoTelefonoProveedor(codigoTelefonoProveedor),
    constraint FK_TelefonoProveedor_Proveedores foreign key (codigoProveedor) references Proveedores(codigoProveedor)
);

create table EmailProveedor(
	codigoEmailProveedor int,
    emailProveedor varchar(50),
    descripcion varchar(100),
    codigoProveedor int,
    primary key PK_codigoEmailProveedor(codigoEmailProveedor),
    constraint FK_EmailProveedor_Proveedores foreign key (codigoProveedor) references Proveedores(codigoProveedor)
);

create table Factura(
	numeroFactura int,
    estado varchar(50),
    totalFactura decimal(10,2),
    fechaFactura varchar(45),
    codigoCliente int,
    codigoEmpleado int,
    primary key PK_numeroFactura(numeroFactura),
    constraint FK_Factura_Clientes foreign key (codigoCliente) references Clientes(codigoCliente),
    constraint FK_Factura_Empleados foreign key (codigoEmpleado) references Empleados(codigoEmpleado)
);

create table DetalleFactura(
	codigoDetalleFactura int,
    precioUnitario decimal(10,2),
    cantidad int,
    numeroFactura int,
    codigoProducto varchar(15),
    primary key PK_codigoDetalleFactura (codigoDetalleFactura),
    constraint FK_DetalleFactura_Factura  foreign key (numeroFactura) references Factura(numeroFactura),
    constraint FK_DetalleFactura_Productos foreign key (codigoProducto) references Productos(codigoProducto)
);

create table Usuarios(
	nombreUsuario varchar(45) not null,
    contrasena varchar(100) not null,
    primary key PK_nombreUsuario(nombreUsuario)
);

-- ---------------------------------------------- CLIENTES -----------------------------------------------------------------

Delimiter $$
create procedure sp_AgregarClientes(in codigoCliente int ,nitCliente varchar(10),nombreCliente varchar(50),apellidoCliente varchar(50),direccionCliente varchar(150),telefonoCliente varchar(8),correoCliente varchar(45))
	Begin
		Insert Into Clientes(codigoCliente,nitCliente,nombreCliente,apellidoCliente,direccionCliente,telefonoCliente,correoCliente)
        values (codigoCliente,nitCliente,nombreCliente,apellidoCliente,direccionCliente,telefonoCliente,correoCliente);
	End $$
Delimiter ;


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
        C.codigoCliente,
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
	create procedure sp_BuscarTipoProducto(in _codigoTipoProducto int)
    Begin
		Select
        TP.codigoTipoProducto,
        TP.descripcion
        From tipoproducto TP
        Where codigoTipoProducto = _codigoTipoProducto;
	End $$
Delimiter ;

-- ---------------------------------- ELIMINAR ---------------------------------------
Delimiter $$
	create procedure sp_EliminarTipoProducto(in codigoTipoProducto int)
    Begin
		Delete from tipoproducto 
        Where TP.codigoTipoProducto = codigoTipoProducto;
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
	create procedure sp_BuscarCompras(in _numeroDocumento int)
    Begin
		Select
        C.numeroDocumento,
        C.fechaDocumento,
        C.descripcion,
        C.totalDocumento
        From Compras C
        Where numeroDocumento = _numeroDocumento;
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
		CE.codigoCargoEmpleado,
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

-- ---------------------------------------- PRODUCTOS ------------------------------
-- ------------------------------------ AGREGAR--------------------------------------
Delimiter $$
	create procedure sp_AgregarProductos(in codigoProducto varchar(15), descripcionProducto varchar(45), precioUnitario decimal(10,2), precioDocena decimal(10,2)
    , precioMayor decimal(10,2), existencia int, codigoTipoProducto int, codigoProveedor int)
    Begin
		Insert into Productos (codigoProducto,descripcionProducto,precioUnitario,precioDocena,precioMayor,existencia,codigoTipoProducto,codigoProveedor)
        values (codigoProducto,descripcionProducto,precioUnitario,precioDocena,precioMayor,existencia,codigoTipoProducto,codigoProveedor);
	End $$
Delimiter ;

-- ----------------------------------- LISTAR ---------------------------------------
Delimiter $$
	create procedure sp_ListarProductos()
    Begin
		Select
        P.codigoProducto,
        P.descripcionProducto,
        P.precioUnitario,
        P.precioDocena,
        P.precioMayor,
        P.existencia,
        P.codigoTipoProducto,
        P.codigoProveedor
        From Productos P;
	End $$
Delimiter ;

-- ----------------------------------- BUSCAR -----------------------------------------
Delimiter $$
	create procedure sp_BuscarProductos(in _codigoProducto varchar(15))
    Begin
		Select 
        P.codigoProducto,
        P.descripcionProducto,
        P.precioUnitario,
        P.precioDocena,
        P.precioMayor,
        P.existencia,
        P.codigoTipoProducto,
        P.codigoProveedor
        From Productos P
        Where codigoProducto = _codigoProducto;
	End $$
Delimiter ;

-- ---------------------------------- ELIMINAR ---------------------------------------
Delimiter $$
	create procedure sp_EliminarProductos(in _codigoProducto varchar(15))
    Begin
		Delete from Productos
        Where codigoProducto = _codigoProducto;
	End $$
Delimiter ;

-- --------------------------------- EDITAR ------------------------------------------
Delimiter $$
	create procedure sp_EditarProductos(in _codigoProducto varchar(15), _descripcionProducto varchar(45), _precioUnitario decimal(10,2), _precioDocena decimal(10,2),
    _precioMayor decimal(10,2), _existencia int, _codigoTipoProducto int , _codigoProveedor int)
    Begin
		Update Productos
        set
        descripcionProducto = _descripcionProducto,
        precioUnitario = _precioUnitario,
        precioDocena = _precioDocena,
        precioMayor = _precioMayor,
        existencia = _existencia,
        codigoTipoProducto = _codigoTipoProducto,
        codigoProveedor = _codigoProveedor
        Where codigoProducto = _codigoProducto;
	End $$
Delimiter ;

-- ----------------------------------- DETALLE COMPRAS ----------------------------------------
-- ----------------------------------- AGREGAR ------------------------------------
Delimiter $$
	create procedure sp_AgregarDetalleCompras(in codigoDetalleCompra int, costoUnitario decimal(10,2), cantidad int, codigoProducto varchar(15), numeroDocumento int)
    Begin
		Insert into DetalleCompra(codigoDetalleCompra,costoUnitario,cantidad,codigoProducto,numeroDocumento)
        values (codigoDetalleCompra,costoUnitario,cantidad,codigoProducto,numeroDocumento);
	End $$
Delimiter ;

-- ----------------------------------- LISTAR ---------------------------------------
Delimiter $$
	create procedure sp_ListarDetalleCompra()
    Begin
		Select
        DC.codigoDetalleCompra,
        DC.costoUnitario,
        DC.cantidad,
        DC.codigoProducto,
        DC.numeroDocumento
        From DetalleCompra DC;
	End $$
Delimiter ;

-- ----------------------------------- BUSCAR -----------------------------------------
Delimiter $$
	create procedure sp_BuscarDetalleCompra(in _codigoDetalleCompra int)
    Begin
		Select 
		DC.costoUnitario,
        DC.cantidad,
        DC.codigoProducto,
        DC.numeroDocumento
        From DetalleCompra DC
        Where codigoDetalleCompra = codigoDetalleCompra;
	End $$
Delimiter ;

-- ---------------------------------- ELIMINAR ---------------------------------------
Delimiter $$
	create procedure sp_EliminarDetalleCompra(in _codigoDetalleCompra int)
    Begin
		Delete from DetalleCompra 
        Where codigoDetalleCompra = _codigoDetalleCompra;
	End $$
Delimiter ;

-- --------------------------------- EDITAR ------------------------------------------
Delimiter $$
	create procedure sp_EditarDetalleCompra(in _codigoDetalleCompra int, _costoUnitario decimal(10,2), _cantidad int, _codigoProducto varchar(15), _numeroDocumento int)
    Begin
		Update DetalleCompra DC
        set
		costoUnitario = _costoUnitario,
        cantidad = _cantidad,
        codigoProducto = _codigoProducto,
        numeroDocumento = _numeroDocumento
        Where codigoDetalleCompra = _codigoDetalleCompra;
	End $$
Delimiter ;

-- ----------------------------------- FACTURA ----------------------------------------
-- ----------------------------------- AGREGAR ------------------------------------
Delimiter $$
	create procedure sp_AgregarFactura(in numeroFactura int, estado varchar(50), totalFactura decimal(10,2), fechaFactura varchar(45), codigoCliente int, codigoEmpleado int)
    Begin
		Insert into Factura(numeroFactura,estado,totalFactura,fechaFactura,codigoCliente,codigoEmpleado)
        values(numeroFactura,estado,totalFactura,fechaFactura,codigoCliente,codigoEmpleado);
	End $$
Delimiter ;

-- ----------------------------------- LISTAR ---------------------------------------
Delimiter $$
	create procedure sp_ListarFactura()
    Begin
		Select
		F.numeroFactura,
		F.estado,
		F.totalFactura,
		F.fechaFactura,
		F.codigoCliente,
		F.codigoEmpleado
		From Factura F;
    End $$
Delimiter ;

-- ----------------------------------- BUSCAR -----------------------------------------
Delimiter $$
	create procedure sp_BuscarFactura(in numeroFactura int)
    Begin
		Select
        F.numeroFactura,
		F.estado,
		F.totalFactura,
		F.fechaFactura,
		F.codigoCliente,
		F.codigoEmpleado
		From Factura F 
        Where numeroFactura = numeroFactura;
	End $$
Delimiter ;
        
-- ---------------------------------- ELIMINAR ---------------------------------------
Delimiter $$
	create procedure sp_EliminarFactura(in numeroFactura int)
    Begin
		Delete from Factura 
        Where numeroFactura = numeroFactura;
	End $$
Delimiter ;

-- --------------------------------- EDITAR ------------------------------------------
Delimiter $$
	create procedure sp_EditarFactura(in _numeroFactura int, _estado varchar(50), _totalFactura decimal(10,2), _fechaFactura varchar(45), _codigoCliente int, _codigoEmpleado int)
    Begin
		Update Factura 
        set
        estado = _estado,
        totalFactura = _totalFactura,
        fechaFactura = _fechaFactura,
        codigoCliente = _codigoCliente,
        codigoEmpleado = _codigoEmpleado
        Where numeroFactura = _numeroFactura;
	End $$
Delimiter ;

-- ----------------------------------- EMAIL PROVEEDOR ----------------------------------------
-- ----------------------------------- AGREGAR ------------------------------------
Delimiter $$
	create procedure sp_AgregarEmailProveedor(in codigoEmailProveedor int, emailProveedor varchar(45), descripcion varchar(100), codigoProveedor int)
    Begin
		Insert into EmailProveedor(codigoEmailProveedor,emailProveedor,descripcion,codigoProveedor)
        values (codigoEmailProveedor,emailProveedor,descripcion,codigoProveedor);
	End $$
Delimiter ;

-- ----------------------------------- LISTAR ---------------------------------------
Delimiter $$
	create procedure sp_ListarEmailProveedor()
	Begin
		Select
		EP.codigoEmailProveedor,
        EP.emailProveedor,
        EP.descripcion,
        EP.codigoProveedor
		From EmailProveedor EP;
	End $$
Delimiter ;

-- ----------------------------------- BUSCAR -----------------------------------------
Delimiter $$
	create procedure sp_BuscarEmailProveedor(in codigoEmailProveedor int)
	Begin
		Select
        EP.codigoEmailProveedor,
        EP.emailProveedor,
        EP.descripcion,
        EP.codigoProveedor
		From EmailProveedor EP
        Where codigoEmailProveedor = codigoEmailProveedor;
	End $$
Delimiter ;

-- ---------------------------------- ELIMINAR ---------------------------------------
Delimiter $$
	create procedure sp_EliminarEmailProveedor(in _codigoEmailProveedor int)
    Begin
		Delete from EmailProveedor
        Where codigoEmailProveedor = _codigoEmailProveedor;
	End $$
Delimiter ;

-- --------------------------------- EDITAR ------------------------------------------
Delimiter $$
	create procedure sp_EditarEmailProveedor(in _codigoEmailProveedor int, _emailProveedor varchar(45), _descripcion varchar(100), _codigoProveedor int)
    Begin
		Update EmailProveedor
        set 
        emailProveedor = _emailProveedor,
        descripcion = _descripcion,
        codigoProveedor = _codigoProveedor
        Where codigoEmailProveedor = _codigoEmailProveedor;
	End $$
Delimiter ;

-- -----------------------------------  EMPLEADOS ----------------------------------------
-- ----------------------------------- AGREGAR ------------------------------------
Delimiter $$
	create procedure sp_AgregarEmpleados(in codigoEmpleado int,in nombreEmpleado varchar(50), in apellidoEmpleado varchar(50), in sueldo decimal(10,2),  in direccion varchar(150), in turno varchar(15), in codigoCargoEmpleado int)
    Begin
		Insert into Empleados(codigoEmpleado,nombreEmpleado,apellidoEmpleado,sueldo,direccion,turno,codigoCargoEmpleado)
			values(codigoEmpleado,nombreEmpleado,apellidoEmpleado,sueldo,direccion,turno,codigoCargoEmpleado);
    End $$
Delimiter ;

-- ----------------------------------- LISTAR ---------------------------------------
Delimiter $$
	create procedure sp_ListarEmpleados()
    Begin
		Select
			E.codigoEmpleado,
            E.nombreEmpleado,
            E.apellidoEmpleado,
            E.sueldo,
            E.direccion,
            E.turno,
            E.codigoCargoEmpleado
		from Empleados E;
    End $$
Delimiter ;

-- ----------------------------------- BUSCAR -----------------------------------------
Delimiter $$
	create procedure sp_BuscarEmpleados(in _codigoEmpleado int)
	Begin
		Select
			E.codigoEmpleado,
            E.nombreEmpleado,
            E.apellidoEmpleado,
            E.sueldo,
            E.direccion,
            E.turno,
            E.codigoCargoEmpleado
		from Empleados E
        where E.codigoEmpleado = _codigoEmpleado;
    End $$
Delimiter ;

-- ---------------------------------- ELIMINAR ---------------------------------------
Delimiter $$
	create procedure sp_EliminarEmpleados(in _codigoEmpleado int)
    Begin
		Delete from Empleados
        where codigoEmpleado = _codigoEmpleado;
    End $$
Delimiter ;

-- --------------------------------- EDITAR ------------------------------------------
Delimiter $$
	create procedure sp_EditarEmpleados(in _codigoEmpleado int,in _nombreEmpleado varchar(50), in _apellidoEmpleado varchar(50), in _sueldo decimal(10,2),  in _direccion varchar(150), in _turno varchar(15), in _codigoCargoEmpleado int)
    Begin
		Update Empleados E
        Set
            E.nombreEmpleado = _nombreEmpleado,
            E.apellidoEmpleado = _apellidoEmpleado,
            E.sueldo = _sueldo,
            E.direccion = _direccion,
            E.turno = _turno,
            E.codigoCargoEmpleado = _codigoCargoEmpleado
		where E.codigoEmpleado = _codigoEmpleado;
    End $$
Delimiter ;

-- -----------------------------------  DETALLE FACTURA ----------------------------------------
-- ----------------------------------- AGREGAR ------------------------------------
Delimiter $$
	create procedure sp_AgregarDetalleFactura(in codigoDetalleFactura int, in precioUnitario decimal(10,2), in cantidad int,in numeroFactura int ,in codigoProducto varchar(15))
	Begin
		Insert into DetalleFactura(codigoDetalleFactura,precioUnitario,cantidad,numeroFactura,codigoProducto)
			values(codigoDetalleFactura,precioUnitario,cantidad,numeroFactura,codigoProducto);
    End $$
Delimiter ;

-- ----------------------------------- LISTAR ---------------------------------------
Delimiter $$
	create procedure sp_ListarDetalleFactura()
    Begin
		Select
			DF.codigoDetalleFactura,
			DF.precioUnitario,
            DF.cantidad,
            DF.numeroFactura,
            DF.codigoProducto
         from DetalleFactura DF;   
    End $$
Delimiter ;

-- ----------------------------------- BUSCAR -----------------------------------------
Delimiter $$
	create procedure sp_BuscarDetalleFactura(in _codigoDetalleFactura int)
    Begin
		Select
			DF.codigoDetalleFactura,
			DF.precioUnitario,
            DF.cantidad,
            DF.numeroFactura,
            DF.codigoProducto
         from DetalleFactura DF 
         where DF.codigoDetalleFactura = _codigoDetalleFactura;
    End $$
Delimiter ;

-- ---------------------------------- ELIMINAR ---------------------------------------
Delimiter $$
	create procedure sp_EliminarDetalleFactura(in _codigoDetalleFactura int)
    Begin
		Delete from DetalleFactura
        where codigoDetalleFactura = _codigoDetalleFactura;
    End $$
Delimiter ;

-- --------------------------------- EDITAR ------------------------------------------
Delimiter $$
	create procedure sp_EditarDetalleFactura(in _codigoDetalleFactura int, in _precioUnitario decimal(10,2), in _cantidad int,in _numeroFactura int ,in _codigoProducto varchar(15))
    Begin
		Update DetalleFactura DF
        Set
			DF.precioUnitario = _precioUnitario,
            DF.cantidad = _cantidad,
            DF.numeroFactura = _numeroFactura,
            DF.codigoProducto = _codigoProducto
		where DF.codigoDetalleFactura = _codigoDetalleFactura;
    End $$
Delimiter ;

-- --------------------------------- TELEFONO PROVEEDOR-------------------------------
Delimiter $$
	create procedure sp_AgregarTelefonoProveedor(in codigoTelefonoProveedor int,in numeroPrincipal varchar(8), in numeroSecundario varchar(8), in observaciones varchar(45), in codigoProveedor int)
    Begin
		Insert Into TelefonoProveedor(codigoTelefonoProveedor,numeroPrincipal,numeroSecundario,observaciones,codigoProveedor)
        values (codigoTelefonoProveedor,numeroPrincipal,numeroSecundario,observaciones,codigoProveedor);
    End $$
Delimiter ;

Delimiter $$
	create procedure sp_ListarTelefonoProveedor()
    Begin
		Select
			TP.codigoTelefonoProveedor,
            TP.numeroPrincipal,
            TP.numeroSecundario,
            TP.observaciones,
            TP.codigoProveedor
		from TelefonoProveedor TP;
    End $$
Delimiter ;

Delimiter $$
	create procedure sp_EditarTelefonoProveedor(in _codigoTelefonoProveedor int,in _numeroPrincipal varchar(8), in _numeroSecundario varchar(8), in _observaciones varchar(45), in _codigoProveedor int)
    Begin
		update TelefonoProveedor TP 
			set 
			 TP.numeroPrincipal = _numeroPrincipal,
             TP.numeroSecundario = _numeroSecundario,
			 TP.observaciones = _observaciones,
             TP.codigoProveedor = _codigoProveedor
		    where TP.codigoTelefonoProveedor = _codigoTelefonoProveedor;
    End $$
Delimiter ;

Delimiter $$
	create procedure sp_EliminarTelefonoProveedor(in _codigoTelefonoProveedor int)
    Begin
		Delete From TelefonoProveedor
        where codigoTelefonoProveedor = _codigoTelefonoProveedor;
    End $$
Delimiter ;
-- -------------------------------------------------------------------------------------------------
-- ------------------------------------ USUARIOS ---------------------------------------------------
-- ------------------------------------ AGREGAR ---------------------------------------------------
Delimiter $$
	create procedure sp_AgregarUsuario(in nombreUsuario varchar(45), in contrasena varchar(100))
    Begin
		Insert Into Usuarios(nombreUsuario,contrasena)
			values(nombreUsuario,contrasena);
    End $$
Delimiter ; 

-- ------------------------------------ LISTAR ---------------------------------------------------
Delimiter $$
	create procedure sp_ListarUsuarios()
    Begin
		select 
			U.nombreUsuario,
            U.contrasena
		from Usuarios U;
    End $$
Delimiter ;

-- ------------------------------------ BUSCAR ---------------------------------------------------
Delimiter $$
	create procedure sp_BuscarUsuario(in _nombreUsuario varchar(45))
    Begin
		select 
			U.nombreUsuario,
            U.contrasena
		from Usuarios U
        where U.nombreUsuario = _nombreUsuario;
    End $$
Delimiter ;

-- ------------------------------------ ACTUALIZAR ---------------------------------------------------
Delimiter $$
	create procedure sp_ActualizarUsuario(in _nombreUsuario varchar(45), in _contrasena varchar(100))
    Begin
		update Usuarios U
			set
                U.contrasena = _contrasena
			where U.nombreUsuario = _nombreUsuario;
    End $$
Delimiter ;

-- ------------------------------------ ELIMINAR  ---------------------------------------------------
Delimiter $$
	create procedure sp_EliminarUsuario(in _nombreUsuario varchar(45))
    Begin
		delete from Usuarios 
			where nombreUsuario = _nombreUsuario;
    End $$
Delimiter ;

-- --------------------------------------------------------------------------------

Delimiter $$
	create function fn_CalcularPrecioUnitario( codigoProducto varchar(15)) 
    returns decimal(10,2)
	reads sql data deterministic
    Begin
		DECLARE precioUnitario decimal(10,2);
        Select (DC.costoUnitario) into precioUnitario from  DetalleCompra DC where DC.codigoProducto = codigoProducto;
        
        return precioUnitario + (precioUnitario*0.40);
    End $$
Delimiter ;

Delimiter $$
	create function fn_CalcularPrecioDocena(codigoProducto varchar(15))
    returns decimal(10,2)
    reads sql data deterministic
    Begin
		Declare precioDocena decimal(10,2);
        Select (DC.costoUnitario)
        into precioDocena
        from DetalleCompra DC where DC.codigoProducto = codigoProducto;
        return precioDocena + (precioDocena * 0.35);
    End $$
Delimiter ;

Delimiter $$
	create function fn_CalcularPrecioMayor(codigoProducto varchar(15)) 
    returns decimal(10,2)
    reads sql data deterministic
    Begin
		Declare precioMayor decimal(10,2);
        Select (DC.costoUnitario)
        into precioMayor
        from DetalleCompra DC where DC.codigoProducto = codigoProducto;
        return precioMayor + (precioMayor * 0.25);
    End $$
Delimiter ;


Delimiter $$
	create procedure sp_AsignarPrecios(in codigoProducto varchar(15))
    Begin
		Declare _precioDocena decimal(10,2);
		Declare _precioUnitario decimal(10,2);
        Declare _precioMayor decimal(10,2);
        set _precioMayor = fn_CalcularPrecioMayor(codigoProducto);
        set _precioUnitario = fn_CalcularPrecioUnitario(codigoProducto);
        set _precioDocena = fn_CalcularPrecioDocena(codigoProducto);
        
        Update Productos P
        set
        P.precioUnitario = _precioUnitario,
		P.precioDocena = _precioDocena,
        P.precioMayor = _precioMayor
        where P.codigoProducto = codigoProducto; 
    End $$
Delimiter ;

Delimiter $$
	Create Trigger tr_DetalleCompra_After_Insert
    after Insert on DetalleCompra
    for each row
    Begin
		call sp_AsignarPrecios(new.codigoProducto);
	End $$
Delimiter ;	

Delimiter $$
	create function fn_TotalCompras( numeroDocumento int)
	returns decimal(10,2)
    reads sql data deterministic
    Begin
		declare totalDocumento decimal(10,2);
        Select SUM(DC.costoUnitario * DC.cantidad) into totalDocumento from  DetalleCompra DC where DC.numeroDocumento = numeroDocumento;
		
        return totalDocumento;
	End $$
Delimiter ;


Delimiter $$
	create procedure sp_AsignarTotalCompras(in numeroDocumento int)
    Begin
		Declare _totalDocumento decimal(10,2);
        set _totalDocumento = fn_TotalCompras(numeroDocumento);
        
        Update Compras C
        set
        C.totalDocumento = _totalDocumento
        where C.numeroDocumento = numeroDocumento; 
    End $$
Delimiter ;

Delimiter $$
	create procedure sp_AgregarExistencia(codigoProducto varchar(15),cantidad int)
    Begin
		update Productos P
        set
			P.existencia = cantidad
		where P.codigoProducto = codigoProducto;
    End $$
Delimiter ;

Delimiter $$
	Create Trigger tr_DetalleCompraExistencia_After_Insert
    After Insert on DetalleCompra
    for each row
    Begin
    		call sp_AgregarExistencia(NEW.codigoProducto,NEW.cantidad);
    End $$
Delimiter ;


Delimiter $$
	Create Trigger tr_DetalleComprasTotal_After_Insert
    after Insert on DetalleCompra
    for each row
    Begin
		call sp_AsignarTotalCompras(new.numeroDocumento);
	End $$
Delimiter ;	

Delimiter $$
	create trigger tr_InsertarPrecioDetalelFactura_Before_Insert
    Before insert on DetalleFactura
	for each row
		Begin
			set new.precioUnitario = (Select precioUnitario from Productos
									  Where Productos.codigoProducto = new.codigoProducto);
		End $$
Delimiter ;

Delimiter $$
	create procedure sp_ActualizarTotalFactura(in _numeroFactura int , _totalFactura decimal(10,2))
    Begin
		Update Factura F
        set
		F.totalFactura = _totalFactura
        Where F.numeroFactura = _numeroFactura;
	End $$
Delimiter ;

Delimiter $$
	Create trigger tr_InsertarTotalFactura_Before_Insert
    after insert on DetalleFactura
    for each row
		Begin
			declare total decimal(10,2);
            set total = ((Select sum(precioUnitario*cantidad) from DetalleFactura where DetalleFactura.numeroFactura = new.numeroFactura));
            call sp_ActualizarTotalFactura(new.numeroFactura, total);
		End $$
Delimiter ;

Delimiter $$
	create procedure sp_ListarReporteFactura()
	Begin
		select Factura.numeroFactura, Factura.fechaFactura, Factura.totalFactura,
			   Clientes.nitCliente, Clientes.nombreCliente, Clientes.apellidoCliente,
               Empleados.nombreEmpleado,Empleados.apellidoEmpleado,Empleados.turno,
               Productos.codigoProducto,Productos.descripcionProducto,
               DetalleFactura.precioUnitario,DetalleFactura.cantidad
               from DetalleFactura
               inner join Factura on DetalleFactura.numeroFactura = Factura.numeroFactura
               inner join Productos on Productos.codigoProducto = DetalleFactura.codigoProducto
               inner join Empleados on Empleados.codigoEmpleado = Factura.codigoEmpleado
               inner join Clientes on Clientes.codigoCliente = Factura.codigoCliente;
	End $$
Delimiter ;

Delimiter $$
	create procedure sp_ListarReporteProductos()
    Begin
		select Productos.codigoProducto, Productos.descripcionProducto, Productos.precioUnitario,
        Productos.existencia, Proveedores.nitProveedor
        From Productos 
        inner join Proveedores on Productos.codigoProveedor = Proveedores.codigoProveedor;
	End $$
Delimiter ;
    
call sp_AgregarClientes(01,'180181','Harol Anibal','Luna','San Raymundo','28651030','harol@gmail.com');
call sp_AgregarClientes(02,'117481','Rafael Humberto','Samayoa','Amatitlan','0121030','rafa@gmail.com');
call sp_AgregarClientes(03,'12345678','Juan','Pérez','Calle 123, Ciudad','12345678','juan@example.com');
call sp_AgregarClientes(04, '1002003004', 'Javier', 'García', 'Calle 89 #12-34, Ciudad', '45678901', 'javier.garcia@example.com');
call sp_AgregarClientes(05, '1002003005', 'Sofía', 'López', 'Avenida 34 #56-78, Ciudad', '56789012', 'sofia.lopez@example.com');
call sp_AgregarClientes(06, '1002003006', 'Daniel', 'Ramírez', 'Carrera 45 #67-89, Ciudad', '67890123', 'daniel.ramirez@example.com');
call sp_AgregarClientes(07, '1002003007', 'Valeria', 'Pérez', 'Calle 56 #78-90, Ciudad', '78901234', 'valeria.perez@example.com');
call sp_AgregarClientes(08, '1002003008', 'José', 'Rodríguez', 'Avenida 23 #45-67, Ciudad', '89012345', 'jose.rodriguez@example.com');
call sp_AgregarClientes(09, '1002003009', 'Camila', 'Sánchez', 'Carrera 78 #12-34, Ciudad', '90123456', 'camila.sanchez@example.com');
call sp_AgregarClientes(10, '1002003010', 'David', 'Gómez', 'Calle 12 #34-56, Ciudad', '01234567', 'david.gomez@example.com');


call sp_AgregarCargoEmpleado(1, 'Gerente General', 'Lidera la empresa');
call sp_AgregarCargoEmpleado(2, 'Director de Finanzas', 'Gestiona las finanzas');
call sp_AgregarCargoEmpleado(3, 'Director de Recursos Humanos', 'Gestiona el personal');
call sp_AgregarCargoEmpleado(4, 'Jefe de Ventas', 'Coordina el equipo de ventas');
call sp_AgregarCargoEmpleado(5, 'Jefe de Marketing', 'Dirige las estrategias de marketing');
call sp_AgregarCargoEmpleado(6, 'Desarrollador de Software', 'Desarrolla aplicaciones');
call sp_AgregarCargoEmpleado(7, 'Analista de Datos', 'Analiza los datos de la empresa');
call sp_AgregarCargoEmpleado(8, 'Soporte Técnico', 'Proporciona soporte técnico');
call sp_AgregarCargoEmpleado(9, 'Representante de Ventas', 'Gestiona las ventas con clientes');
call sp_AgregarCargoEmpleado(10, 'Asistente Administrativo', 'Apoya en tareas administrativas');

call sp_AgregarTipoProducto(1, 'Frutas');
call sp_AgregarTipoProducto(2, 'Carnes');
call sp_AgregarTipoProducto(3, 'Ropa');
call sp_AgregarTipoProducto(4, 'Bebidas');
call sp_AgregarTipoProducto(5, 'Panadería');
call sp_AgregarTipoProducto(6, 'Verduras');
call sp_AgregarTipoProducto(7, 'Pescados');
call sp_AgregarTipoProducto(8, 'Dulces');
call sp_AgregarTipoProducto(9, 'Condimentos');
call sp_AgregarTipoProducto(10, 'Cereales');

call sp_AgregaProveedores(01,"12334503","JUAN","LOPEZ","Zona 12 Villa Nueva","FRUTAS.SA","JUAN CARLOS 1111-2222","HTTPS/FRUTS");
call sp_AgregaProveedores(02, '0987654321', 'María', 'Pérez', 'Avenida 12 #34-56, Ciudad', 'Distribuciones Pérez', 'contacto@distribucionesperez.com', 'www.distribucionesperez.com');
call sp_AgregaProveedores(03, '1122334455', 'Juan', 'Martínez', 'Calle 45 #67-89, Ciudad', 'Suministros Martínez', 'contacto@suministrosmartinez.com', 'www.suministrosmartinez.com');
call sp_AgregaProveedores(04, '2233445566', 'Ana', 'López', 'Carrera 78 #12-34, Ciudad', 'López y Cía', 'contacto@lopezcia.com', 'www.lopezcia.com');
call sp_AgregaProveedores(05, '3344556677', 'Luis', 'Hernández', 'Calle 89 #23-45, Ciudad', 'Hernández Proveedores', 'contacto@hernandezproveedores.com', 'www.hernandezproveedores.com');
call sp_AgregaProveedores(06, '4455667788', 'Laura', 'García', 'Avenida 56 #78-90, Ciudad', 'García Distribuciones', 'contacto@garciadistribuciones.com', 'www.garciadistribuciones.com');
call sp_AgregaProveedores(07, '5566778899', 'Jorge', 'Rodríguez', 'Carrera 12 #34-56, Ciudad', 'Rodríguez y Asociados', 'contacto@rodriguezyasociados.com', 'www.rodriguezyasociados.com');
call sp_AgregaProveedores(08, '6677889900', 'Isabel', 'Ramírez', 'Calle 78 #12-34, Ciudad', 'Ramírez Servicios', 'contacto@ramirezservicios.com', 'www.ramirezservicios.com');
call sp_AgregaProveedores(09, '7788990011', 'Roberto', 'Sánchez', 'Avenida 34 #56-78, Ciudad', 'Sánchez Proveedores', 'contacto@sanchezproveedores.com', 'www.sanchezproveedores.com');
call sp_AgregaProveedores(10, '8899001122', 'Elena', 'Torres', 'Carrera 45 #67-89, Ciudad', 'Torres Suministros', 'contacto@torressuministros.com', 'www.torressuministros.com');

call sp_AgregarTelefonoProveedor(1, '12345678', '87654321', 'Teléfono principal y secundario', 1);
call sp_AgregarTelefonoProveedor(2, '23456789', '98765432', 'Teléfono principal y secundario', 2);
call sp_AgregarTelefonoProveedor(3, '34567890', '09876543', 'Teléfono principal y secundario', 3);
call sp_AgregarTelefonoProveedor(4, '45678901', '10987654', 'Teléfono principal y secundario', 4);
call sp_AgregarTelefonoProveedor(5, '56789012', '21098765', 'Teléfono principal y secundario', 5);
call sp_AgregarTelefonoProveedor(6, '67890123', '32109876', 'Teléfono principal y secundario', 6);
call sp_AgregarTelefonoProveedor(7, '78901234', '43210987', 'Teléfono principal y secundario', 7);
call sp_AgregarTelefonoProveedor(8, '89012345', '54321098', 'Teléfono principal y secundario', 8);
call sp_AgregarTelefonoProveedor(9, '90123456', '65432109', 'Teléfono principal y secundario', 9);
call sp_AgregarTelefonoProveedor(10, '01234567', '76543210', 'Teléfono principal y secundario', 10);

call sp_AgregarCompras(1, '2024-01-01', 'Compra de camiseta', 0.00);
call sp_AgregarCompras(2, '2024-01-05', 'Compra de jeans', 0.00);
call sp_AgregarCompras(3, '2024-01-10', 'Compra de gorra', 0.00);
call sp_AgregarCompras(4, '2024-01-15', 'Compra de platanos', 0.00);
call sp_AgregarCompras(5, '2024-01-20', 'Compra de naranjas', 0.00);
call sp_AgregarCompras(6, '2024-01-25', 'Compra de uvas', 0.00);
call sp_AgregarCompras(7, '2024-01-30', 'Compra de fresas', 0.00);
call sp_AgregarCompras(8, '2024-02-04', 'Compra de Pechuga de pollo', 0.00);
call sp_AgregarCompras(9, '2024-02-09', 'Compra de carne', 0.00);
call sp_AgregarCompras(10, '2024-02-14', 'Compra de chuletas', 0.00);

call sp_AgregarProductos('P001', 'Camiseta básica', 0.00, 0.00, 0.00, 0,3,1);
call sp_AgregarProductos('P002', 'Jeans clásicos', 0.00, 0.00, 0.00, 0,3,3);
call sp_AgregarProductos('P003', 'Gorra ajustable', 0.00, 0.00, 0.00, 0,3,4);
call sp_AgregarProductos('P004', 'Plátanos', 0.00, 0.00, 0.00, 0,1,2);
call sp_AgregarProductos('P005', 'Naranjas', 0.00, 0.00, 0.00, 0,1,5);
call sp_AgregarProductos('P006', 'Uvas', 0.00, 0.00, 0.00, 0,1,6);
call sp_AgregarProductos('P007', 'Fresas', 0.00, 0.00, 0.00, 0,1,7);
call sp_AgregarProductos('P008', 'Pechuga de pollo', 0.00, 0.00, 0.00, 0,2,8);
call sp_AgregarProductos('P009', 'Carne de res', 0.00, 0.00, 0.00, 0,2,9);
call sp_AgregarProductos('P010', 'Chuletas de cerdo', 0.00, 0.00, 0.00, 0,2,10);

call sp_AgregarDetalleCompras(1, 25.00, 10, 'P001', 1);
call sp_AgregarDetalleCompras(2, 35.50, 5, 'P002', 2);
call sp_AgregarDetalleCompras(3, 15.00, 20, 'P003', 3);
call sp_AgregarDetalleCompras(4, 12.75, 25, 'P004', 4);
call sp_AgregarDetalleCompras(5, 5.00, 40, 'P005', 5);
call sp_AgregarDetalleCompras(6, 20.00, 10, 'P006', 6);
call sp_AgregarDetalleCompras(7, 25.50, 8, 'P007', 7);
call sp_AgregarDetalleCompras(8, 18.00, 12, 'P008', 8);
call sp_AgregarDetalleCompras(9, 7.50, 35, 'P009', 9);
call sp_AgregarDetalleCompras(10, 30.00, 15, 'P010', 10);

call sp_AgregarEmpleados(1, 'Juan', 'Gómez', 1500.00, 'Calle Principal 123', 'Mañana', 1);
call sp_AgregarEmpleados(2, 'María', 'López', 1600.00, 'Avenida Central 456', 'Tarde', 2);
call sp_AgregarEmpleados(3, 'Carlos', 'Martínez', 1400.00, 'Carrera 7 Este 789', 'Noche', 3);
call sp_AgregarEmpleados(4, 'Ana', 'Rodríguez', 1700.00, 'Calle 10 Sur 234', 'Mañana', 4);
call sp_AgregarEmpleados(5, 'Pedro', 'García', 1550.00, 'Avenida Norte 567', 'Tarde', 5);
call sp_AgregarEmpleados(6, 'Luisa', 'Pérez', 1450.00, 'Calle 20 Oeste 890', 'Noche', 6);
call sp_AgregarEmpleados(7, 'Laura', 'González', 1600.00, 'Avenida 30 Norte 123', 'Mañana', 7);
call sp_AgregarEmpleados(8, 'Javier', 'Hernández', 1650.00, 'Carrera 15 Este 456', 'Tarde', 8);
call sp_AgregarEmpleados(9, 'Sofía', 'Díaz', 1550.00, 'Calle 25 Sur 789', 'Noche', 9);
call sp_AgregarEmpleados(10, 'Daniel', 'Sanchez', 1700.00, 'Avenida 40 Norte 234', 'Mañana', 10);

call sp_AgregarFactura(1, 'Pagada', 0.00, '2024-06-14', 1, 1);
call sp_AgregarFactura(2, 'Pendiente', 0.00, '2024-06-13', 2, 2);
call sp_AgregarFactura(3, 'Anulada', 0.00, '2024-06-12', 3, 3);
call sp_AgregarFactura(4, 'Pagada', 0.00, '2024-06-11', 4, 4);
call sp_AgregarFactura(5, 'Pendiente', 0.00, '2024-06-10', 5, 5);

call sp_AgregarDetalleFactura(01,0.00,3,01,"P001");
call sp_AgregarDetalleFactura(02,0.00,5,01,"P002");
call sp_AgregarDetalleFactura(03,0.00,6,02,"P003");
call sp_AgregarDetalleFactura(04,0.00,2,02,"P004");
call sp_AgregarDetalleFactura(05,0.00,2,05,"P005");

call sp_AgregarEmailProveedor(1, 'contacto1@proveedor.com', 'Email principal del proveedor 1', 1);
call sp_AgregarEmailProveedor(2, 'ventas1@proveedor.com', 'Email de ventas del proveedor 1', 1);
call sp_AgregarEmailProveedor(3, 'contacto2@proveedor.com', 'Email principal del proveedor 2', 2);
call sp_AgregarEmailProveedor(4, 'ventas2@proveedor.com', 'Email de ventas del proveedor 2', 2);
call sp_AgregarEmailProveedor(5, 'contacto3@proveedor.com', 'Email principal del proveedor 3', 3);
call sp_AgregarEmailProveedor(6, 'ventas3@proveedor.com', 'Email de ventas del proveedor 3', 3);

call sp_AgregarUsuario("japen","2023128");


call sp_ListarProductos();
call sp_ListarCompras();
call sp_ListarEmpleados();
call sp_ListarTelefonoProveedor();
call sp_ListarReporteFactura();
call sp_ListarReporteProductos();
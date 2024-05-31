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
		Delete from tipoproducto TP
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
		Delete from DetalleCompra DC
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
		Delete from Factura F
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

call sp_AgregarClientes(01,'180181','Harol','Luna','San Raymundo','28651030','harol@gmail.com');
call sp_AgregarClientes(02,'117481','Rafael','Samayoa','Amatitlan','0121030','rafa@gmail.com');

call sp_AgregarCargoEmpleado(01,"Gerente Administrativo","Control del local");

call sp_AgregarTipoProducto(01,"Manzana Verde de EEUU");
call sp_AgregaProveedores(01,"1233","JUAN","LOPEZ","Zona 12 Villa Nueva","Poder ser el mayor distribuidor","JUAN CARLOS 1111-2222","HTTP/COCACOLA");
call sp_AgregarTelefonoProveedor(01,"11112222","33335555","Todo Bien",01);

call sp_AgregarCompras(01,"2024-02-12","Paquete de manzanas",199.99);
call sp_AgregarCompras(02,"2024-01-05","Paquete de mangos",149.99);

call sp_AgregarProductos("ABC123","Manzana Verde",0.00,0.00,0.00,15,1,1);
call sp_AgregarProductos("ABC122","Manzana Roja",0.00,0.00,0.00,10,1,1);
call sp_AgregarProductos("ABC120","Manzana Amarilla",0.00,0.00,0.00,9,1,1);


call sp_AgregarDetalleCompras(01,12.00,2,"ABC123",1);
call sp_AgregarDetalleCompras(02,12.00,1,"ABC122",1);
call sp_AgregarDetalleCompras(03,10.00,1,"ABC120",1);

call sp_AgregarEmpleados(01,"Javier","Apen",350.25,"Ciudad Quetzal","Vespetina", 01);

call sp_AgregarFactura(01,"Vigente",46.00,"2024-05-10",02,01);

call sp_AgregarDetalleFactura(01,0.00,1,01,"ABC123");
call sp_AgregarEmailProveedor(01,"juan@gmail.com","Proveedor Coca Cola Juan",01);


call sp_ListarProductos();
call sp_ListarCompras();
call sp_ListarEmpleados();
call sp_ListarTelefonoProveedor();
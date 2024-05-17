/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.javierapen.controller;

import java.net.URL;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.ResourceBundle;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.image.ImageView;
import org.javierapen.bean.Productos;
import org.javierapen.bean.Proveedor;
import org.javierapen.bean.TipoProducto;
import org.javierapen.db.Conexion;
import org.javierapen.system.Main;

/**
 *
 * @author informatica
 */
public class MenuProductosController implements Initializable {

    @FXML
    private TextField txtCodigoP;
    @FXML
    private TextField txtDescripcionP;
    @FXML
    private TextField txtPrecioUnitarioP;
    @FXML
    private TextField txtPrecioDocenaP;
    @FXML
    private TextField txtPrecioMayorP;
    @FXML
    private TextField txtImagenP;
    @FXML
    private TextField txtExistenciaP;
    @FXML
    private ComboBox cmbTipoProducto;
    @FXML
    private ComboBox cmbProveedores;
    @FXML
    private TableView tblProductos;
    @FXML
    private TableColumn colCodigoP;
    @FXML
    private TableColumn colDescripcionP;
    @FXML
    private TableColumn colPrecioUnidadP;
    @FXML
    private TableColumn colPrecioDocenaP;
    @FXML
    private TableColumn colPrecioMayorP;
    @FXML
    private TableColumn colImagenP;
    @FXML
    private TableColumn colExistenciaP;
    @FXML
    private TableColumn colTipoProductoP;
    @FXML
    private TableColumn colProveedorP;
    @FXML
    private Button btnAgregar;
    @FXML
    private ImageView imgAgregar;
    @FXML
    private Button btnEliminar;
    @FXML
    private ImageView imgEliminar;
    @FXML
    private Button btnEditar;
    @FXML
    private ImageView imgEditar;
    @FXML
    private Button btnReporte;
    @FXML
    private ImageView imgReporte;

    private enum operaciones {
        AGREGAR, ELIMINAR, EDITAR, ACTUALIZAR, CANCELAR, NINGUNO
    }
    private operaciones tipoDeOperaciones = operaciones.NINGUNO;

    private ObservableList<Productos> listaProductos;
    private ObservableList<TipoProducto> listaTipoProducto;
    private ObservableList<Proveedor> listaProveedor;
    private Main escenarioPrincipal;
    @FXML
    private Button btnRegresar;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        cargaDatos();
        cmbTipoProducto.setItems(getTipoProducto());
        cmbProveedores.setItems(getProveedores());
    }

    public void cargaDatos() {
        tblProductos.setItems(getProducto());
        colCodigoP.setCellValueFactory(new PropertyValueFactory<Productos, String>("codigoProducto"));
        colDescripcionP.setCellValueFactory(new PropertyValueFactory<Productos, String>("descripcionProducto"));
        colPrecioUnidadP.setCellValueFactory(new PropertyValueFactory<Productos, Double>("precioUnitario"));
        colPrecioDocenaP.setCellValueFactory(new PropertyValueFactory<Productos, Double>("precioDocena"));
        colPrecioMayorP.setCellValueFactory(new PropertyValueFactory<Productos, Double>("precioMayor"));
        colExistenciaP.setCellValueFactory(new PropertyValueFactory<Productos, Integer>("existencia"));
        colTipoProductoP.setCellValueFactory(new PropertyValueFactory<Productos, Integer>("tipoProducto"));
        colProveedorP.setCellValueFactory(new PropertyValueFactory<Productos, Integer>("proveedores"));

    }

    public void selecionarElementos() {
        txtCodigoP.setText(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getCodigoProducto());
        txtDescripcionP.setText(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getDescripcionProducto());
        txtPrecioUnitarioP.setText(String.valueOf(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getPrecioUnitario()));
        txtPrecioDocenaP.setText(String.valueOf(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getPrecioDocena()));
        txtPrecioMayorP.setText(String.valueOf(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getPrecioMayor()));
        txtExistenciaP.setText(String.valueOf(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getExistencia()));
        cmbTipoProducto.getSelectionModel().select(buscarTipoProducto(((Productos) tblProductos.getSelectionModel().getSelectedItem()).getTipoProducto()));
    }

    public void agregar() {
        switch (tipoDeOperaciones) {
            case NINGUNO:
                activarControles();
                btnAgregar.setText("Guardar");
                btnEliminar.setText("Cancelar");
                btnEditar.setDisable(true);
                btnReporte.setDisable(true);
                tipoDeOperaciones = operaciones.ACTUALIZAR;
                break;
            case ACTUALIZAR:
                guardar();
                desactivarControles();
                limpiarControles();
                btnAgregar.setText("Agregar");
                btnEliminar.setText("Eliminar");
                btnEditar.setDisable(false);
                btnReporte.setDisable(false);
                tipoDeOperaciones = operaciones.NINGUNO;
                cargaDatos();
                break;
        }

    }

    public TipoProducto buscarTipoProducto(int codigoTipoProducto) {
        TipoProducto resultado = null;
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_BuscarTipoProducto(?)}");
            procedimiento.setInt(1, codigoTipoProducto);
            ResultSet registro = procedimiento.executeQuery();
            while (registro.next()) {
                resultado = new TipoProducto(registro.getInt("codigoTipoProducto"),
                        registro.getString("descripcion")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return resultado;
    }

    public ObservableList<Productos> getProducto() {
        ArrayList<Productos> lista = new ArrayList<Productos>();
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_ListarProductos()}");
            ResultSet resultado = procedimiento.executeQuery();
            while (resultado.next()) {
                lista.add(new Productos(resultado.getString("codigoProducto"),
                        resultado.getString("descripcionProducto"),
                        resultado.getDouble("precioUnitario"),
                        resultado.getDouble("precioDocena"),
                        resultado.getDouble("precioMayor"),
                        resultado.getInt("existencia"),
                        resultado.getInt("tipoProducto"),
                        resultado.getInt("proveedores")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaProductos = FXCollections.observableArrayList(lista);
    }

    public ObservableList<TipoProducto> getTipoProducto() {
        ArrayList<TipoProducto> lista = new ArrayList();
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_ListarTipoProducto()}");
            ResultSet resultado = procedimiento.executeQuery();
            while (resultado.next()) {
                lista.add(new TipoProducto(resultado.getInt("codigoTipoProducto"),
                        resultado.getString("descripcion")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaTipoProducto = FXCollections.observableArrayList(lista);
    }

    public ObservableList<Proveedor> getProveedores() {
        ArrayList<Proveedor> lista = new ArrayList();
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_ListarProveedores()}");
            ResultSet resultado = procedimiento.executeQuery();
            while (resultado.next()) {
                lista.add(new Proveedor(resultado.getInt("codigoProveedor"),
                        resultado.getString("nitProveedor"),
                        resultado.getString("nombreProveedor"),
                        resultado.getString("apellidoProveedor"),
                        resultado.getString("direccionProveedor"),
                        resultado.getString("razonSocial"),
                        resultado.getString("contactoPrincipal"),
                        resultado.getString("paginaWeb")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaProveedor = FXCollections.observableArrayList(lista);
    }

    public void guardar() {
        Productos registro = new Productos();
        registro.setCodigoProducto(txtCodigoP.getText());
        registro.setProveedores(((Proveedor) cmbProveedores.getSelectionModel().getSelectedItem()).getCodigoProveedor());
        registro.setTipoProducto(((TipoProducto) cmbTipoProducto.getSelectionModel().getSelectedItem()).getCodigoTipoProducto());
        registro.setDescripcionProducto(txtDescripcionP.getText());
        registro.setPrecioDocena(Double.parseDouble(txtPrecioDocenaP.getText()));
        registro.setPrecioUnitario(Double.parseDouble(txtPrecioUnitarioP.getText()));
        registro.setPrecioMayor(Double.parseDouble(txtPrecioMayorP.getText()));
        registro.setExistencia(Integer.parseInt(txtExistenciaP.getText()));
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_AgregarProductos(?, ?, ?, ?, ?, ?, ?, ?)}");
            procedimiento.setString(1, registro.getCodigoProducto());
            procedimiento.setString(2, registro.getDescripcionProducto());
            procedimiento.setDouble(3, registro.getPrecioUnitario());
            procedimiento.setDouble(4, registro.getPrecioDocena());
            procedimiento.setDouble(5, registro.getPrecioMayor());
            procedimiento.setInt(6, registro.getExistencia());
            procedimiento.setInt(7, registro.getTipoProducto());
            procedimiento.setInt(8, registro.getProveedores());
            procedimiento.execute();

            listaProductos.add(registro);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void desactivarControles() {
        txtCodigoP.setEditable(false);
        txtDescripcionP.setEditable(false);
        txtPrecioUnitarioP.setEditable(false);
        txtPrecioDocenaP.setEditable(false);
        txtPrecioMayorP.setEditable(false);
        txtExistenciaP.setEditable(false);
        cmbTipoProducto.setDisable(true);
        cmbProveedores.setDisable(true);

    }

    public void activarControles() {
        txtCodigoP.setEditable(true);
        txtDescripcionP.setEditable(true);
        txtPrecioUnitarioP.setEditable(true);
        txtPrecioDocenaP.setEditable(true);
        txtPrecioMayorP.setEditable(true);
        txtExistenciaP.setEditable(true);
        cmbTipoProducto.setDisable(false);
        cmbProveedores.setDisable(false);
    }

    public void limpiarControles() {
        txtCodigoP.clear();
        txtDescripcionP.clear();
        txtPrecioUnitarioP.clear();
        txtPrecioDocenaP.clear();
        txtPrecioMayorP.clear();
        txtExistenciaP.clear();
        tblProductos.getSelectionModel().getSelectedItem();
        cmbTipoProducto.getSelectionModel().getSelectedItem();
        cmbProveedores.getSelectionModel().getSelectedItem();

    }

    public Main getEscenarioPrincipal() {
        return escenarioPrincipal;
    }

    public void setEscenarioPrincipal(Main escenarioPrincipal) {
        this.escenarioPrincipal = escenarioPrincipal;
    }

    @FXML
    public void regresar(ActionEvent event) {
        if (event.getSource() == btnRegresar) {
            escenarioPrincipal.menuPrincipalView();
        }
    }
}

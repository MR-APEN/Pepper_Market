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
import org.javierapen.bean.Clientes;
import org.javierapen.bean.Empleados;
import org.javierapen.bean.Facturas;
import org.javierapen.db.Conexion;
import org.javierapen.system.Main;

/**
 *
 * @author 50258
 */
public class MenuFacturaController implements Initializable {

    private ObservableList<Empleados> listaEmpleados;
    private ObservableList<Facturas> listaFacturas;
    private ObservableList<Clientes> listaClientes;
    private Main escenarioPrincipal;
    @FXML
    private Button btnRegresar;
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
    @FXML
    private TableView tblFactura;
    @FXML
    private TableColumn colNumeroF;
    @FXML
    private TableColumn colEstadoF;
    @FXML
    private TableColumn colTotalF;
    @FXML
    private TableColumn colFechaF;
    @FXML
    private TableColumn colCliente;
    @FXML
    private TableColumn colEmpleado;
    @FXML
    private TextField txtNumeroF;
    @FXML
    private TextField txtEstadoF;
    @FXML
    private TextField txtTotalFacturaF;
    @FXML
    private TextField txtFechaF;
    @FXML
    private ComboBox cmbCliente;
    @FXML
    private ComboBox cmbEmpleado;

    private enum operaciones {
        AGREGAR, ELIMINAR, EDITAR, ACTUALIZAR, CANCELAR, NINGUNO
    }
    private operaciones tipoDeOperaciones = operaciones.NINGUNO;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        desactivarControles();
        cargarDatos();
        cmbCliente.setItems(getClientes());
        cmbEmpleado.setItems(getEmpleados());
        
    }

    public void cargarDatos() {
        tblFactura.setItems(getFacturas());
        colNumeroF.setCellValueFactory(new PropertyValueFactory<Facturas, Integer>("numeroFactura"));
        colEstadoF.setCellValueFactory(new PropertyValueFactory<Facturas, String>("estado"));
        colTotalF.setCellValueFactory(new PropertyValueFactory<Facturas, Double>("totalFactura"));
        colFechaF.setCellValueFactory(new PropertyValueFactory<Facturas, String>("fechaFactura"));
        colCliente.setCellValueFactory(new PropertyValueFactory<Facturas, Integer>("codigoCliente"));
        colEmpleado.setCellValueFactory(new PropertyValueFactory<Facturas, Integer>("codigoEmpleado"));
    }

    public void seleccionarElemento() {
        txtNumeroF.setText(String.valueOf(((Facturas) tblFactura.getSelectionModel().getSelectedItem()).getNumeroFactura()));
        txtEstadoF.setText(((Facturas) tblFactura.getSelectionModel().getSelectedItem()).getEstado());
        txtTotalFacturaF.setText(String.valueOf(((Facturas) tblFactura.getSelectionModel().getSelectedItem()).getTotalFactura()));
        txtFechaF.setText(((Facturas) tblFactura.getSelectionModel().getSelectedItem()).getFechaFactura());
        cmbCliente.getSelectionModel().select(buscarCliente(((Facturas) tblFactura.getSelectionModel().getSelectedItem()).getCodigoCliente()));
        cmbEmpleado.getSelectionModel().select(buscarEmpleado(((Facturas) tblFactura.getSelectionModel().getSelectedItem()).getCodigoEmpleado()));
    }

    public Empleados buscarEmpleado(int codigoEmpleado) {
        Empleados resultado = null;
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_BuscarEmpleados(?)}");
            procedimiento.setInt(1, codigoEmpleado);
            ResultSet registro = procedimiento.executeQuery();
            while (registro.next()) {
                resultado = new Empleados(registro.getInt("codigoEmpleado"),
                        registro.getString("nombreEmpleado"),
                        registro.getString("apellidoEmpleado"),
                        registro.getDouble("sueldo"),
                        registro.getString("direccion"),
                        registro.getString("turno"),
                        registro.getInt("codigoCargoEmpleado"));

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultado;
    }

    public Clientes buscarCliente(int codigoCliente) {
        Clientes resultado = null;
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_BuscarClientes(?)}");
            procedimiento.setInt(1, codigoCliente);
            ResultSet registro = procedimiento.executeQuery();
            while (registro.next()) {
                resultado = new Clientes(registro.getInt("codigoCliente"),
                        registro.getString("NITCliente"),
                        registro.getString("nombreCliente"),
                        registro.getString("apellidoCliente"),
                        registro.getString("direccionCliente"),
                        registro.getString("telefonoCliente"),
                        registro.getString("correoCliente"));

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultado;
    }

    public ObservableList<Facturas> getFacturas() {
        ArrayList<Facturas> lista = new ArrayList();
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_ListarFactura()}");
            ResultSet resultado = procedimiento.executeQuery();
            while (resultado.next()) {
                lista.add(new Facturas(resultado.getInt("numeroFactura"),
                        resultado.getString("estado"),
                        resultado.getDouble("totalFactura"),
                        resultado.getString("fechaFactura"),
                        resultado.getInt("codigoCliente"),
                        resultado.getInt("codigoEmpleado")));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return listaFacturas = FXCollections.observableArrayList(lista);
    }

    public ObservableList<Clientes> getClientes() {
        ArrayList<Clientes> lista = new ArrayList();
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_ListarClientes()}");
            ResultSet resultado = procedimiento.executeQuery();
            while (resultado.next()) {
                lista.add(new Clientes(resultado.getInt("codigoCliente"),
                        resultado.getString("nitCliente"),
                        resultado.getString("nombreCliente"),
                        resultado.getString("apellidoCliente"),
                        resultado.getString("direccionCliente"),
                        resultado.getString("telefonoCliente"),
                        resultado.getString("correoCliente")));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return listaClientes = FXCollections.observableArrayList(lista);
    }

    public ObservableList<Empleados> getEmpleados() {
        ArrayList<Empleados> lista = new ArrayList<Empleados>();
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_ListarEmpleados()}");
            ResultSet resultado = procedimiento.executeQuery();
            while (resultado.next()) {
                lista.add(new Empleados(resultado.getInt("codigoEmpleado"),
                        resultado.getString("nombresEmpleado"),
                        resultado.getString("apellidosEmpleado"),
                        resultado.getDouble("sueldo"),
                        resultado.getString("direccion"),
                        resultado.getString("turno"),
                        resultado.getInt("codigoCargoEmpleado")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaEmpleados = FXCollections.observableArrayList(lista);
    }

    public void desactivarControles() {
        txtNumeroF.setEditable(false);
        txtEstadoF.setEditable(false);
        txtTotalFacturaF.setEditable(false);
        txtFechaF.setEditable(false);
        cmbCliente.setDisable(true);
        cmbEmpleado.setDisable(true);
    }

    public void activarControles() {
        txtNumeroF.setEditable(true);
        txtEstadoF.setEditable(true);
        txtTotalFacturaF.setEditable(true);
        txtFechaF.setEditable(true);
        cmbCliente.setDisable(false);
        cmbEmpleado.setDisable(false);
    }

    public void limpiarControles() {
        txtNumeroF.clear();
        txtEstadoF.clear();
        txtTotalFacturaF.clear();
        txtFechaF.clear();
        cmbCliente.getSelectionModel().getSelectedItem();
        cmbEmpleado.getSelectionModel().getSelectedItem();

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

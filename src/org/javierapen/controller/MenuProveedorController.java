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
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javax.swing.JOptionPane;
import org.javierapen.bean.Proveedor;
import org.javierapen.db.Conexion;
import org.javierapen.system.Main;

/**
 *
 * @author informatica
 */
public class MenuProveedorController implements Initializable {

    private Main escenarioPrincipal;
    @FXML
    private Button btnRegresar;

    private enum operaciones {
        AGREGAR, ELIMINAR, EDITAR, ACTUALIZAR, CANCELAR, NINGUNO
    }
    private operaciones tipoDeOperaciones = operaciones.NINGUNO;

    private ObservableList<Proveedor> listaProveedores;

    @FXML
    private TextField txtCodigoProveedorP;
    @FXML
    private TextField txtNitP;
    @FXML
    private TextField txtNombreP;
    @FXML
    private TextField txtApellidosP;
    @FXML
    private TextField txtPaginaP;
    @FXML
    private TextField txtContactoP;
    @FXML
    private TextField txtRazonP;
    @FXML
    private TextField txtDireccionP;
    @FXML
    private TableView tblProveedores;
    @FXML
    private TableColumn colCodigoProveedorP;
    @FXML
    private TableColumn colNitP;
    @FXML
    private TableColumn colNombreP;
    @FXML
    private TableColumn colApellidoP;
    @FXML
    private TableColumn colDireccionP;
    @FXML
    private TableColumn colRazonP;
    @FXML
    private TableColumn colContactoP;
    @FXML
    private TableColumn colPaginaP;
    @FXML
    private Button btnAgregar;
    @FXML
    private Button btnEliminar;
    @FXML
    private Button btnEditar;
    @FXML
    private Button btnReporte;
    @FXML
    private ImageView imgAgregar;
    @FXML
    private ImageView imgEliminar;
    @FXML
    private ImageView imgEditar;
    @FXML
    private ImageView imgReporte;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        cargarDatos();
        desactivarControllers();
    }

    public void cargarDatos() {
        tblProveedores.setItems(getProveedores());
        colCodigoProveedorP.setCellValueFactory(new PropertyValueFactory<Proveedor, Integer>("codigoProveedor"));
        colNitP.setCellValueFactory(new PropertyValueFactory<Proveedor, String>("nitProveedor"));
        colNombreP.setCellValueFactory(new PropertyValueFactory<Proveedor, String>("nombreProveedor"));
        colApellidoP.setCellValueFactory(new PropertyValueFactory<Proveedor, String>("apellidoProveedor"));
        colDireccionP.setCellValueFactory(new PropertyValueFactory<Proveedor, String>("direccionProveedor"));
        colRazonP.setCellValueFactory(new PropertyValueFactory<Proveedor, String>("razonSocial"));
        colContactoP.setCellValueFactory(new PropertyValueFactory<Proveedor, String>("contactoPrincipal"));
        colPaginaP.setCellValueFactory(new PropertyValueFactory<Proveedor, String>("paginaWeb"));
    }

    public void selecionarDatos() {
        txtCodigoProveedorP.setText(String.valueOf(((Proveedor) tblProveedores.getSelectionModel().getSelectedItem()).getCodigoProveedor()));
        txtNitP.setText(String.valueOf(((Proveedor) tblProveedores.getSelectionModel().getSelectedItem()).getNitProveedor()));
        txtNombreP.setText(String.valueOf(((Proveedor) tblProveedores.getSelectionModel().getSelectedItem()).getNombreProveedor()));
        txtApellidosP.setText(String.valueOf(((Proveedor) tblProveedores.getSelectionModel().getSelectedItem()).getApellidoProveedor()));
        txtDireccionP.setText(String.valueOf(((Proveedor) tblProveedores.getSelectionModel().getSelectedItem()).getDireccionProveedor()));
        txtRazonP.setText(String.valueOf(((Proveedor) tblProveedores.getSelectionModel().getSelectedItem()).getRazonSocial()));
        txtContactoP.setText(String.valueOf(((Proveedor) tblProveedores.getSelectionModel().getSelectedItem()).getContactoPrincipal()));
        txtPaginaP.setText(String.valueOf(((Proveedor) tblProveedores.getSelectionModel().getSelectedItem()).getPaginaWeb()));
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
        return listaProveedores = FXCollections.observableArrayList(lista);
    }

    public void agregar() {
        switch (tipoDeOperaciones) {
            case NINGUNO:
                activarControllers();
                limpiarControllers();
                btnAgregar.setText("Guardar");
                btnEliminar.setText("Cancelar");
                btnEditar.setDisable(true);
                btnReporte.setDisable(true);
                imgAgregar.setImage(new Image("/org/javierapen/image/guardar-el-archivo.png"));
                imgEliminar.setImage(new Image("/org/javierapen/image/cancelar.png"));
                tipoDeOperaciones = operaciones.ACTUALIZAR;
                break;
            case ACTUALIZAR:
                guardar();
                desactivarControllers();
                limpiarControllers();
                btnAgregar.setText("Agregar");
                btnEliminar.setText("Eliminar");
                btnEditar.setDisable(false);
                btnReporte.setDisable(false);
                imgAgregar.setImage(new Image("org/javierapen/image/agregar-producto.png"));
                imgEliminar.setImage(new Image("org/javierapen/image/quitar-caja.png"));
                tipoDeOperaciones = operaciones.NINGUNO;
                break;

        }
    }

    public void eliminar() {
        switch (tipoDeOperaciones) {
            case ACTUALIZAR:
                desactivarControllers();
                limpiarControllers();
                btnAgregar.setText("Agregar");
                btnEliminar.setText("Eliminar");
                btnEditar.setDisable(false);
                btnReporte.setDisable(false);
                imgAgregar.setImage(new Image("/org/javierapen/image/agregar-producto.png"));
                imgEliminar.setImage(new Image("/org/javierapen/image/quitar-caja.png"));
                tipoDeOperaciones = operaciones.NINGUNO;
                break;
            default:
                if (tblProveedores.getSelectionModel().getSelectedItem() != null) {
                    int respuesta = JOptionPane.showConfirmDialog(null, "Confirmar si elimina registro",
                            "Eliminar Clientes", JOptionPane.YES_NO_OPTION, JOptionPane.QUESTION_MESSAGE);
                    if (respuesta == JOptionPane.YES_NO_OPTION) {
                        try {
                            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_EliminarProveedores(?)}");
                            procedimiento.setInt(1, ((Proveedor) tblProveedores.getSelectionModel().getSelectedItem()).getCodigoProveedor());
                            procedimiento.execute();
                            listaProveedores.remove(tblProveedores.getSelectionModel().getSelectedItem());
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                } else {
                    JOptionPane.showMessageDialog(null, "Debe Seleccionar un Elemento");
                }
        }
    }

    public void reporte() {
        switch (tipoDeOperaciones) {
            case ACTUALIZAR:
                desactivarControllers();
                limpiarControllers();
                btnEditar.setText("Editar");
                btnReporte.setText("Reporte");
                btnAgregar.setDisable(false);
                btnEliminar.setDisable(false);
                imgEditar.setImage(new Image("/org/javierapen/image/editar.png"));
                imgReporte.setImage(new Image("/org/javierapen/image/reporte.png"));
                tipoDeOperaciones = operaciones.NINGUNO;
                break;
        }
    }

    public void editar() {
        switch (tipoDeOperaciones) {
            case NINGUNO:
                if (tblProveedores.getSelectionModel().getSelectedItem() != null) {
                    btnEditar.setText("Actualizar");
                    btnReporte.setText("Cancelar");
                    btnAgregar.setDisable(true);
                    btnEliminar.setDisable(true);
                    imgReporte.setImage(new Image("/org/javierapen/image/cancelar.png"));
                    activarControllers();
                    txtCodigoProveedorP.setEditable(false);
                    tipoDeOperaciones = operaciones.ACTUALIZAR;
                } else {
                    JOptionPane.showMessageDialog(null, "Debe seleccionar algun elemento");
                }
                break;
            case ACTUALIZAR:
                actualizar();
                desactivarControllers();
                limpiarControllers();
                btnEditar.setText("Editar");
                btnReporte.setText("Reporte");
                btnAgregar.setDisable(false);
                btnEliminar.setDisable(false);
                imgReporte.setImage(new Image("/org/javierapen/image/reporte.png"));
                tipoDeOperaciones = operaciones.NINGUNO;
                cargarDatos();
                break;
        }
    }

    public void actualizar() {
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_EditarProveedores(?,?,?,?,?,?,?,?)}");
            Proveedor registro = (Proveedor) tblProveedores.getSelectionModel().getSelectedItem();
            registro.setNitProveedor(txtNitP.getText());
            registro.setNombreProveedor(txtNombreP.getText());
            registro.setApellidoProveedor(txtApellidosP.getText());
            registro.setDireccionProveedor(txtDireccionP.getText());
            registro.setRazonSocial(txtRazonP.getText());
            registro.setContactoPrincipal(txtContactoP.getText());
            registro.setPaginaWeb(txtPaginaP.getText());
            procedimiento.setInt(1, registro.getCodigoProveedor());
            procedimiento.setString(2, registro.getNitProveedor());
            procedimiento.setString(3, registro.getNombreProveedor());
            procedimiento.setString(4, registro.getApellidoProveedor());
            procedimiento.setString(5, registro.getDireccionProveedor());
            procedimiento.setString(6, registro.getRazonSocial());
            procedimiento.setString(7, registro.getContactoPrincipal());
            procedimiento.setString(8, registro.getPaginaWeb());
            procedimiento.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void guardar() {
        Proveedor registro = new Proveedor();
        registro.setCodigoProveedor(Integer.parseInt(txtCodigoProveedorP.getText()));
        registro.setNitProveedor(txtNitP.getText());
        registro.setNombreProveedor(txtNombreP.getText());
        registro.setApellidoProveedor(txtApellidosP.getText());
        registro.setDireccionProveedor(txtDireccionP.getText());
        registro.setRazonSocial(txtRazonP.getText());
        registro.setContactoPrincipal(txtContactoP.getText());
        registro.setPaginaWeb(txtPaginaP.getText());
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_AgregaProveedores(?,?,?,?,?,?,?,?)}");
            procedimiento.setInt(1, registro.getCodigoProveedor());
            procedimiento.setString(2, registro.getNitProveedor());
            procedimiento.setString(3, registro.getNombreProveedor());
            procedimiento.setString(4, registro.getApellidoProveedor());
            procedimiento.setString(5, registro.getDireccionProveedor());
            procedimiento.setString(6, registro.getRazonSocial());
            procedimiento.setString(7, registro.getContactoPrincipal());
            procedimiento.setString(8, registro.getPaginaWeb());
            procedimiento.execute();
            listaProveedores.add(registro);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void desactivarControllers() {
        txtCodigoProveedorP.setEditable(false);
        txtNitP.setEditable(false);
        txtNombreP.setEditable(false);
        txtApellidosP.setEditable(false);
        txtDireccionP.setEditable(false);
        txtRazonP.setEditable(false);
        txtContactoP.setEditable(false);
        txtPaginaP.setEditable(false);
    }

    public void activarControllers() {
        txtCodigoProveedorP.setEditable(true);
        txtNitP.setEditable(true);
        txtNombreP.setEditable(true);
        txtApellidosP.setEditable(true);
        txtDireccionP.setEditable(true);
        txtRazonP.setEditable(true);
        txtContactoP.setEditable(true);
        txtPaginaP.setEditable(true);
    }

    public void limpiarControllers() {
        txtCodigoProveedorP.clear();
        txtNitP.clear();
        txtNombreP.clear();
        txtApellidosP.clear();
        txtDireccionP.clear();
        txtRazonP.clear();
        txtContactoP.clear();
        txtPaginaP.clear();
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

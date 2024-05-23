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
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javax.swing.JOptionPane;
import org.javierapen.bean.Proveedor;
import org.javierapen.bean.TelefonoProveedor;
import org.javierapen.db.Conexion;
import org.javierapen.system.Main;

/**
 *
 * @author 50258
 */
public class MenuTelefonoProveedorController implements Initializable {

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
    private TableView tblTelefonoP;
    @FXML
    private TextField txtCodigoTP;
    @FXML
    private TextField txtNumeroP;
    @FXML
    private TextField txtNumeroS;
    @FXML
    private TextField txtObservacionesTP;
    @FXML
    private ComboBox cmbProveedor;
    @FXML
    private TableColumn colCodigoTP;
    @FXML
    private TableColumn colNumeroP;
    @FXML
    private TableColumn colNumeroS;
    @FXML
    private TableColumn colObservacionesTP;
    @FXML
    private TableColumn colCodigoProveedor;

    private enum operaciones {
        AGREGAR, ELIMINAR, EDITAR, ACTUALIZAR, CANCELAR, NINGUNO
    }
    private operaciones tipoDeOperaciones = operaciones.NINGUNO;

    private ObservableList<Proveedor> listaProveedores;
    private ObservableList<TelefonoProveedor> listaTelefonoProveedor;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        desactivarControllers();
        cargarDatos();
        cmbProveedor.setItems(getProveedores());
    }

    public void cargarDatos() {
        tblTelefonoP.setItems(getTelefonoProveedor());
        colCodigoTP.setCellValueFactory(new PropertyValueFactory<TelefonoProveedor, Integer>("codigoTelefonoProveedor"));
        colNumeroP.setCellValueFactory(new PropertyValueFactory<TelefonoProveedor, String>("numeroPrincipal"));
        colNumeroS.setCellValueFactory(new PropertyValueFactory<TelefonoProveedor, String>("numeroSecundario"));
        colObservacionesTP.setCellValueFactory(new PropertyValueFactory<TelefonoProveedor, String>("observaciones"));
        colCodigoProveedor.setCellValueFactory(new PropertyValueFactory<TelefonoProveedor, Integer>("codigoProveedor"));

    }

    public void selecionarElementos() {
        txtCodigoTP.setText(String.valueOf(((TelefonoProveedor) tblTelefonoP.getSelectionModel().getSelectedItem()).getCodigoTelefonoProveedor()));
        txtNumeroP.setText(((TelefonoProveedor) tblTelefonoP.getSelectionModel().getSelectedItem()).getNumeroPrincipal());
        txtNumeroS.setText(((TelefonoProveedor) tblTelefonoP.getSelectionModel().getSelectedItem()).getNumeroSecundario());
        txtObservacionesTP.setText(((TelefonoProveedor) tblTelefonoP.getSelectionModel().getSelectedItem()).getObservaciones());
        cmbProveedor.getSelectionModel().select(buscarProveedor(((TelefonoProveedor) tblTelefonoP.getSelectionModel().getSelectedItem()).getCodigoProveedor()));
    }

    public Proveedor buscarProveedor(int codigoProveedor) {
        Proveedor resultado = null;
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_BuscarProveedores(?)}");
            procedimiento.setInt(1, codigoProveedor);
            ResultSet registro = procedimiento.executeQuery();
            while (registro.next()) {
                resultado = new Proveedor(registro.getInt("codigoProveedor"),
                        registro.getString("nitProveedor"),
                        registro.getString("nombreProveedor"),
                        registro.getString("apellidoProveedor"),
                        registro.getString("direccionProveedor"),
                        registro.getString("razonSocial"),
                        registro.getString("contactoPrincipal"),
                        registro.getString("paginaWeb")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return resultado;
    }

    public ObservableList<TelefonoProveedor> getTelefonoProveedor() {
        ArrayList<TelefonoProveedor> lista = new ArrayList();
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_ListarTelefonoProveedor()}");
            ResultSet resultado = procedimiento.executeQuery();
            while (resultado.next()) {
                lista.add(new TelefonoProveedor(resultado.getInt("codigoTelefonoProveedor"),
                        resultado.getString("numeroPrincipal"),
                        resultado.getString("numeroSecundario"),
                        resultado.getString("observaciones"),
                        resultado.getInt("codigoProveedor")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaTelefonoProveedor = FXCollections.observableArrayList(lista);
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

    public void guardar() {
        TelefonoProveedor registro = new TelefonoProveedor();
        registro.setCodigoTelefonoProveedor(Integer.parseInt(txtCodigoTP.getText()));
        registro.setCodigoProveedor(((TelefonoProveedor) cmbProveedor.getSelectionModel().getSelectedItem()).getCodigoProveedor());
        registro.setNumeroPrincipal(txtNumeroP.getText());
        registro.setNumeroSecundario(txtNumeroS.getText());
        registro.setObservaciones(txtObservacionesTP.getText());
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_AgregarTelefonoProveedor(?, ?, ?, ?, ?)}");
            procedimiento.setInt(1, registro.getCodigoTelefonoProveedor());
            procedimiento.setString(2, registro.getNumeroPrincipal());
            procedimiento.setString(3, registro.getNumeroSecundario());
            procedimiento.setString(4, registro.getObservaciones());
            procedimiento.setInt(5, registro.getCodigoProveedor());
            procedimiento.execute();
            listaTelefonoProveedor.add(registro);
        } catch (Exception e) {
            e.printStackTrace();
        }

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
                tipoDeOperaciones = operaciones.NINGUNO;
                cargarDatos();
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
                imgAgregar.setImage(new Image("/org/javierapen/image/agregar-usuario.png"));
                imgEliminar.setImage(new Image("/org/javierapen/image/eliminar-amigo.png"));
                tipoDeOperaciones = operaciones.NINGUNO;
                break;
            default:
                if (tblTelefonoP.getSelectionModel().getSelectedItem() != null) {
                    int respuesta = JOptionPane.showConfirmDialog(null, "Confirmar si elimina registro",
                            "Eliminar Telefono Proveedor", JOptionPane.YES_NO_OPTION, JOptionPane.QUESTION_MESSAGE);
                    if (respuesta == JOptionPane.YES_NO_OPTION) {
                        try {
                            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_EliminarTelefonoProveedor(?)}");
                            procedimiento.setInt(1, ((TelefonoProveedor) tblTelefonoP.getSelectionModel().getSelectedItem()).getCodigoTelefonoProveedor());
                            procedimiento.execute();
                            listaTelefonoProveedor.remove(tblTelefonoP.getSelectionModel().getSelectedItem());
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                } else {
                    JOptionPane.showMessageDialog(null, "Debe Seleccionar un Elemento");
                }
        }
    }

    public void actualizar() {
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_EditarTelefonoProveedor(?,?,?,?,?)}");
            TelefonoProveedor registro = (TelefonoProveedor) tblTelefonoP.getSelectionModel().getSelectedItem();
            registro.setCodigoTelefonoProveedor(Integer.parseInt(txtCodigoTP.getText()));
            registro.setCodigoProveedor(((TelefonoProveedor) cmbProveedor.getSelectionModel().getSelectedItem()).getCodigoProveedor());
            registro.setNumeroPrincipal(txtNumeroP.getText());
            registro.setNumeroSecundario(txtNumeroS.getText());
            registro.setObservaciones(txtObservacionesTP.getText());
            procedimiento.setInt(1, registro.getCodigoTelefonoProveedor());
            procedimiento.setString(2, registro.getNumeroPrincipal());
            procedimiento.setString(3, registro.getNumeroSecundario());
            procedimiento.setString(4, registro.getObservaciones());
            procedimiento.setInt(5, registro.getCodigoProveedor());
            procedimiento.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void editar() {
        switch (tipoDeOperaciones) {
            case NINGUNO:
                if (tblTelefonoP.getSelectionModel().getSelectedItem() != null) {
                    btnEditar.setText("Actualizar");
                    btnReporte.setText("Cancelar");
                    btnAgregar.setDisable(true);
                    btnEliminar.setDisable(true);
                    imgReporte.setImage(new Image("/org/javierapen/image/cancelar.png"));
                    activarControllers();
                    txtCodigoTP.setEditable(false);
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

        public void reporte() {
        switch (tipoDeOperaciones) {
            case ACTUALIZAR:
                desactivarControllers();
                limpiarControllers();
                btnEditar.setText("Editar");
                btnReporte.setText("Reporte");
                btnAgregar.setDisable(false);
                btnEliminar.setDisable(false);
                imgEditar.setImage(new Image("/org/javierapen/image/avatar-de-usuario.png"));
                imgReporte.setImage(new Image("/org/javierapen/image/reporte.png"));
                tipoDeOperaciones = operaciones.NINGUNO;
                break;
        }
    }
        
    public void desactivarControllers() {
        txtCodigoTP.setEditable(false);
        txtNumeroP.setEditable(false);
        txtNumeroS.setEditable(false);
        txtObservacionesTP.setDisable(true);
        cmbProveedor.setDisable(true);
    }

    public void activarControllers() {
        txtCodigoTP.setEditable(true);
        txtNumeroP.setEditable(true);
        txtNumeroS.setEditable(true);
        txtObservacionesTP.setDisable(false);
        cmbProveedor.setDisable(false);
    }

    public void limpiarControllers() {
        txtCodigoTP.clear();
        txtNumeroP.clear();
        txtNumeroS.clear();
        tblTelefonoP.getSelectionModel().getSelectedItem();
        txtObservacionesTP.clear();
        cmbProveedor.getSelectionModel().getSelectedItem();
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

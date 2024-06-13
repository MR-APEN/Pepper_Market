/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.javierapen.controller;

import java.io.IOException;
import java.net.URL;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ResourceBundle;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javax.swing.JOptionPane;
import org.javierapen.bean.Usuarios;
import org.javierapen.db.Conexion;
import org.javierapen.system.Main;

/**
 *
 * @author 50258
 */
public class MenuLoginController implements Initializable {

    @FXML
    private TextField txtUsuario;
    @FXML
    private Button btnLogin;
    @FXML
    private PasswordField txtContra;

    private Main escenarioPrincipal;

    @Override
    public void initialize(URL url, ResourceBundle rb) {

    }

    public Main getEscenarioPrincipal() {
        return escenarioPrincipal;
    }

    public void setEscenarioPrincipal(Main escenarioPrincipal) {
        this.escenarioPrincipal = escenarioPrincipal;
    }

    @FXML
    private void buttonHandleEvent(ActionEvent event) throws IOException {
        if (event.getSource() == btnLogin) {
            buscarUsuario(txtUsuario.getText());

        }
    }

    private ObservableList<Usuarios> listaUsuarios;
    public String contraseñaDB;

    public void buscarUsuario(String nombreUsuario) {

        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_BuscarUsuario(?)}");
            procedimiento.setString(1, nombreUsuario);
            ResultSet registro = procedimiento.executeQuery();

            if (registro.next()) {
                contraseñaDB = registro.getString("contrasena");
                if (txtContra.getText().equals(contraseñaDB)) {

                    JOptionPane.showMessageDialog(null, "Bienvenid@ " + txtUsuario.getText());
                    escenarioPrincipal.menuPrincipalView();
                } else {
                    JOptionPane.showMessageDialog(null, "Contraseña o usuario no coinciden", "Error usuario", 0);
                }
            } else {
                JOptionPane.showMessageDialog(null, "Nombre de Usuario o contraseña Incorrectos", "Error inicio de sesion", 0);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

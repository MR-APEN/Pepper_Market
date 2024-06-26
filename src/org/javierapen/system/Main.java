/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.javierapen.system;

import java.io.InputStream;
import java.security.Principal;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.fxml.JavaFXBuilderFactory;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;
import org.javierapen.controller.MenuCargoEmpleadoController;
import org.javierapen.controller.MenuClienteController;
import org.javierapen.controller.MenuComprasController;
import org.javierapen.controller.MenuDetalleCompraController;
import org.javierapen.controller.MenuDetalleFacturaController;
import org.javierapen.controller.MenuEmailProveedorController;
import org.javierapen.controller.MenuEmpleadosController;
import org.javierapen.controller.MenuFacturaController;
import org.javierapen.controller.MenuLoginController;
import org.javierapen.controller.MenuPrincipalController;
import org.javierapen.controller.MenuProductosController;
import org.javierapen.controller.MenuProgramadorController;
import org.javierapen.controller.MenuProveedorController;
import org.javierapen.controller.MenuTelefonoProveedorController;
import org.javierapen.controller.MenuTipoProductoController;

/**
 * Nombre: Javier Alejandro Apen Solis Fecha: 11/04/2024 Fecha modificación:
 *
 * @author 50258
 */
public class Main extends Application {

    private Stage escenarioPrincipal;
    private Scene escena;
    private final String URLVIEW = "/org/javierapen/view/";

    @Override
    public void start(Stage escenarioPrincipal) throws Exception {
        this.escenarioPrincipal = escenarioPrincipal;
        this.escenarioPrincipal.setTitle("Pepper Market");
        escenarioPrincipal.getIcons().add(new Image(Principal.class.getResourceAsStream("/org/javierapen/image/Logo2.png")));
        MenuLoginView();
//Parent root = FXMLLoader.load(getClass().getResource("/org/javierapen/view/MenuPrincipalView.fxml"));
        //Scene escena = new Scene(root);
        //escenarioPrincipal.setScene(escena);
        escenarioPrincipal.show();
    }

    public Initializable cambiarEscena(String fxmlName, int width, int heigth) throws Exception {
        Initializable resultado;
        FXMLLoader loader = new FXMLLoader();

        InputStream file = Main.class.getResourceAsStream(URLVIEW + fxmlName);
        loader.setBuilderFactory(new JavaFXBuilderFactory());
        loader.setLocation(Main.class.getResource(URLVIEW + fxmlName));

        escena = new Scene((AnchorPane) loader.load(file), width, heigth);
        escenarioPrincipal.setScene(escena);
        escenarioPrincipal.sizeToScene();

        resultado = (Initializable) loader.getController();

        return resultado;
    }

    public void menuPrincipalView() {
        try {
            MenuPrincipalController menuPrincipalView = (MenuPrincipalController) cambiarEscena("MenuPrincipalView.fxml", 566, 570);
            menuPrincipalView.setEscenarioPrincipal(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void menuClientesView() {
        try {
            MenuClienteController menuClienteView = (MenuClienteController) cambiarEscena("MenuClienteView.fxml", 795, 441);
            menuClienteView.setEscenarioPrincipal(this);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void menuProgramadorView() {
        try {
            MenuProgramadorController menuProgramadorView = (MenuProgramadorController) cambiarEscena("MenuProgramadorView.fxml", 721, 405);
            menuProgramadorView.setEscenarioPrincipal(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void menuProveedorView() {
        try {
            MenuProveedorController menuProveedorView = (MenuProveedorController) cambiarEscena("MenuProveedorView.fxml", 873, 490);
            menuProveedorView.setEscenarioPrincipal(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void menuTipoProductoView() {
        try {
            MenuTipoProductoController menuTipoProductoView = (MenuTipoProductoController) cambiarEscena("MenuTipoProductoView.fxml", 800, 450);
            menuTipoProductoView.setEscenarioPrincipal(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void menuComprasView() {
        try {
            MenuComprasController menuComprasView = (MenuComprasController) cambiarEscena("MenuComprasView.fxml", 892, 501);
            menuComprasView.setEscenarioPrincipal(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void menuCargoEmpleadoView() {
        try {
            MenuCargoEmpleadoController menuCargoEmpleadoView = (MenuCargoEmpleadoController) cambiarEscena("MenuCargoEmpleadoView.fxml", 925, 522);
            menuCargoEmpleadoView.setEscenarioPrincipal(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void menuProductosView() {
        try {
            MenuProductosController menuProductosView = (MenuProductosController) cambiarEscena("MenuProductosView.fxml", 979, 552);
            menuProductosView.setEscenarioPrincipal(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void menuDetalleCompraView() {
        try {
            MenuDetalleCompraController MenuDetalleCompraView = (MenuDetalleCompraController) cambiarEscena("MenuDetalleCompraView.fxml", 979, 552);
            MenuDetalleCompraView.setEscenarioPrincipal(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void menuEmpleadosView() {
        try {
            MenuEmpleadosController MenuEmpleadosView = (MenuEmpleadosController) cambiarEscena("MenuEmpleadosView.fxml", 979, 552);
            MenuEmpleadosView.setEscenarioPrincipal(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void MenuTelefonoProveedorView() {
        try {
            MenuTelefonoProveedorController MenuTelefonoProveedorView = (MenuTelefonoProveedorController) cambiarEscena("MenuTelefonoProveedorView.fxml", 979, 552);
            MenuTelefonoProveedorView.setEscenarioPrincipal(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void MenuFacturaView() {
        try {
            MenuFacturaController MenuFacturaView = (MenuFacturaController) cambiarEscena("MenuFacturaView.fxml", 912, 516);
            MenuFacturaView.setEscenarioPrincipal(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void MenuDetalleFacturaView() {
        try {
            MenuDetalleFacturaController MenuDetalleFacturaView = (MenuDetalleFacturaController) cambiarEscena("MenuDetalleFacturaView.fxml", 942, 532);
            MenuDetalleFacturaView.setEscenarioPrincipal(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void MenuEmailProveedorView() {
        try {
            MenuEmailProveedorController MenuEmailProveedorView = (MenuEmailProveedorController) cambiarEscena("MenuEmailProveedorView.fxml", 945, 533);
            MenuEmailProveedorView.setEscenarioPrincipal(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void MenuLoginView() {
        try {
            MenuLoginController loginView = (MenuLoginController) cambiarEscena("MenuLoginView.fxml", 879, 550);
            loginView.setEscenarioPrincipal(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        launch(args);
    }

}

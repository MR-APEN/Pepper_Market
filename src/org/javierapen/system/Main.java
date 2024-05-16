/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.javierapen.system;

import java.io.InputStream;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.fxml.JavaFXBuilderFactory;
import javafx.scene.Scene;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;
import org.javierapen.controller.MenuCargoEmpleadoController;
import org.javierapen.controller.MenuClienteController;
import org.javierapen.controller.MenuComprasController;
import org.javierapen.controller.MenuPrincipalController;
import org.javierapen.controller.MenuProgramadorController;
import org.javierapen.controller.MenuProveedorController;
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
        menuPrincipalView();
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
            MenuPrincipalController menuPrincipalView = (MenuPrincipalController) cambiarEscena("MenuPrincipalView.fxml", 591, 394);
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
        try{
            MenuProgramadorController menuProgramadorView = (MenuProgramadorController)cambiarEscena("MenuProgramadorView.fxml",721,405);
            menuProgramadorView.setEscenarioPrincipal(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void menuProveedorView(){
        try{
            MenuProveedorController menuProveedorView = (MenuProveedorController)cambiarEscena("MenuProveedorView.fxml",873,490);
            menuProveedorView.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void menuTipoProductoView(){
        try{
            MenuTipoProductoController menuTipoProductoView = (MenuTipoProductoController)cambiarEscena("MenuTipoProductoView.fxml",800,450);
            menuTipoProductoView.setEscenarioPrincipal(this);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    
    public void menuComprasView(){
        try{
            MenuComprasController menuComprasView = (MenuComprasController)cambiarEscena("MenuComprasView.fxml",892,501);
            menuComprasView.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void menuCargoEmpleadoView(){
        try{
            MenuCargoEmpleadoController menuCargoEmpleadoView = (MenuCargoEmpleadoController)cambiarEscena("MenuCargoEmpleadoView.fxml",925,522);
            menuCargoEmpleadoView.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        launch(args);
    }

}


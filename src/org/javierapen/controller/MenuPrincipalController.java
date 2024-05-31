/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.javierapen.controller;

import java.net.URL;
import java.util.ResourceBundle;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.MenuItem;
import org.javierapen.system.Main;

/**
 * Herencia multiple concepto, Interfaz . POO
 */
public class MenuPrincipalController implements Initializable {

    private Main escenarioPrincipal;
    @FXML
    private MenuItem btnMenuClientes;
    @FXML
    private MenuItem btnMenuProgramador;
    @FXML
    private MenuItem btnMenuProveedor;
    @FXML
    private MenuItem btnMenuTipoProducto;
    @FXML
    private MenuItem btnMenuCompras;
    @FXML
    private MenuItem btnMenuCargoEmpleado;
    @FXML
    private MenuItem btnMenuProductos;
    @FXML
    private MenuItem btnMenuDetalleCompra;
    @FXML
    private MenuItem btnMenuEmpleados;
    @FXML
    private MenuItem btnMenuTelefonoProveedor;
    @FXML
    private MenuItem btnMenuFactura;
    @FXML
    private MenuItem btnMenuDetalleFactura;
    @FXML
    private MenuItem btnMenuEmailProveedor;

    @Override
    public void initialize(URL location, ResourceBundle resources) {

    }

    public Main getEscenarioPrincipal() {
        return escenarioPrincipal;
    }

    public void setEscenarioPrincipal(Main escenarioPrincipal) {
        this.escenarioPrincipal = escenarioPrincipal;
    }

    @FXML
    public void clicClientes(ActionEvent event) {
        if (event.getSource() == btnMenuClientes) {
            escenarioPrincipal.menuClientesView();
        }
    }

    @FXML
    public void clicProgramador(ActionEvent event) {
        if (event.getSource() == btnMenuProgramador) {
            escenarioPrincipal.menuProgramadorView();
        }
    }

    @FXML
    public void clicProveedor(ActionEvent event) {
        if (event.getSource() == btnMenuProveedor) {
            escenarioPrincipal.menuProveedorView();
        }
    }

    @FXML
    public void clicTipoProducto(ActionEvent event) {
        if (event.getSource() == btnMenuTipoProducto) {
            escenarioPrincipal.menuTipoProductoView();
        }
    }

    @FXML
    public void clicCompras(ActionEvent event) {
        if (event.getSource() == btnMenuCompras) {
            escenarioPrincipal.menuComprasView();
        }
    }

    @FXML
    public void clicCargoEmpleado(ActionEvent event) {
        if (event.getSource() == btnMenuCargoEmpleado) {
            escenarioPrincipal.menuCargoEmpleadoView();
        }
    }

    @FXML
    public void clicProductos(ActionEvent event) {
        if (event.getSource() == btnMenuProductos) {
            escenarioPrincipal.menuProductosView();
        }
    }

    @FXML
    public void clicDetalleCompra(ActionEvent event) {
        if (event.getSource() == btnMenuDetalleCompra) {
            escenarioPrincipal.menuDetalleCompraView();
        }
    }

    @FXML
    public void clicEmpleados(ActionEvent event) {
        if (event.getSource() == btnMenuEmpleados) {
            escenarioPrincipal.menuEmpleadosView();
        }
    }

    @FXML
    public void clicTelefonoProveedor(ActionEvent event) {
        if (event.getSource() == btnMenuTelefonoProveedor) {
            escenarioPrincipal.MenuTelefonoProveedorView();
        }
    }

    @FXML
    public void clicFactura(ActionEvent event) {
        if (event.getSource() == btnMenuFactura) {
            escenarioPrincipal.MenuFacturaView();
        }
    }

    @FXML
    public void clicDetalleFactura(ActionEvent event) {
        if (event.getSource() == btnMenuDetalleFactura) {
            escenarioPrincipal.MenuDetalleFacturaView();
        }
    }

    @FXML
    public void clicEmailProveedor(ActionEvent event) {
        if (event.getSource() == btnMenuEmailProveedor) {
            escenarioPrincipal.MenuEmailProveedorView();
        }
    }
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.javierapen.bean;

/**
 *
 * @author informatica
 */
public class Productos {
    private String codigoProducto;
    private String descripcionProducto;
    private double precioUnitario;
    private double precioDocena;
    private double precioMayor;
    private String imagenProducto;
    private int existencia;
    private int tipoProducto;
    private int proveedores;

    public Productos() {
    }

    public Productos(String codigoProducto, String descripcionProducto, double precioUnitario, double precioDocena, double precioMayor, String imagenProducto, int existencia, int tipoProducto, int proveedores) {
        this.codigoProducto = codigoProducto;
        this.descripcionProducto = descripcionProducto;
        this.precioUnitario = precioUnitario;
        this.precioDocena = precioDocena;
        this.precioMayor = precioMayor;
        this.imagenProducto = imagenProducto;
        this.existencia = existencia;
        this.tipoProducto = tipoProducto;
        this.proveedores = proveedores;
    }

    public String getCodigoProducto() {
        return codigoProducto;
    }

    public void setCodigoProducto(String codigoProducto) {
        this.codigoProducto = codigoProducto;
    }

    public String getDescripcionProducto() {
        return descripcionProducto;
    }

    public void setDescripcionProducto(String descripcionProducto) {
        this.descripcionProducto = descripcionProducto;
    }

    public double getPrecioUnitario() {
        return precioUnitario;
    }

    public void setPrecioUnitario(double precioUnitario) {
        this.precioUnitario = precioUnitario;
    }

    public double getPrecioDocena() {
        return precioDocena;
    }

    public void setPrecioDocena(double precioDocena) {
        this.precioDocena = precioDocena;
    }

    public double getPrecioMayor() {
        return precioMayor;
    }

    public void setPrecioMayor(double precioMayor) {
        this.precioMayor = precioMayor;
    }

    public String getImagenProducto() {
        return imagenProducto;
    }

    public void setImagenProducto(String imagenProducto) {
        this.imagenProducto = imagenProducto;
    }

    public int getExistencia() {
        return existencia;
    }

    public void setExistencia(int existencia) {
        this.existencia = existencia;
    }

    public int getTipoProducto() {
        return tipoProducto;
    }

    public void setTipoProducto(int tipoProducto) {
        this.tipoProducto = tipoProducto;
    }

    public int getProveedores() {
        return proveedores;
    }

    public void setProveedores(int proveedores) {
        this.proveedores = proveedores;
    }
    
    
}

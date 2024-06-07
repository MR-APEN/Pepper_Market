/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.javierapen.report;

import java.io.InputStream;
import java.util.Map;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.view.JasperViewer;
import org.javierapen.db.Conexion;

/**
 *
 * @author informatica
 */
public class GenerarReportes {

    public static void mostrarReporte(String nombreReporte, String titulo, Map parametro) {
        InputStream reporte = GenerarReportes.class.getResourceAsStream(nombreReporte);
        try {
            JasperReport reporteMaestro = (JasperReport) JRLoader.loadObject(reporte);
            JasperPrint reporteImpreso = JasperFillManager.fillReport(reporteMaestro, parametro, Conexion.getInstance().getConexion());
            JasperViewer visor = new JasperViewer(reporteImpreso);
            visor.setTitle(titulo);
            visor.setVisible(true);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}


/*
Interfaces Map
    HashMap es uno de los objetos que implementa un conjunto de key-value
    Tienen un cosntructor sin parametros new HashMap() y su finalidad suele
    referirse para agrupar informacion en un unico objeto.

Tiene cierta similitud con la coleccion de objetos ArrayList pero con la diferencia que estos
no tienen orden 

Hash hace referencia a una tecnica de organizacion de archivos  el hasing (abierto-cerrado) en la que
se almacena el registro de una direccion que es generada por una funcion se aplica a la llave
del registro dentro de memoria fisica

En java el Hasmap posee un espacio de memoria y cuando se guarda un objeto dicho 
espacion se determina su direccion, aplicando una funcion a la llave que le indiguemeo.
Cada objeto se identifica mediante algun identificador apropiado
 */

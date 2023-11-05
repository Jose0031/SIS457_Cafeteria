using CadCafeteria_G4;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClnCafeteria_G4
{
    public class VentaDetalleCln
    {
        public static int insertar(VentaDetalle ventaDetalle)
        {
            using (var context = new LabCafeteria_G4Entities())
            {
                context.VentaDetalle.Add(ventaDetalle);
                context.SaveChanges();
                return ventaDetalle.id;
            }
        }

        public static int actualizar(VentaDetalle ventaDetalle)
        {
            using (var context = new LabCafeteria_G4Entities())
            {
                var existente = context.VentaDetalle.Find(ventaDetalle.id);
                existente.cantidad = ventaDetalle.cantidad;
                existente.precioUnitario = ventaDetalle.precioUnitario;
                existente.total = ventaDetalle.total;
                existente.usuarioRegistro = ventaDetalle.usuarioRegistro;
                return context.SaveChanges();
            }
        }

        public static int eliminar(int id, string usuarioRegistro)
        {
            using (var context = new LabCafeteria_G4Entities())
            {
                var existente = context.VentaDetalle.Find(id);
                existente.estado = -1;
                existente.usuarioRegistro = usuarioRegistro;
                return context.SaveChanges();

            }
        }

        public static VentaDetalle get(int id)
        {
            using (var context = new LabCafeteria_G4Entities())
            {
                return context.VentaDetalle.Find(id);

            }
        }

        public static List<VentaDetalle> listar()
        {
            using (var context = new LabCafeteria_G4Entities())
            {
                return context.VentaDetalle.Where(x => x.estado != -1).ToList();

            }
        }

        public static List<paVentaDetalleListar_Result> listarPa()
        {
            using (var context = new LabCafeteria_G4Entities())
            {
                return context.paVentaDetalleListar().ToList();

            }
        }

        public static List<paVentaDetalleBuscar_Result> buscarPa(int parametro)
        {
            using (var context = new LabCafeteria_G4Entities())
            {
                return context.paVentaDetalleBuscar(parametro).ToList();

            }
        }
    }
}

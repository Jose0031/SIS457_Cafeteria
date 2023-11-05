using CadCafeteria_G4;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClnCafeteria_G4
{
    public class VentaCln
    {
        public static int insertar(Venta venta)
        {
            using (var context = new LabCafeteria_G4Entities())
            {
                context.Venta.Add(venta);
                context.SaveChanges();
                return venta.id;
            }
        }

        public static int actualizar(Venta venta)
        {
            using (var context = new LabCafeteria_G4Entities())
            {
                var existente = context.Venta.Find(venta.id);
                existente.idCliente = venta.idCliente;
                existente.totalVenta = venta.totalVenta;
                existente.usuarioRegistro = venta.usuarioRegistro;
                return context.SaveChanges();
            }
        }

        public static int eliminar(int id, string usuarioRegistro)
        {
            using (var context = new LabCafeteria_G4Entities())
            {
                var existente = context.Venta.Find(id);
                existente.estado = -1;
                existente.usuarioRegistro = usuarioRegistro;
                return context.SaveChanges();

            }
        }

        public static Venta get(int id)
        {
            using (var context = new LabCafeteria_G4Entities())
            {
                return context.Venta.Find(id);

            }
        }

        public static List<Venta> listar()
        {
            using (var context = new LabCafeteria_G4Entities())
            {
                return context.Venta.Where(x => x.estado != -1).ToList();

            }
        }

        public static List<paVentaListar_Result> listarPa()
        {
            using (var context = new LabCafeteria_G4Entities())
            {
                return context.paVentaListar().ToList();

            }
        }

        public static List<paVentaBuscar_Result> buscarPa(int parametro)
        {
            using (var context = new LabCafeteria_G4Entities())
            {
                return context.paVentaBuscar(parametro).ToList();

            }
        }
    }
}

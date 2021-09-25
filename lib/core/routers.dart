import 'package:reciclaje_app/page/aceptarVisitaCentro.dart';
import 'package:reciclaje_app/page/agendaCompraCentrodeAcopio.dart';
import 'package:reciclaje_app/page/carrodeOfertas.dart';
import 'package:reciclaje_app/page/formAgendaVisitaCivil.dart';
import 'package:reciclaje_app/page/carrodeDonacionCivil.dart';
import 'package:reciclaje_app/page/donacionFormCivil.dart';
import 'package:reciclaje_app/page/fromOfertasCentrodeAcopio.dart';
import 'package:reciclaje_app/page/inicioCentrodeAcopio.dart';
import 'package:reciclaje_app/page/inicioCiudadanoCivil.dart';
import 'package:reciclaje_app/page/listaRecicladores.dart';
import 'package:reciclaje_app/page/listaVisitasAcpetadasdeCentro.dart';
import 'package:reciclaje_app/page/listaVisitasAgendadas.dart';
import 'package:reciclaje_app/page/listaVentasSolicitadas.dart';
import 'package:reciclaje_app/page/listadeOfertasReciclador.dart';
import 'package:reciclaje_app/page/pageEditar.dart';
import 'package:reciclaje_app/page/rutadelDia.dart';
import 'package:reciclaje_app/page/donacienenEspera.dart';
import 'package:reciclaje_app/page/ventasForm.dart';
import 'package:reciclaje_app/page/index.dart';
import 'package:flutter/material.dart'
    show Center, MaterialPageRoute, Route, RouteSettings, Scaffold, Text;
import 'package:reciclaje_app/page/visitaAgendada.dart';
import 'package:reciclaje_app/page/visitaClientesMap.dart';
import 'package:reciclaje_app/page/visitaDisponibleProgramada.dart';
import 'package:reciclaje_app/page/visitaDisponibles.dart';
import 'package:reciclaje_app/page/visitaProgramadas.dart';
import 'constants.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case intialRoute:
        return MaterialPageRoute(builder: (_) => Login());
      case registerRoute:
        return MaterialPageRoute(builder: (_) => RegistroPage());
      case inicioReciclador:
        return MaterialPageRoute(builder: (_) => InicioReciclador());
      case ventasForm:
        return MaterialPageRoute(builder: (_) => VentasForm());
      case carrodeVentas:
        return MaterialPageRoute(builder: (_) => CarroDeVentas());
      case inicioCiudadanoCivil:
        return MaterialPageRoute(builder: (_) => InicioCiudadanoCivil());
      case donacionFormCivil:
        return MaterialPageRoute(builder: (_) => DonacionFormCivil());
      case carrodeDonacionCivil:
        return MaterialPageRoute(builder: (_) => CarrodeDonacionCivil());
      case formAgendaVisitaCivil:
        return MaterialPageRoute(builder: (_) => FormAgendaVisitaCivil());
      case pageEditar:
        final int args = settings.arguments;
        return MaterialPageRoute(builder: (_) => PageEditar(args));
      case visitaDisponibles:
        return MaterialPageRoute(builder: (_) => VisitaCivilesDisponibles());
      case visitaAgendada:
        return MaterialPageRoute(builder: (_) => VisitaAgendada());
      case listaRecicladores:
        return MaterialPageRoute(builder: (_) => ListaRecicladores());
      case visitaClientesMap:
        return MaterialPageRoute(builder: (_) => VisitaClientesMap());
      case rutadelDia:
        return MaterialPageRoute(builder: (_) => RutadelDia());
      case donacionesenEspera:
        return MaterialPageRoute(builder: (_) => DonacionesenEspera());
      case listaVisitasAgendadas:
        return MaterialPageRoute(builder: (_) => ListaVistasAgendadas());
      case visitaProgramadas:
        return MaterialPageRoute(builder: (_) => VisitaProgramadas());
      case visitaDisponibleProgramada:
        return MaterialPageRoute(builder: (_) => VisitaDisponibleProgramada());
      case inicioCentrodeAcopio:
        return MaterialPageRoute(builder: (_) => InicioCentrodeAcopio());
      case fromOfertasCentrodeAcopio:
        return MaterialPageRoute(builder: (_) => OfertasCentrosdeAcopio());
      case carrodeOfertas:
        return MaterialPageRoute(builder: (_) => CarrodeOfertas());
      case ofertasCentrodeAcopioReciclador:
        return MaterialPageRoute(builder: (_) => OfertasCentrosdeAcopio());
      case agendaCompraCentrodeAcopio:
        return MaterialPageRoute(builder: (_) => AgendaCompraCentrodeAcopio());
      case listadeOfertasReciclador:
        return MaterialPageRoute(builder: (_) => ListaOfertasReciclador());
      case listaVisitasAceptadasdeCentro:
        return MaterialPageRoute(builder: (_) => ListaVistaHechasdeCentro());
      case aceptarVisitaCentro:
        return MaterialPageRoute(builder: (_) => AceptarVisitaCentro());
      case listaVentasSolicitadas:
        return MaterialPageRoute(builder: (_) => ListaVentasSolicitadas());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('La ruta no esta especificada para ${settings.name}'),
            ),
          ),
        );
    }
  }
}

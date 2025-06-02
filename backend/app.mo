import Nat "mo:base/Nat";
import List "mo:base/List";
import Text "mo:base/Text";

actor {

  public type Cultivo = {
    id: Nat;
    nombre: Text;
    variedad: Text;
    fechaSiembra: Text;
    ubicacion: Text;
    etapaDesarrollo: Text;
    alturaPromedio: Text;
    sintomasVisibles: Text;
    plagas: ?Text;
    productoAplicado: ?Text;
    fertilizante: ?Text;
    fechasClave: {
      siembra: Text;
      floracion: ?Text;
      cosecha: ?Text;
    };
  };

  var cultivos: List.List<Cultivo> = List.nil<Cultivo>();
  var nextId: Nat = 0;

  public func addCultivo(c: Cultivo) : async Nat {
    let newCultivo: Cultivo = { c with id = nextId };
    cultivos := List.push<Cultivo>(newCultivo, cultivos);
    nextId += 1;
    return newCultivo.id;
  };

  public func listCultivos() : async [Cultivo] {
    return List.toArray<Cultivo>(cultivos);
  };

  public func getCultivo(id: Nat) : async ?Cultivo {
    return List.find<Cultivo>(cultivos, func(c: Cultivo) : Bool { c.id == id });
  };

  public func updateCultivo(updated: Cultivo) : async Bool {
    let newList: List.List<Cultivo> = List.map<Cultivo, Cultivo>(
      cultivos,
      func(c: Cultivo) : Cultivo {
        if (c.id == updated.id) {
          updated
        } else {
          c
        }
      }
    );
    cultivos := newList;
    return true;
  };

  public func deleteCultivo(id: Nat) : async Bool {
    cultivos := List.filter<Cultivo>(
      cultivos,
      func(c: Cultivo) : Bool {
        c.id != id
      }
    );
    return true;
  };
}
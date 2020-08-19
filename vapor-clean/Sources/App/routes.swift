import Routing
import Vapor

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)
public func routes(_ router: Router) throws {
    router.get { req -> Future<View> in
        return Client.query(on: req).all().flatMap(to: View.self){
            clients in
            return try req.view().render("home", ["clients" : clients])
        }
    }
    
    router.post(Client.self, at: "add"){ req, client ->
        Future<Response> in
        return client.save(on: req).map(to: Response.self) {
            client in
            return req.redirect(to: "/")
        }
    }
    //sort clients
    router.get("clients"){ req -> Future<[Client]> in
        return Client.query(on: req).sort(\.name).all()
    }
    
}

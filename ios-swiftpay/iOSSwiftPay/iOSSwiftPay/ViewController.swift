//
//  ViewController.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 17/08/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    @IBOutlet var clientsTableView: UITableView!
    var clients = [Client]()

    override func viewDidLoad() {
        super.viewDidLoad()
        clientsTableView.backgroundColor = .red
        fetchData()
    }

    func fetchData(){
        let url = URL(string: "http://localhost:8080/clients")!
        
        URLSession.shared.dataTask(with: url) { data, response, error
            in
            guard let data = data else {
                print(error?.localizedDescription ?? "Erro desconhecido")
                return
            }
            
            let decoder = JSONDecoder()
            
            if let clients = try? decoder.decode([Client].self, from: data){
                DispatchQueue.main.async {
                    self.clients = clients
                    self.tableView.reloadData()
                    print("Obteve \(clients.count) clientes.")
                }
            }
            else {
                print("Não foi possível fazer parse da resposta JSON.")
            }
        }.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let client = clients[indexPath.row]
        
        cell.textLabel?.text = "\(client.name)"
        cell.detailTextLabel?.text = "\(client.cpf)"
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//        let client = clients[indexPath.row]
//        let ac = UIAlertController(title: "Cliente", message: <#T##String?#>, preferredStyle: <#T##UIAlertController.Style#>)
//    }
    
}


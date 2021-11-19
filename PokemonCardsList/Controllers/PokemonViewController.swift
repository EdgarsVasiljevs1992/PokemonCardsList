//
//  PokemonViewController.swift
//  PokemonCardsList
//
//  Created by edgars.vasiljevs on 19/11/2021.
//

import UIKit

class PokemonViewController: UIViewController {
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    var pokey: [Pokemon] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getPokemonData()
    }
    
    func getPokemonData(){
        let jsonUrl = "https://api.pokemontcg.io/v1/cards"
        guard let url = URL(string: jsonUrl) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        
        URLSession(configuration: config).dataTask(with: request) { (dataPok, response, err)  in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            guard let data = dataPok else {
                print(String(describing: err))
                return
            }
            do{
                let jsonData = try JSONDecoder().decode(Card.self, from: data)
                self.pokey = jsonData.cards
                DispatchQueue.main.async {
                    print("jsonData", jsonData)
                    self.tableViewOutlet.reloadData()
                }
            }catch{
                print("err:", error)
            }
        }.resume()
    }

}


extension PokemonViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokey.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokeyCell", for: indexPath) as? PokeyTableViewCell else { return UITableViewCell()}
        
        let poke = pokey[indexPath.row]
        cell.setupUI(withDataFrom: poke)
//        cell.pokeyImageView.image = UIImage(named: poke.image)
//        cell.nameLabel.text = poke.name
//        cell.supertypeLabel.text = poke.supertype
//        cell.subtypeLabel.text = poke.subtype
//        cell.hpLabel.text = poke.number
//        @IBOutlet weak var pokeyImageView: UIImageView!
//
//        @IBOutlet weak var nameLabel: UILabel!
//        @IBOutlet weak var supertypeLabel: UILabel!
//        @IBOutlet weak var subtypeLabel: UILabel!
//        @IBOutlet weak var hpLabel: UILabel!
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    
//    #warning("Home task - Navigata to DetailViewController and present the same data you have inside the cell into new ViewController, similar we had in TrackList")
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableViewOutlet.indexPathForSelectedRow {
            print("indexPath: ", indexPath)
       // Get the new view controller using segue.destination.
            let detailVC = segue.destination as! DetailViewController
            // Pass the selected object to the new view controller.
            detailVC.card = pokey[indexPath.row]
        }
    }
}



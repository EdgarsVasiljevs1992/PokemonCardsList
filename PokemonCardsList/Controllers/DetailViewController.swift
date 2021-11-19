//
//  DetailViewController.swift
//  PokemonCardsList
//
//  Created by edgars.vasiljevs on 19/11/2021.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var supertypeLabel: UILabel!
    @IBOutlet weak var subtypeLabel: UILabel!
    
    var card: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if card != nil{
            //imageView.image = UIImage(named: card.image)
            imageView.sd_setImage(with: URL(string: card.image), placeholderImage: UIImage(named: "pok.png"))
            nameLabel.text = "Name: " + card.name
            supertypeLabel.text = "Type: " + card.supertype!
            subtypeLabel.text = "Card: " + card.subtype!
            numberLabel.text = "Card value: " + card.number
            }
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

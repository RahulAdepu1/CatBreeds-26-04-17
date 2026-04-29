//
//  CatDetailsViewController.swift
//  Cat-Demo
//
//  Created by Rahul Adepu on 4/17/26.
//

import UIKit

class CatDetailsViewController: UIViewController {
    
    var breed: CatBreed?
    var catImage: UIImage?
    var viewModel: CatDetailsViewModel = CatDetailsViewModel()

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperamentLabel: UILabel!
    @IBOutlet weak var lifeSpanLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.catImageDelegate = self
        self.viewModel.breed = breed
        setUpUI()
        
    }
    
    func setUpUI(){
        nameLabel.text = "Name: \(breed?.name ?? "Breed Name")"
        descriptionLabel.text = "Description: \(breed?.description ?? "Breed Details")"
        temperamentLabel.text = "Temperament: \(breed?.temperament ?? "Breed Temperament")"
        lifeSpanLabel.text = "Life Span: \(breed?.life_span ?? "Breed Life Span")"
        title = "Breed Details"

        guard let cat = breed, let catId = cat.id else{return}
        viewModel.getCatImage(breedId: catId)
        
    }
}

extension CatDetailsViewController: CatImageDelegate {
    func imageChangedNotification() {
        DispatchQueue.main.async {
            self.imageView.contentMode = .scaleAspectFit
            self.imageView.image = self.viewModel.catImage
        }
    }
}




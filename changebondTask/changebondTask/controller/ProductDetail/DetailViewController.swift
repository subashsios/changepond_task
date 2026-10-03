//
//  DetailViewController.swift
//  changebondTask
//
//  Created by Apple  on 10/02/26.
//
//
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var prodectImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var rating: UIButton!
    @IBOutlet weak var Pricediscount: UIButton!
    @IBOutlet weak var Availabilitybadge: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var ImageFullViewButton: UIButton!
    var product: Product?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    private func configureUI() {
        guard let product = product else { return }
        prodectDataAdded()
        ImageFullViewButton.addTarget(self,action:#selector(showFullImage),for: .touchUpInside)
        buyButton.addTarget(self,action:#selector(buyButtonAction),for: .touchUpInside)
        
    }
    func prodectDataAdded(){
        titleLabel.text = product?.title
        brandLabel.text = product?.description
        prodectImage.image = UIImage(systemName: "photo")
        prodectImage.loadImage(from: product?.thumbnail ?? "")
        navigationItem.title = "Products Detail View"
        let value = product?.rating ?? 0.0
        rating.setTitle(String(format: "%.1f", value), for: .normal)
        rating.layer.cornerRadius = 5
        rating.clipsToBounds = true
        let price = product?.price ?? 0.0
        let discount = product?.discountPercentage ?? 0.0
        
        Pricediscount.setTitle(
            String(format: "$%.2f  •  %.0f%% OFF", price, discount),
            for: .normal
        )
        let stock = product?.stock ?? 0
        let status = product?.availabilityStatus ?? ""
        Availabilitybadge.text = " \(status) \(stock) "
        Pricediscount.backgroundColor = .systemGreen
        Pricediscount.setTitleColor(.white, for: .normal)
        Pricediscount.layer.cornerRadius = 5
        Pricediscount.clipsToBounds = true
        Availabilitybadge.backgroundColor = .clear
        Availabilitybadge.textColor = .systemGreen
        Availabilitybadge.layer.borderWidth = 1
        Availabilitybadge.layer.borderColor = UIColor.systemGreen.cgColor
    }
    
    @objc private func showFullImage() {
        let vc = storyboard?.instantiateViewController(
            withIdentifier: "finalView"
        ) as! finalView
        vc.imageToShow = prodectImage.image
        vc.viewSeparator = "ImageView"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func buyButtonAction() {
        let vc = storyboard?.instantiateViewController(
            withIdentifier: "finalView"
        ) as! finalView
        vc.imageToShow = prodectImage.image
        vc.viewSeparator = "orderView"
        vc.productName = product?.title
        vc.priceText = "$\(product?.price ?? 0.0)"
        navigationController?.pushViewController(vc, animated: true)
    }
}

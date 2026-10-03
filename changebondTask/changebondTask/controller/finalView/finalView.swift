//
//  finalView.swift
//  changebondTask
//
//  Created by Apple  on 10/02/26.
//

import UIKit

class finalView: UIViewController {
    @IBOutlet weak var successImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    var productName: String?
    var priceText: String?
    // image view
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var image: UIImageView!
    var imageToShow: UIImage?
    var viewSeparator = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isHidden = true
        viewSeparatorFunc()
    }
    
    func viewSeparatorFunc(){
        if viewSeparator == "ImageView"{
            imageView.isHidden = false
            image.image = imageToShow
            imageView.contentMode = .scaleAspectFit
        } else if viewSeparator == "orderView"{
            setupUI()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true
        successImage.image = UIImage(systemName: "checkmark.circle.fill")
        successImage.tintColor = .systemGreen
        titleLabel.text = "Order Placed Successfully"
        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.textAlignment = .center
        
        productLabel.text = "\(productName ?? "")\n\(priceText ?? "")"
        productLabel.numberOfLines = 0
        productLabel.textAlignment = .center
        productLabel.textColor = .secondaryLabel
        
        continueButton.setTitle("Continue Shopping", for: .normal)
        continueButton.backgroundColor = .systemBlue
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.layer.cornerRadius = 8
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
    }
    
    @objc private func continueTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
}


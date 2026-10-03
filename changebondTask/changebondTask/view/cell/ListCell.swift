//
//  ListCell.swift
//  changebondTask
//
//  Created by Apple  on 09/02/26.
//

import UIKit

class ListCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var outerView: UIView!
    
    @IBOutlet weak var productDetailButton: UIButton!
    var buttonAction: (() -> Void)?
    var imageTapAction: (() -> Void)?

        @IBAction func detailButtonTapped(_ sender: UIButton) {
            buttonAction?()
        }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupOuterView()
        setupImageTap()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    private func setupImageTap() {
            productImage.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            productImage.addGestureRecognizer(tap)
        }
    @objc private func imageTapped() {
        imageTapAction?()
    }
    private func setupOuterView() {
           outerView.layer.cornerRadius = 15
           outerView.layer.borderWidth = 1
           outerView.layer.borderColor = UIColor.lightGray.cgColor
           outerView.layer.masksToBounds = true
       }
}

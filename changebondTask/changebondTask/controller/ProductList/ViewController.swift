//
//  ViewController.swift
//  changebondTask
//
//  Created by Apple  on 09/02/26.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let viewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        tableView.keyboardDismissMode = .onDrag
        
        let nib = UINib(nibName: "ListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ListCell")
        
        bindViewModel()
        viewModel.fetchProducts()
        
        navigationItem.title = "Products"
    }
    
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    func bindViewModel() {
        viewModel.reloadTable = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    private func showFullImage(image: UIImage?) {
        let vc = storyboard?.instantiateViewController(
            withIdentifier: "finalView"
        ) as! finalView
        vc.imageToShow = image
        vc.viewSeparator = "ImageView"
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ListCell",
            for: indexPath
        ) as! ListCell
        let product = viewModel.product(at: indexPath.row)
        cell.productTitleLabel.text = product.title
        cell.productDescriptionLabel.text = product.description
        cell.productImage.image = UIImage(systemName: "photo")
        cell.productImage.loadImage(from: product.thumbnail ?? "")
        cell.buttonAction = { [weak self] in
            self?.navigateToDetail(product: product)
        }
        cell.imageTapAction = { [weak self] in
            self?.showFullImage(image: cell.productImage.image)
        }
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterProducts(searchText: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension ViewController {
    
    func navigateToDetail(product: Product) {
        let vc = storyboard?.instantiateViewController(
            withIdentifier: "detailView"
        ) as! DetailViewController
        
        vc.product = product
        navigationController?.pushViewController(vc, animated: true)
    }
}



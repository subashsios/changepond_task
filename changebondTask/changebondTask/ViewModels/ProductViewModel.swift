//
//  ProductViewModel.swift
//  changebondTask
//
//  Created by Apple  on 10/02/26.
//


import Foundation
import Alamofire


class ProductViewModel {

    private var products: [Product] = []
    private var filteredProducts: [Product] = []

    var reloadTable: (() -> Void)?
   
  
//MARK: - Alamofire
    func fetchProducts() {

        guard let url = URL(string: "https://dummyjson.com/products") else { return }

        AF.request(url, method: .get).validate().responseDecodable(of: ProductResponse.self) { [weak self] response in
                switch response.result {
                case .success(let decoded):
                    self?.products = decoded.products
                    self?.filteredProducts = decoded.products
                    DispatchQueue.main.async {
                        self?.reloadTable?()
                    }
                case .failure(let error):
                    print("API Error:", error.localizedDescription)
                }
            }
    }
    
    //MARK: - URLSession section
//    func fetchProducts() {
//        guard let url = URL(string: "https://dummyjson.com/products") else { return }
//
//        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
//            guard let data = data else { return }
//
//            do {
//                let decoded = try JSONDecoder().decode(ProductResponse.self, from: data)
//                self?.products = decoded.products
//                self?.filteredProducts = decoded.products
//                self?.reloadTable?()
//            } catch {
//                print("API Error : \(error)")
//            }
//        }.resume()
//    }
    

    func filterProducts(searchText: String) {
        if searchText.isEmpty {
            filteredProducts = products
        } else {
            filteredProducts = products.filter {
                $0.title!.lowercased().contains(searchText.lowercased())
            }
        }
        reloadTable?()
    }

    func numberOfRows() -> Int {
        return filteredProducts.count
    }

    func product(at index: Int) -> Product {
        return filteredProducts[index]
    }
}

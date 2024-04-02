//
//  ConstructorViewModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/02.
//

import Foundation

class ConstructorViewModel {
    
    private var repository: F1RepositoryType?
    private weak var delegate: ViewModelDelegate?
    private var constructor: Constructor?
    
    init(repository: F1RepositoryType,
         delegate: ViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
    
    func fetchConstructor(constructorName: String) {
        repository?.fetchConstructorResults(constructor:constructorName,completion: { [weak self] result in
            switch result {
            case .success(let constructor):
                self?.constructor = constructor.mrData.constructorTable.constructors[0]
                print(self?.constructor?.name ?? "No result")
                self?.delegate?.reloadView()
            case .failure(let error):
                print(error)
                self?.delegate?.show(error: error.rawValue)
            }
        })
    }
}

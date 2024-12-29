//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Nikita Khon on 29.12.2024.
//

import UIKit

protocol AlertPresenterProtocol {
    func showAlert(with alertModel: AlertModel)
}

final class AlertPresenter: AlertPresenterProtocol {
    
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func showAlert(with alertModel: AlertModel) {
        let alert = UIAlertController(
            title: alertModel.title,
            message: alertModel.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: alertModel.buttonText, style: .default) { _ in
            alertModel.completion()
        }
        
        alert.addAction(action)
        
        viewController?.present(alert, animated: true, completion: nil)
    }
}

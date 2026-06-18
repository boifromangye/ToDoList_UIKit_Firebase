//
//  AddTaskViewController.swift
//  ToDoList_UIKit_Firebase
//
//  Created by 권태우 on 6/18/26.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    weak var delegate: AddTaskViewControllerDelegate?
    private let textField = UITextField()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupTextField()
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(didTapCancel)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(didTapSave)
        )
    }

    private func setupTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "예) Swift 공부하기"
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .done
        textField.delegate = self
        view.addSubview(textField)

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func didTapSave() {
        guard let text = textField.text, !text.isEmpty else { return }
        delegate?.onSave(newTask: text)
        navigationController?.popViewController(animated: true)
    }

    @objc private func didTapCancel() {
        navigationController?.popViewController(animated: true)
    }
}

extension AddTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didTapSave()
        return true
    }
}

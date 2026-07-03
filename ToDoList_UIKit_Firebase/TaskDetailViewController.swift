//
//  TaskDetailViewController.swift
//  ToDoList_UIKit_Firebase
//
//  Created by 권태우 on 6/18/26.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    weak var delegate: TaskDetailViewControllerDelegate?
    let task: String
    let id: String
    let textField = UITextField()
    let deleteButton = UIButton(type: .system)
    
    init(task: String, id: String) {
        self.task = task
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupTextField()
        setupDeleteButton()
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(didTapSave)
        )
    }
    
    private func setupTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = task
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

    private func setupDeleteButton() {
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.setTitle("삭제", for: .normal)
        deleteButton.setTitleColor(.systemRed, for: .normal)
        deleteButton.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
        view.addSubview(deleteButton)

        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func didTapSave() {
        guard let text = textField.text, !text.isEmpty else { return }
        delegate?.onEdit(id: id, editedTask: text)
        navigationController?.popViewController(animated: true)
    }

    @objc private func didTapDelete() {
        delegate?.onDelete(id: id)
        navigationController?.popViewController(animated: true)
    }
}

extension TaskDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didTapSave()
        return true
    }
}

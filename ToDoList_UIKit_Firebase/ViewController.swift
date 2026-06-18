//
//  ViewController.swift
//  ToDoList_UIKit_Firebase
//
//  Created by 권태우 on 6/18/26.
//

import UIKit

class ViewController: UIViewController {
    
    private let tableView = UITableView()
    var tasks = [
        "Do laundry", "Do assignments", "Make a reservation",
        "Drink coffee", "Go to the gym", "Take a walk",
        "Read a book", "Watch a movie", "Make BEC", "Send an email"

    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setUpTableView()
        setupNavigationBar()
    }
    
    func setUpTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupNavigationBar() {
        title = "할 일 목록"

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapAddButton)
        )
    }
    
    @objc func didTapAddButton() {
        let vc = AddTaskViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: AddTaskViewControllerDelegate {
    func onSave(newTask: String) {
        tasks.append(newTask)
        tableView.reloadData()
    }
}

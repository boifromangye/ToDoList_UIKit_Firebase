//
//  ViewController.swift
//  ToDoList_UIKit_Firebase
//
//  Created by 권태우 on 6/18/26.
//

import UIKit

class ViewController: UIViewController {
    
    private let tableView = UITableView()
    var tasks: [TaskItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setUpTableView()
        setupNavigationBar()
        loadTasks()
    }

    func loadTasks() {
        Task {
            tasks = await getTasks()
            tableView.reloadData()
        }
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
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title
        cell.accessoryType = task.check ? .checkmark : .none
        return cell
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = TaskDetailViewController(task: tasks[indexPath.row].title, id: tasks[indexPath.row].id)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: AddTaskViewControllerDelegate, TaskDetailViewControllerDelegate {
    func onDelete(id: String) {
        Task {
            await deleteTask(id: id)
            loadTasks()
        }
    }
    
    func onEdit(id: String, editedTask: String) {
        Task {
            await editTask(id: id, title: editedTask)
            loadTasks()
        }
    }
    
    func onSave(newTask: String) {
        Task {
            await addTask(title: newTask)
            loadTasks()
        }
    }
}

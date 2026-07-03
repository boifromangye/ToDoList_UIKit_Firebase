//
//  TaskDetailViewControllerDelegate.swift
//  ToDoList_UIKit_Firebase
//
//  Created by 권태우 on 6/18/26.
//

protocol TaskDetailViewControllerDelegate: AnyObject {
    func onEdit(id: String, editedTask: String)
    func onDelete(id: String)
}

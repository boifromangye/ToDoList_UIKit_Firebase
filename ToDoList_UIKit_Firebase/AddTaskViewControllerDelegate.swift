//
//  AddTaskViewControllerDelegate.swift
//  ToDoList_UIKit_Firebase
//
//  Created by 권태우 on 6/18/26.
//

protocol AddTaskViewControllerDelegate: AnyObject {
    func onSave(newTask: String)
}

/*
/// Module: todolist
module todolist::todolist;
*/

// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions

module todolist::todolist;

use std::string::{Self, String};
use sui::object::{Self, UID};
use sui::transfer;
use sui::tx_context::{Self, TxContext};

const ERROR_LIST_EMPTY: u64 = 0;
const ERROR_TASK_NOT_FOUND: u64 = 1;

public struct TodoList has key {
    id: UID,
    tasks: vector<Task>,
}

public struct Task has key, store {
    id: UID,
    description: String,
    completed: bool,
}

public entry fun create_todolist(ctx: &mut TxContext) {
    let tasks = vector::empty<Task>();
    let todo_list = TodoList { id: object::new(ctx), tasks };
    transfer::transfer(todo_list, tx_context::sender(ctx));
}

public entry fun create_task(description: String, todo_list: &mut TodoList, ctx: &mut TxContext) {
    let task = Task {
        id: object::new(ctx),
        description,
        completed: false,
    };

    vector::push_back(&mut todo_list.tasks, task);
}

public fun get_task_index(task: &Task, todo_list: &TodoList): u64 {
    let mut i = 0;
    let len = vector::length(&todo_list.tasks);

    while (i < len) {
        let current_task = vector::borrow(&todo_list.tasks, i);
        if (object::uid_to_inner(&task.id) == object::uid_to_inner(&current_task.id)) {
            return i
        };
        i = i + 1;
    };
    abort ERROR_TASK_NOT_FOUND
}

public entry fun delete_task(task: &Task, todo_list: &mut TodoList) {
    let task_index = get_task_index(task, todo_list);

    let deleteTask = vector::remove(&mut todo_list.tasks, task_index);
    let Task { id, .. } = deleteTask;
    object::delete(id);
}

public entry fun complete_task(todo_list: &mut TodoList, task: &Task) {
    let task_index = get_task_index(task, todo_list);
    let complete_task = vector::borrow_mut(&mut todo_list.tasks, task_index);
    complete_task.completed = true;
}

public entry fun revert_task(todo_list: &mut TodoList, task: &Task) {
    let task_index = get_task_index(task, todo_list);
    let revert_task = vector::borrow_mut(&mut todo_list.tasks, task_index);
    revert_task.completed = false;
}

fun init(ctx: &mut TxContext) {}

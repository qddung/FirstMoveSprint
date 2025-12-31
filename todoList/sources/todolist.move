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

public struct Task has key, store {
    id: UID,
    description: String,
    completed: bool,
}

public struct TodoList has key {
    id: UID,
    tasks: vector<address>, // store Task object IDs
}

public entry fun create_todo_list(ctx: &mut TxContext) {
    let tasks = vector::empty<address>();
    let todo_list = TodoList { id: object::new(ctx), tasks };
    transfer::transfer(todo_list, tx_context::sender(ctx));
}

public entry fun create_task(description: String, todo_list: &mut TodoList, ctx: &mut TxContext) {
    let task = Task {
        id: object::new(ctx),
        description,
        completed: false,
    };
    let task_address = object::uid_to_address(&task.id);
    vector::push_back(&mut todo_list.tasks, task_address);

    transfer::transfer(task, tx_context::sender(ctx));
}

public fun get_task_index(task: &Task, todo_list: &TodoList): u64 {
    let mut i = 0;
    let len = vector::length(&todo_list.tasks);

    let address_of_task = object::uid_to_address(&task.id);

    while (i < len) {
        let current_address = vector::borrow(&todo_list.tasks, i);
        if (address_of_task == current_address) {
            return i
        };
        i = i + 1;
    };
    abort ERROR_TASK_NOT_FOUND
}

public entry fun delete_task(taskDelete: Task, todo_list: &mut TodoList) {
    let task_index = get_task_index(&taskDelete, todo_list);

    let _ = vector::remove(&mut todo_list.tasks, task_index);
    let Task { id, .. } = taskDelete;
    object::delete(id);
}

public entry fun complete_task(task: &mut Task) {
    task.completed = true;
}

public entry fun revert_task(task: &mut Task) {
    task.completed = false;
}

fun init(ctx: &mut TxContext) {}

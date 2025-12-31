# 📝 Bounty Submission – Week 1
### Road to First Movers Sprint 2026
---------------------------------------
## 👤 Participant Information
+ Full Name: Trần Quốc Dũng
+ Email: dungtranquocdev@gmail.com
+ Telegram: @brad
+ Discord: @maxiowen
---------------------------------------
## 🚀 Project Overview
+ Project Name: TodoList
+ Short Description (1–2 sentences): a package allow user create many todo list object allow owner create, update, delete task on them
---------------------------------------
## 💻 Source Code
+ Github Repository: https://github.com/qddung/FirstMoveSprint
---------------------------------------
## 🎥 Demo Video
+ Link: https://www.youtube.com/watch?v=k05BQgc7Pgs
---------------------------------------
⛓️ On-chain Transaction
+ Network: Sui Testnet
+ PackageID: 0xbd094de60a1fb006be4eedaeee0a3bb89972a0fe6d3409b441d8f289b567f420
+ Transaction Hash: G1B4SEWVYqZHqhA8MWy8N3kAT8sNtBK26iAeZEjehYqC
---------------------------------------
## 🧠 Technical Details
- **What did you build ?**
    + TodoList Object: A user-owned container that stores a vector of tasks. Each user can create their own todo list that is transferred to them upon creation  
    + Task Object. Individual task items with three properties:
        + Unique identifier (UID)
        + Description (String)
        + Completion status (boolean)
- **Key Move Concepts Used**
    + Object Model & Abilities
    + Ownership & Transfer
    + Entry Functions
    + Transaction Context
    + Vector Operations
    + Object Lifecycle Management
    + Error Handling
---------------------------------------
🧩 Challenges & Solutions
### **Challenges Faced:**
1. **Understanding TxContext and Sender Address**
   - Initially unclear how to get the sender's address in Sui Move
   - Confusion about the transfer function location

2. **UID Creation and Object Initialization**
   - Error: "unexpected name in this position" when trying to create UIDs
   - Attempted to use `UID::new(ctx)` which doesn't exist in Sui

3. **Ability Constraints with UID Comparison**
   - Error: "ability constraint not satisfied" when comparing UIDs with `==`
   - UID doesn't have the `drop` ability, so direct comparison fails

4. **Module Member Resolution**
   - Error: "unbound module member" when calling transfer functions
   - Used wrong module (`tx_context::transfer` instead of `transfer::transfer`)

5. **Architecture Decision: Task Storage Pattern**
   - Initially stored tasks in vector but tried to transfer them simultaneously
   - Error: "use of unassigned variable" - tried to use task after it was moved
   - Confusion about whether tasks should be owned separately or stored in TodoList

6. **Reference vs Owned Values**
   - Error with `vector::borrow_mut` returning `&mut UID` but `object::delete` needing owned `UID`
   - Confusion between when to use `borrow`, `borrow_mut`, and `remove`
### **How You Solved Them:**

1. **TxContext Solution:**
   - Imported `use sui::tx_context::{Self, TxContext}`
   - Used `tx_context::sender(ctx)` to get sender address
   - Imported `use sui::transfer` and used `transfer::transfer()` for object transfers

2. **UID Creation Solution:**
   - Changed from `UID::new(ctx)` to `object::new(ctx)`
   - This is the correct way to create new UIDs in Sui Move

3. **UID Comparison Solution:**
   - Used `object::uid_to_inner()` to convert UID to comparable inner value
   - Changed from `task.id == current_task.id` to `object::uid_to_inner(&task.id) == object::uid_to_inner(&current_task.id)`

4. **Module Import Solution:**
   - Added proper import: `use sui::transfer`
   - Used correct function call: `transfer::transfer(object, recipient)`

5. **Architecture Solution:**
   - Chose to transfer each Task as a separate owned object to the user
   - TodoList stores only task addresses (vector<address>) as references
   - When creating tasks: store address in TodoList, then transfer task object to user
   - This allows users to directly modify their task objects with `&mut Task` references

6. **Vector Operations Solution:**
   - Use `vector::borrow(&vec, index)` for read-only access (returns `&T`)
   - Use `vector::borrow_mut(&mut vec, index)` for modifications (returns `&mut T`)
   - Use `vector::remove(&mut vec, index)` to take ownership and remove (returns `T`)
   - For delete_task: use `vector::remove` to get owned Task, then destructure to delete UID
---------------------------------------
## 📚 Learnings
### **What new concepts did you learn?**

- **Transaction Context (TxContext):** Learned how to use `TxContext` to access sender information and create new objects with `object::new(ctx)`

- **Object Abilities:** Understood the importance of abilities (`key`, `store`, `copy`, `drop`) and how they affect what operations are allowed on structs. Specifically learned that UID doesn't have `drop`, preventing direct comparisons

- **Object Lifecycle:** Learned proper patterns for creating, transferring, and deleting objects in Sui, including how to properly destructure objects to delete their UIDs

- **Reference vs Ownership:** Gained deep understanding of the difference between borrowed references (`&T`, `&mut T`) and owned values (`T`), and when to use each

- **Vector Operations:** Mastered the difference between:
  - `vector::borrow()` - immutable read-only access
  - `vector::borrow_mut()` - mutable in-place modification
  - `vector::remove()` - taking ownership and removing from vector

- **Architecture Patterns:** Learned two different approaches for structuring objects:
  - Storing objects directly in vectors (embedded pattern)
  - Storing only addresses and transferring objects separately (referenced pattern)
### **What part of Sui / Move became clearer after this task?**

- **Module System:** Understanding how to properly import and use functions from different modules (`sui::transfer`, `sui::object`, `sui::tx_context`)

- **Error Handling:** Learned how to define error constants and use `assert!` and `abort` for validation

- **Entry Functions:** Understood that entry functions are the public interface users call, and how they interact with owned objects vs shared objects

- **Object Model:** Clarified how Sui's object model works - each object has a unique UID, can be owned or shared, and ownership transfer is explicit through `transfer::transfer()`

- **Move Semantics:** Better understanding of Move's ownership model where values are moved by default, and how this prevents double-spending and ensures safety
---------------------------------------
## ✅ Declaration
I confirm that:
- This submission is my original work
- The code and demo were built and executed by me
- I followed the program rules and guidelines  
**Signature / Name:** Trần Quốc Dũng  
**Date:** 31/12/2025
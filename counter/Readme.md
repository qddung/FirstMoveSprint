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
+ Project Name: Counter
+ Short Description (1–2 sentences): a package allow user increase and decrease a counter number on chain
---------------------------------------
## 💻 Source Code
+ Github Repository: https://github.com/qddung/FirstMoveSprint/tree/main/counter
---------------------------------------
## 🎥 Demo Video
+ Link: https://www.youtube.com/watch?v=HujeZjbklp8
---------------------------------------
⛓️ On-chain Transaction
+ Network: Sui Testnet
+ PackageID: 0x1f531d64064f3f75d4f517d7c2180bf660814739c33709ec39308cf9944cdb17
+ Transaction Hash: CCJ7zizvonBdr5M3MocbPZcoMKcSjpbqzHV5FbwYBjjd
---------------------------------------
## 🧠 Technical Details
- **What did you build ?**
  - A decentralized counter application on Sui blockchain that allows anyone to increment or decrement a shared counter value
  - The counter is implemented as a shared object, meaning multiple users can interact with it concurrently
  - Features two main operations: `increment()` to add 1 and `decrement()` to subtract 1 from the counter value
  - The counter is automatically created and shared when the module is published via the `init` function

- **Key Move Concepts Used**
  1. **Module Definition** - Organized code using `module counter::counter`
  2. **Struct with Abilities** - `Counter has key, store` enables the object to be owned and stored
  3. **UID (Unique Identifier)** - Every Sui object requires a unique ID for identity and storage
  4. **Entry Functions** - `public entry fun` allows functions to be called directly from transactions
  5. **Mutable References** - `&mut Counter` enables in-place modification of the shared object
  6. **Init Function** - Special function that runs once during module publication to initialize state
  7. **Shared Objects** - `transfer::public_share_object()` makes the counter accessible to all users
  8. **Transaction Context** - `TxContext` provides transaction metadata for generating unique IDs

---------------------------------------
🧩 Challenges & Solutions
### **Challenges Faced:**
1. Understanding the difference between owned objects and shared objects
2. Learning when to use `&mut` (mutable reference) vs `&` (immutable reference)
3. Figuring out why entry functions need the `entry` keyword to be callable from transactions
4. Understanding the purpose of UID and why it must be the first field in a struct

### **How You Solved Them:**
1. Read Sui documentation on object ownership models and experimented with `transfer::public_share_object()` vs `transfer::transfer()`
2. Studied Move's borrow semantics - used `&mut` for increment/decrement since they modify the counter's value
3. Learned that `entry` keyword marks functions as transaction entry points, making them callable from clients
4. Understood that UID provides global uniqueness and enables Sui's object-centric storage model

---------------------------------------
## 📚 Learnings
### **What new concepts did you learn?**
- **Object Abilities (key, store)**: How abilities control what operations can be performed on objects
- **Shared vs Owned Objects**: Shared objects enable concurrent access while owned objects have a single owner
- **Entry Functions**: The distinction between `public entry fun` (callable from transactions) and `public fun` (internal only)
- **Init Function Pattern**: How `init()` executes automatically once when a module is published
- **Object Lifecycle**: How objects are created with `object::new()`, shared with `transfer::public_share_object()`, and can be deleted with `object::delete()`

### **What part of Sui / Move became clearer after this task?**
- **Sui's Object Model**: Unlike account-based blockchains, Sui uses an object-centric model where everything is an object with a unique ID
- **Shared Object Consensus**: Shared objects require consensus for modifications, which is why the counter can be safely incremented/decremented by multiple users
- **Move's Safety Guarantees**: The type system and borrow checker prevent common errors like double-spending or unauthorized access
- **Transaction Structure**: How transactions reference objects by ID and call entry functions with proper parameter types
- **Gas Efficiency**: Shared objects are more expensive than owned objects due to consensus requirements, but necessary for multi-user applications

---------------------------------------
## ✅ Declaration
I confirm that:
- This submission is my original work
- The code and demo were built and executed by me
- I followed the program rules and guidelines  
**Signature / Name:** Trần Quốc Dũng  
**Date:** 31/12/2025
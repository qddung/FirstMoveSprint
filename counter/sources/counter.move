/*
/// Module: counter
module counter::counter;
*/

// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions

module counter::counter;

use sui::object;
use sui::transfer;
use sui::tx_context::{Self, TxContext};

public struct Counter has key, store {
    id: UID, // store in global storage
    value: u64,
}

public entry fun increment(counter: &mut Counter) {
    counter.value = counter.value + 1;
}

public entry fun decrement(counter: &mut Counter) {
    counter.value = counter.value - 1;
}

fun init(ctx: &mut TxContext) {
    let counter = Counter { id: object::new(ctx), value: 0 };
    // share object
    transfer::public_share_object(counter);
}

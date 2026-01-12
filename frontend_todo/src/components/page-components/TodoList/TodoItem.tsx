import React from 'react';

import type { TodoItem } from './types';
function TodoItem(props: TodoItem) {

    return <div>{props.title}</div>;
}

export default TodoItem;


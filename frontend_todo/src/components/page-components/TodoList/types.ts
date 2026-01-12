export interface TodoItem {
    id: string;
    title: string;
    completed: boolean;
}


export interface TodoListProps {
    items: TodoItem[];
}


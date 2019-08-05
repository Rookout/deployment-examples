<template>
    <div class="container">
        <div>
            <input
                    class="todo-input"
                    type="text"
                    v-model="todoItemName"
                    placeholder="What are you doing today?"
                    @keyup.enter.prevent="addTodo"
            >
        </div>
        <div class="todos">
            <ul>
                <li
                        class="todo-item"
                        v-for="todo in todos"
                        :key="todo.id"
                        @click="completeTodo(todo)"
                ></li>
            </ul>
        </div>

        <button class="clear-all" @click="clearTodos" v-if="todos.length > 0">CLEAR ALL</button>
    </div>
</template>

<script>
    import { mapState } from "vuex";

    export default {
        data() {
            return {
                todoItemName: ""
            };
        },
        methods: {
            addTodo() {
                this.$store.dispatch("ADD_TODO", this.todoItemName);

                this.todoItemName = "";
            },
            clearTodos() {
                this.$store.dispatch("CLEAR_TODOS");
            },
            completeTodo(selectedTodo) {
                this.$store.dispatch("COMPLETE_TODO", selectedTodo.id);
            }
        },
        computed: {
            ...mapState({
                todos: state => state.Todo.todos
            })
        }
    };
</script>

<style>
    .container {
        height: 100vh;
        text-align: center;
        background-color: #30336b;
    }

    .todos {
        overflow: scroll;
        height: 70vh;
        margin-top: 20px;
    }

    .todo-input {
        font-size: 36px;
        width: 90vw;
        border: 0px;
        outline: none;
        padding-top: 20px;
        text-align: center;
        background-color: transparent;
        color: white;
    }

    .todo-item {
        font-size: 24px;
        padding: 10px 0px;
        color: white;
    }

    .clear-all {
        border: 1px solid white;
        background: transparent;
        color: white;
        margin-top: 20px;
        padding: 20px;
        font-size: 18px;
    }

    ::placeholder {
        color: white;
    }
</style>

import uuid from 'uuid/v4';

const state = {
    todos: []
};

const actions = {
    ADD_TODO ({ commit }, name) {
        commit('ADD_TODO', name);
    },
    COMPLETE_TODO ({ commit }, id) {
        commit('COMPLETE_TODO', id);
    },
    CLEAR_TODOS ({ commit }) {
        commit('CLEAR_TODOS');
    }
};

const mutations = {
    ADD_TODO (state, name) {
        state.todos = [ ...state.todos, { id: uuid(), name } ];
    },
    COMPLETE_TODO (state, id) {
        state.todos = state.todos.filter((todo) => todo.id != id);
    },
    CLEAR_TODOS (state) {
        state.todos = [];
    }
};

export default {
    state,
    actions,
    mutations
};

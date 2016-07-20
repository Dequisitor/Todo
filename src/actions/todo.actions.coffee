addTodo = (id) ->
	{
		type: 'ADD_TODO',
		payload: id
	}
toggleTodo = (id) ->
	{
		type: 'TOGGLE_TODO',
		payload: id
	}
deleteTodo = (id) ->
	{
		type: 'DELETE_TODO',
		payload: id
	}
toggleOpen = (id) ->
	{
		type: 'OPEN_TODO',
		payload: id
	}
setEditing = (id, state, title) ->
	{
		type: 'SET_EDIT',
		payload: {
			id: id,
			state: state,
			title: title
		}
	}

module.exports = {
	addTodo: addTodo,
	toggleTodo: toggleTodo,
	deleteTodo: deleteTodo,
	toggleOpen: toggleOpen,
	setEditing: setEditing
}

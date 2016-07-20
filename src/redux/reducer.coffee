todos = [{
	id: 1,
	title: 'sod off',
	done: false
},
{
	id: 2,
	title: 'rape tree bark',
	done: true,
	todos: [{
		id: 3,
		title: 'find attractive tree',
		done: true
	},
	{
		id: 4,
		title: 'analyse bark',
		done: false,
		todos: [{
			id: 5,
			title: 'check for genitalia',
			done: false
		},
		{
			id: 6,
			title: 'make sure it\'s a girl',
			done: false
		}]
	},
	{
		id: 7,
		title: 'try your best',
		done: false
	}]
},
{
	id: 8,
	title: 'get tired and go to bed way too late',
	done: true
},
{
	id: 9,
	title: 'whine',
	done: false,
	todos: [{
		id: 10,
		title: 'express how everyone is against you',
		done: false
	},
	{
		id: 11,
		title: 'tell everyone you are the victim',
		done: true,
		todos:[{
			id: 12,
			title: 'change context',
			done: false,
			value: 14
		},
		{
			id: 13,
			title: 'this is not really creative',
			done: true,
			value: 59
		}]
	}]
}]

hasChild = (parent, id) ->
	for item, i in parent
		if id == item.id
			return i

	return null

findTodo = (state, id) ->
	if state.id?
		if state.id == id
			res = state
		else
			res = null
	if state.todos?
		for item in state.todos
			res = findTodo(item, id) || res

	return res

findParent = (state, id) ->
	if not state.todos.length?
		return [null, null]
	else
		if (index = hasChild(state.todos, id))?
			res = [state, index]
		else
			for item in state.todos when item.todos?
				res = findParent(item, id) || res

	return res

deleteTodo = (state, id) ->
	tmp = Object.assign {}, state
	[parent, index] = findParent tmp, id
	if parent?
		parent.todos.splice index, 1

	return tmp

toggleOpen = (state, id) ->
	tmp = Object.assign {}, state
	todo = findTodo tmp, id
	if todo?
		todo.open = !todo.open

	return tmp

setEditing = (state, params) ->
	tmp = Object.assign {}, state
	todo = findTodo tmp, params.id
	if todo?
		todo.editing = params.state
		if params.title?
			todo.title = params.title

	return tmp

addTodo = (state, id) ->
	tmp = Object.assign {}, state
	todo = findTodo tmp, id
	if todo?
		todo.open = true
		todo.todos = [{
			title: 'ToDo',
			editing: true
		}]

	return tmp

reducer = (state = {todos: todos}, action) ->
	switch action.type
		when 'ADD_TODO'
			result = addTodo state, action.payload
		when 'DELETE_TODO'
			result = deleteTodo state, action.payload
		when 'OPEN_TODO'
			result = toggleOpen state, action.payload
		when 'SET_EDIT'
			result = setEditing state, action.payload

	Object.assign {}, state, result

module.exports = reducer

mockValues = require '../mockValues.json'

idBase = 0
redoIds = (todos) ->
	for todo in todos
		todo.id = idBase
		idBase++
		if todo.todos?
			redoIds todo.todos

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

	idBase = 0
	redoIds tmp.todos
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
		if not todo.todos?
			todo.todos = []
		todo.todos.push({
			title: 'ToDo',
			editing: true,
			id: idBase++
		})

	return tmp

toggleChildren = (todo, done) ->
	todo.done = if done? then done else !todo.done
	if todo.todos?
		for child in todo.todos
			toggleChildren child, todo.done

toggleTodo = (state, id) ->
	tmp = Object.assign {}, state
	todo = findTodo tmp, id
	if todo?
		toggleChildren todo
	
	return tmp

redoIds mockValues
reducer = (state = {todos: mockValues}, action) ->
	console.log 'action: ' + action.type + ' with payload: ' + action.payload
	switch action.type
		when 'ADD_TODO'
			result = addTodo state, action.payload
		when 'DELETE_TODO'
			result = deleteTodo state, action.payload
		when 'OPEN_TODO'
			result = toggleOpen state, action.payload
		when 'SET_EDIT'
			result = setEditing state, action.payload
		when 'TOGGLE_TODO'
			reuslt = toggleTodo state, action.payload

	Object.assign {}, state, result

module.exports = reducer

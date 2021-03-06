React = require 'react'
connect = require('react-redux').connect

Checkbox = require './checkbox.component'
actions = require '../actions/todo.actions'

ToDo = React.createClass
	#events
	addTodo: ->
		this.props.addTodo this.props.todo.id
	startEditing: (event) ->
		this.props.setEditing this.props.todo.id, true
	stopEditing: (event) ->
		this.props.setEditing this.props.todo.id, false, this.state.title
	deleteTodo: (event) ->
		this.props.deleteTodo this.props.todo.id
	toggleOpen: (event) ->
		this.props.toggleOpen this.props.todo.id
	toggleTodo: (event) ->
		this.props.toggleTodo this.props.todo.id
	handleKeyPress: (event) ->
		console.log event.key
		if event.key == 'Enter' then this.stopEditing()

	#component functions
	getInitialState: ->
		{ title: this.props.todo.title }
	componentWillReceiveProps: ->
		this.setState { title: this.props.todo.title }
	handleTitleChange: (event) ->
		this.setState { title: event.target.value }
	getOpenClasses: ->
		if this.props.todo.open then 'fa fa-chevron-right fa-rotate-90' else 'fa fa-chevron-right'
	render: ->
		<div className="todo">
			<div className='head'>
				<div className="left">
					<span className='type' onClick={this.toggleOpen}>
						{
							if this.props.todo.todos?
								<span className={this.getOpenClasses()}></span>
							else
								<span className="dot"></span>
						}
					</span>
					{
						if this.props.todo.editing
							<input className="title" autoFocus value={this.state.title} onChange={this.handleTitleChange} onBlur={this.stopEditing} onKeyPress={this.handleKeyPress}/>
						else
							<span className="title">{this.props.todo.title}</span>
					}
					{
						if this.props.todo.value?
							<span className="custom-data">{this.props.todo.value} £</span>
					}
				</div>
				<span className="controls">
					<span className="fa fa-pencil" onClick={this.startEditing}></span>
					<span className="fa fa-plus" onClick={this.addTodo}></span>
					<span className="fa fa-trash" onClick={this.deleteTodo}></span>
				</span>
				<Checkbox checked={this.props.todo.done} handleClick={this.toggleTodo} className="warning" />
			</div>
			<div className={if this.props.todo.open then 'body open' else 'body'}>
				{
					if (this.props.todo.todos?)
						this.props.todo.todos.map (todo, i) =>
							<ToDoContainer todo={todo} key={i} />
				}
			</div>
		</div>

mapStateToProps = (state, ownProps) ->
	return {
		storeState: state,
		todo: ownProps.todo
	}
mapDispatchToProps = (dispatch, ownProps) ->
	return {
		addTodo: (id) ->
			dispatch(actions.addTodo(id))
		deleteTodo: (id) ->
			dispatch(actions.deleteTodo(id))
		toggleTodo: (id) ->
			dispatch(actions.toggleTodo(id))
		toggleOpen: (id) ->
			dispatch(actions.toggleOpen(id))
		setEditing: (id, state, title) ->
			dispatch(actions.setEditing(id, state, title))
	}

ToDoContainer = connect(mapStateToProps, mapDispatchToProps)(ToDo)
module.exports = ToDoContainer

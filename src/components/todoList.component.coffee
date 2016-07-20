React = require 'react'
ToDoContainer = require './todo.component'
connect = require('react-redux').connect

ToDoList = React.createClass
	render: ->
		<div className="todo-container">
			{
				this.props.state.todos.map (todo, i) =>
					<ToDoContainer todo={todo} key={i}/>
			}
		</div>

mapStateToProps = (state, ownProps) ->
	{
		state: state
	}

ToDoListContainer = connect(mapStateToProps)(ToDoList)
module.exports = ToDoListContainer

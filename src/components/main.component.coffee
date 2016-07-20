React = require 'react'

ToDoListContainer = require('./todoList.component')

Main = React.createClass {
	render: ->
		<div className="main">
			<h2>Todo list</h2>
			<div className="button warning" onClick={this.handleAdd}>Add ToDo</div>
			<ToDoListContainer />
		</div>
}

module.exports = Main

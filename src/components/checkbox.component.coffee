React = require 'react'

checkbox = React.createClass
	getInitialState: ->
		{ checked: this.props.check || false }
	handleClick: ->
		this.setState { checked: !this.state.checked }
		return
	isChecked: ->
		classes = this.props.className + ' checkbox'
		if this.state.checked then classes+' checked fa fa-check' else classes
	render: ->
		<checkbox className={this.isChecked()} onClick={this.handleClick} />

module.exports = checkbox

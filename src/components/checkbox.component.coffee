React = require 'react'

checkbox = React.createClass
	isChecked: ->
		classes = this.props.className + ' checkbox'
		if this.props.checked then classes+' checked fa fa-check' else classes
	render: ->
		<checkbox className={this.isChecked()} onClick={this.props.handleClick} />

module.exports = checkbox

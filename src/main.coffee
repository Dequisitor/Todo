React = require 'react'
Redux = require 'redux'
Provider = require('react-redux').Provider
reactDom = require 'react-dom'

Reducer = require './redux/reducer'
Main = require './components/main.component'

store = Redux.createStore Reducer
reactDom.render <Provider store={store}><Main state={store.getState()}/></Provider>, document.getElementById 'main'

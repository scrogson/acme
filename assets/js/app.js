import "phoenix_html"
import socket from "./socket"
import React, {Component} from "react"
import {render} from "react-dom"
import Issue from "./Issue"

let el = document.getElementById("issue")

if (window.userToken) {
  socket.connect()
}

if (el) {
  render(<Issue socket={socket} issueId={el.dataset.issueId} />, el)
}

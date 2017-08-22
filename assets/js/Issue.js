import {Presence} from "phoenix"
import React, {Component} from "react"
import {render} from "react-dom"
import CommentList from "./CommentList"

export default class Issue extends Component {
  constructor() {
    super()
    this.state = {users: [], presenceState: {}}
  }

  componentWillMount() {
    let {issueId, socket} = this.props
    let channel = socket.channel(`issues:${issueId}`, {})

    channel.on("presence_state", state => {
      let newPresence = Presence.syncState(this.state.presenceState, state)
      this.setState({users: Presence.list(newPresence, this.listBy), presenceState: newPresence})
    })

    channel.on("presence_diff", diff => {
      let newPresence = Presence.syncDiff(this.state.presenceState, diff)
      this.setState({users: Presence.list(newPresence, this.listBy), presenceState: newPresence})
    })

    this.setState({...this.state, channel: channel})
  }

  componentDidMount() {
    this.state.channel.join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) })
  }

  listBy(id, {metas: metas}) {
    let name = metas[0].name
    let avatarUrl = metas[0].avatarUrl

    return {
      id,
      name,
      avatarUrl,
      count: metas.length
    }
  }

  renderUser(user) {
    return(
      <img className="img-circle" src={user.avatarUrl} width="32" height="32" style={{margin: "5px"}}/>
    )
  }

  render() {
    let {channel, users} = this.state

    return (
      <div>
        <strong>{users.length} active {users.length > 1 ? "users" : "user"}</strong>:

        {users.map(this.renderUser)}
        <CommentList channel={channel} />
      </div>
    )
  }
}

import React, {Component} from "react"
import Comment from "./Comment"

export default class CommentList extends Component {
  constructor() {
    super()
    this.state = {userData: {}, comments: []}
  }

  componentWillMount() {
    let {channel} = this.props

    channel.on("current_user_data", userData => this.setUserData(userData))
    channel.on("new_comment", comment => this.pushComments([comment]))
    channel.on("comment_history", ({comments}) => this.pushComments(comments))
  }

  setUserData(userData) {
    this.setState({...this.state, userData})
  }

  pushComments(comments) {
    this.setState({comments: this.state.comments.concat(comments)})
    let list = document.getElementById("comment-list")
    list.scrollTop = list.scrollHeight
  }

  handleSubmit({key, target}) {
    if (key !== "Enter") { return }

    let {channel} = this.props
    let onSuccess = (msg) => {
      target.disabled = false
      target.value = ""
    }
    let onError = () => {
      target.disabled = false
    }

    target.disabled = true

    channel.push("new_comment", {body: target.value})
      .receive("ok", onSuccess)
      .receive("error", onError)
      .receive("timeout", onError)
  }

  render() {
    const comments = (
      <ul className="media-list">
        {this.state.comments.map(comment => <Comment key={comment.id} comment={comment} />)}
      </ul>
    )

    return(
      <div id="comment-list">
        {comments}
        <hr/>
        <div className="media">
          <div className="media-left">
            <a href="#">
              <img className="img-rounded media-object" src={this.state.userData.avatarUrl} width="64" height="64" />
            </a>
          </div>
          <div className="media-body">
            <div className="panel panel-default">
              <div className="panel-heading">
                <strong>{this.state.userData.name}</strong>
              </div>
              <div className="panel-body">
                <textarea
                  value={this.state.body}
                  onKeyPress={(e) => this.handleSubmit(e)}
                  id="btn-input"
                  type="text"
                  className="form-control"
                  placeholder="Leave a comment"
                ></textarea>
              </div>
            </div>
          </div>
        </div>
      </div>
    )
  }
}

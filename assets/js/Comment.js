import React, {Component} from "react"

const Comment = ({comment}) => {
  const {id, from, avatarUrl, body} = comment

  return(
    <li key={id} className="media">
      <div className="media-left">
        <a href="#">
          <img className="img-rounded media-object" src={avatarUrl} width="64" height="64" />
        </a>
      </div>
      <div className="media-body">
        <div className="panel panel-default">
          <div className="panel-heading">
            <strong>{from}</strong>
          </div>
          <div className="panel-body">{body}</div>
        </div>
      </div>
    </li>
  )
}

export default Comment

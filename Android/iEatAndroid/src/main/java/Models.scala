package com.thoughtworks.ieat.model

case class User(val name: String, val email: String)
case class Group(val name: String, owner: User)
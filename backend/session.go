package main

import (
	"fmt"
	"errors"
	"net/http"
)

var authError = errors.New("Unauthorized")

func Authorize(r *http.Request) error {
	
	username := r.FormValue("username")
	user, ok := users[username]

	if !ok {
		fmt.Println("not ok")
		return authError
	}

	st, err := r.Cookie("session_token")
	if err != nil || st.Value == "" || st.Value != user.SessionToken{
		fmt.Println("error or invalid session token")
		fmt.Println("err : %s", err)
		fmt.Println("st value : %s", st.Value)
		fmt.Println("session token stored : %s", user.SessionToken)
		return authError
	}

	csrf := r.Header.Get("X-CSRF-Token")

	if csrf == "" || csrf != user.CSRFToken {
		fmt.Println("csrf token : %s", csrf)
		fmt.Println("user csrf token : %s", user.CSRFToken)

		return authError
	}

	return nil
}
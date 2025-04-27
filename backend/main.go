package main

import (
	"fmt"
	"net/http"
	"time"
	"encoding/json"
)

type Login struct {
	HashedPassword string
	SessionToken string
	CSRFToken string
}

type RegisterLoginRequest struct {
	Username string `json:"username"`
	Password string `json:"password"`
}

var users = map[string]Login{};

func register(w http.ResponseWriter, r *http.Request){
	
	if r.Method != http.MethodPost{
		er := http.StatusMethodNotAllowed    
		http.Error(w, "invalid method", er)
		fmt.Println("invalid method")
		return
	}
	
	var registerData RegisterLoginRequest

	err := json.NewDecoder(r.Body).Decode(&registerData)
	if err != nil {
		http.Error(w,"invalid request payload" , http.StatusBadRequest)
		fmt.Println("invalid request payload")
		fmt.Println(registerData.Username)
		return
	}

	username := registerData.Username
	password := registerData.Password

	if len(username) < 8 || len(password) < 8 {
		er := http.StatusNotAcceptable
		http.Error(w, "invalid username/password", er)
		fmt.Println("invalid username/password")
		fmt.Println(len(username))
		fmt.Println(len(password))

		return
	}

	if _, ok := users[username]; ok {
		er := http.StatusConflict
		http.Error(w, "User already exists", er)
		fmt.Println("user already exists")

		return
	}

	HashedPassword , _ := hashPassword(password)
	users[username] = Login{
		HashedPassword: HashedPassword,
	}

	fmt.Fprintln(w, "User successfully registered")
	fmt.Println("User successfully registered")

}

func verify_post_request_login_register(w http.ResponseWriter, r *http.Request) (RegisterLoginRequest, error) {
	if r.Method != http.MethodPost{
		er := http.StatusMethodNotAllowed    
		http.Error(w, "invalid method", er)
		fmt.Println("invalid method")
		return RegisterLoginRequest{}, fmt.Errorf("invalid method")
	}
	
	var registerData RegisterLoginRequest

	err := json.NewDecoder(r.Body).Decode(&registerData)
	if err != nil {
		http.Error(w,"invalid request payload" , http.StatusBadRequest)
		fmt.Println("invalid request payload")
		return registerData, fmt.Errorf("invalid request payload")
	}
	
	return registerData, nil
}

func login(w http.ResponseWriter, r *http.Request){
	
	if r.Method != http.MethodPost{
		er := http.StatusMethodNotAllowed    
		http.Error(w, "invalid method", er)
		fmt.Println("invalid method")
		return
	}

	var registerData RegisterLoginRequest

	err := json.NewDecoder(r.Body).Decode(&registerData)
	if err != nil {
		http.Error(w,"invalid request payload" , http.StatusBadRequest)
		fmt.Println("invalid request payload")
		return
	}

	username := registerData.Username
	password := registerData.Password


	user, ok := users[username]
	if !ok || !checkPasswordHash(password, user.HashedPassword){
		er := http.StatusUnauthorized
		http.Error(w, "invalid username or password", er)
		fmt.Println("invalid username/password")

		return
	}

	sessionToken := generateToken(32)
	csrfToken := generateToken(32)

	http.SetCookie(w, &http.Cookie{
		Name: "session_token",
		Value: sessionToken,
		Expires: time.Now().Add(24 * time.Hour),
		HttpOnly: true,
	})

	http.SetCookie(w, &http.Cookie{
		Name: "csrf_token",
		Value: csrfToken,
		Expires: time.Now().Add(24 * time.Hour),
		HttpOnly: false,
	})

	user.SessionToken = sessionToken
	user.CSRFToken = csrfToken
	users[username] = user


	fmt.Fprintln(w, "Login Successful")
	fmt.Println("Login successful")

}
func protected(w http.ResponseWriter, r *http.Request){
	if r.Method != http.MethodPost {
		er := http.StatusMethodNotAllowed
		http.Error(w, "invalid request method", er)
		return
	}

	if err := Authorize(r); err != nil {
		er := http.StatusUnauthorized
		http.Error(w, "Unauthorized", er)
		return
	}

	username := r.FormValue("username")
	fmt.Fprintln(w, "CSRF validation successful! Welcome %s", username)
}


func logout(w http.ResponseWriter, r *http.Request){
	if err := Authorize(r); err != nil {
		er := http.StatusUnauthorized
		http.Error(w, "Unauthorized", er)
		return
	}

	http.SetCookie(w, &http.Cookie{
		Name: "session_token",
		Value: "",
		Expires: time.Now().Add(-time.Hour),
		HttpOnly: true,
	})


	http.SetCookie(w, &http.Cookie{
		Name: "csrf_token",
		Value: "",
		Expires: time.Now().Add(-time.Hour),
		HttpOnly: false,
	})

	username := r.FormValue("username")
	user, _ := users[username]
	user.SessionToken = ""
	user.CSRFToken = ""

	users[username] = user

	fmt.Fprintln(w, "Logged out successfully")
}


func main() {
	http.HandleFunc("/register", register)
	http.HandleFunc("/login", login)
	http.HandleFunc("/logout", logout)
	http.HandleFunc("/protected", protected)

	http.ListenAndServe(":8080", nil)
}



extends Node
var website: String = "https://api.gamejolt.com/api/game/" #place to send everything
var version: String = "v1_2/" #version of the API
var game_id: int = 500495
var private_key: String = "e5b3ee96586aefa32c77934ff288e59f"
var final_string: String #a string that is used in all functions but you don't really need to worry about it too much
var output: String #output in string format for printing and stuff
var emptyS: String = ""
var emptyI: int = 0
var input: String
var gamejolt_result: Dictionary
signal done(gamejolt_result)



#functions
func _add_user_id(user_id):
	final_string += "&user_id=" + str(user_id)
func api_user_fetch(username: String = emptyS, user_id: String = emptyS):
	_start_request("users/")
	if username != emptyS:
		_add_username(username)
	if user_id != emptyS:
		_add_user_id(user_id)
	return _finish_request()
func api_user_auth(username: String, user_token: String):
	_start_request("users/auth/")
	_add_username(username)
	_add_user_token(user_token)
	return _finish_request()

func api_session_open(username: String, user_token: String):
	_start_request("sessions/open/")
	_add_username(username)
	_add_user_token(user_token)
	return _finish_request()
func api_session_close(username: String, user_token: String):
	_start_request("sessions/close/")
	_add_username(username)
	_add_user_token(user_token)
	return _finish_request()
func api_session_ping(username: String, user_token: String, status: String = emptyS):
	_start_request("sessions/ping/")
	_add_username(username)
	_add_user_token(user_token)
	if status == "active" || status == "idle":
		final_string += "&status=" + str(status)
	return _finish_request()
func api_session_check(username: String, user_token: String):
	_start_request("sessions/check/")
	_add_username(username)
	_add_user_token(user_token)
	return _finish_request()

func api_score_add(score: String, sort: int, username: String = emptyS, user_token: String = emptyS, guest: String = emptyS, extra_data: String = emptyS, table_id: int = emptyI):
	_start_request("scores/add/")
	if username != emptyS && user_token != emptyS:
		_add_username(username)
		_add_user_token(user_token)
	else:
		_add_guest(guest)
	final_string += "&score=" + str(score)
	_add_sort(sort)
	if extra_data != emptyS:
		final_string += "&extra_data=" + str(extra_data)
	if table_id != emptyI:
		_add_table_id(table_id)
	return _finish_request()
func api_score_table():
	_start_request("scores/tables/")
	return _finish_request()
func api_score_get_rank(sort: int, table_id: int = emptyI):
	_start_request("scores/get-rank/")
	_add_sort(sort)
	if table_id != emptyI:
		_add_table_id(table_id)
	return _finish_request()
func api_score_fetch(limit: int = emptyI, username: String = emptyS, user_token: String = emptyS, guest: String = emptyS, table_id: int = emptyI, better_than: int = emptyI, worse_than: int = emptyI):
	_start_request("scores/")
	if limit != emptyI:
		final_string += "&limit=" + str(limit)
	if table_id != emptyI:
		_add_table_id(table_id)
	if username != emptyS && user_token != emptyS:
		_add_username(username)
		_add_user_token(user_token)
	else:
		_add_guest(guest)
	if better_than != emptyI:
		final_string += "&better_than=" + str(better_than)
	if worse_than != emptyI:
		final_string += "&worse_than=" + str(worse_than)
	return _finish_request()

func api_data_remove(key: String, username: String = emptyS, user_token: String = emptyS):
	_start_request("data-store/remove/")
	_add_key(key)
	if username != emptyS && user_token != emptyS:
		_add_username(username)
		_add_user_token(user_token)
	return _finish_request()
func api_data_fetch(key: String, username: String = emptyS, user_token: String = emptyS):
	_start_request("data-store/")
	_add_key(key)
	if username != emptyS && user_token != emptyS:
		_add_username(username)
		_add_user_token(user_token)
	return _finish_request()
func api_data_set(key: String, data: String, username: String = emptyS, user_token: String = emptyS):
	_start_request("data-store/set/")
	_add_key(key)
	_add_data(data)
	if username != emptyS && user_token != emptyS:
		_add_username(username)
		_add_user_token(user_token)
	return _finish_request()
func api_data_update(key: String, operation: String, value: String, username: String = emptyS, user_token: String = emptyS):
	_start_request("data-store/update/")
	_add_key(key)
	final_string += "&operation=" + str(operation)
	final_string += "&value=" + str(value)
	if username != emptyS && user_token != emptyS:
		_add_username(username)
		_add_user_token(user_token)
	return _finish_request()
func api_data_get_keys(pattern: String = emptyS, username: String = emptyS, user_token: String = emptyS):
	_start_request("data-store/get-keys/")
	if pattern != emptyS:
		final_string += "&pattern=" + str(pattern) + "|*"
	if username != emptyS && user_token != emptyS:
		_add_username(username)
		_add_user_token(user_token)
	return _finish_request()

func api_trophy_fetch(username: String, user_token: String, achieved: String = emptyS, trophy_id: int = emptyI):
	_start_request("trophies/")
	_add_username(username)
	_add_user_token(user_token)
	if achieved == "true" || achieved == "false":
		final_string += "&achieved=" + str(achieved)
	if trophy_id != emptyI:
		_add_trophy_id(trophy_id)
	return _finish_request()
func api_trophy_add_achieved(username: String, user_token: String, trophy_id: int):
	_start_request("trophies/add-achieved/")
	_add_username(username)
	_add_user_token(user_token)
	_add_trophy_id(trophy_id)
	return _finish_request()
func api_trophy_remove_achieved(username: String, user_token: String, trophy_id: int):
	_start_request("trophies/remove-achieved/")
	_add_username(username)
	_add_user_token(user_token)
	_add_trophy_id(trophy_id)
	return _finish_request()

func api_time():
	_start_request("time/")
	return _finish_request()

func api_friends(username: String, user_token: String):
	_start_request("friends/")
	_add_username(username)
	_add_user_token(user_token)
	return _finish_request()

#functions to add various parts to the string
func _add_username(username):
	final_string += "&username=" + username
func _add_user_token(user_token):
	final_string += "&user_token=" + user_token
func _add_trophy_id(trophy_id):
	final_string += "&trophy_id=" + str(trophy_id)
func _add_key(key):
	final_string += "&key=" + str(key)
func _add_data(data):
	final_string += "&data=" + str(data)
func _add_guest(guest):
	final_string += "&guest=" + str(guest)
func _add_sort(sort):
	final_string += "&sort=" + str(sort)
func _add_table_id(table_id):
	final_string += "&table_id=" + str(table_id)

func _ready():
	var new_request = HTTPRequest.new() #makes a HTTP node
	new_request.name = "HTTPRequest" #names the node
	add_child(new_request) #adds the node to the node of the script which if it's on autoload then the script would be a sibling of the current scene
	new_request.connect("request_completed", self, "_request_completed") #connects the node's request completed with the function in this script
	

#the start and end of all the requests
func _start_request(namespace : String):
	final_string = website #gamejolt api
	final_string += version #version of api
	final_string += namespace #function of api
	final_string += "?game_id=" + str(game_id) #game id is used in all calls
func _finish_request():
	var md5: String = (final_string + private_key).md5_text() #md5 encoding of command with key to be used as key
	final_string += "&signature=" + md5 #insert md5 encoded string 
	input = final_string
	var err = get_node("HTTPRequest").request(final_string) #sends the string to the gamejolt gods themselves

#takes the result and puts it into the variable result, use printf to help understadn how everything is formatted cuz it's really weird (at least to me)
func _request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8()) #makes a json with the string, idk how this works very much
	result = json.result
	gamejolt_result = result
	emit_signal("done", result)
	return gamejolt_result

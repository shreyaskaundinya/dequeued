from hashlib import sha256

import mysql.connector
from flask import Blueprint, Flask, Response, request
from utils.error_codes import HTTP_BADREQ, HTTP_SERVERERR, HTTP_SUCCESS
from utils.get_db import get_db
from utils.get_json import get_json
from utils.make_error import make_error
from utils.make_response import make_response

api_blueprint = Blueprint('user_api', __name__)

# custom
@api_blueprint.route("/custom", methods=["POST"])
def custom():
    db = get_db()
    c = db.cursor()

    try:
        query = get_json(request.data)["query"]

        if (query.find("drop") != -1) or (query.find("delete") != -1):
            return make_error(message="NICE TRY! HAHHHAAHHAH", status=HTTP_BADREQ)

        c.execute(query)
        headers = [i[0] for i in c.description]
        data = c.fetchall()
        return make_response(data={"results": data, "headers": headers}, status=HTTP_SUCCESS)
    except mysql.connector.Error as err:
        return make_error(message=err.msg, status=HTTP_BADREQ)
    except Exception as err:
        return make_error(message=err.msg, status=HTTP_BADREQ)


# USER ----------------------------------------------------------------
@api_blueprint.route("/user/login", methods=["POST"])
def login():
    # data = {username, password}
    data = get_json(request.data)
    db = get_db()
    c = db.cursor()

    hashed_password = sha256(data.get('password').encode('utf-8')).hexdigest()

    c.execute(
        "select * from user where (username=%s and password=%s);",
        (data.get("username"), hashed_password)
    )
    user = c.fetchone()

    if user != None:    
        # print(user)
        c.close()
        return make_response({
            "id": user[0],
            "name": user[1],
            "username": user[2],
            "password": user[3],
            "created_at": user[4],
        }, HTTP_SUCCESS)
        
    else:
        c.close()
        return make_error("User not found", HTTP_BADREQ)

@api_blueprint.route("/user/signup", methods=["POST"])
def signup():
    # data = {username, name, password}
    data = get_json(request.data)
    
    db = get_db()
    c = db.cursor()

    c.execute(
        "select * from user where username = %s;",
        (data.get("username"),)
    )

    user = c.fetchone()
    if user != None:
        return make_error("Username not available", HTTP_BADREQ)

    c.reset()

    hashed_password = sha256(data.get('password').encode('utf-8')).hexdigest()

    c.execute(
        "insert into user (name, username, password) values (%s,%s,%s)", 
        (data.get('name'), data.get('username'), hashed_password)
    )
    db.commit()
    c.close()

    return make_response(data, HTTP_SUCCESS)


@api_blueprint.route("/follow", methods=["POST"])
def follow():
    # data = {username, name, password}
    data = get_json(request.data)
    
    if (data.get("from_id") == None or data.get("to_id") == None):
        return make_error("Data insufficient")

    db = get_db()

    c = db.cursor()

    c.execute(
        "insert into follow (from_id, to_id, is_accepted) values (%s,%s,%s);",
        (data.get("from_id"), data.get("to_id"), True)
    )
    db.commit()

    if (c.rowcount == 1):
        c.close()
        return make_response(data={}, status=HTTP_SUCCESS)
    else:
        return make_error(message="Failed to follow", status=HTTP_BADREQ)

import json
from hashlib import sha256

import mysql.connector
from flask import Blueprint, Flask, Response, request
from utils.error_codes import HTTP_BADREQ, HTTP_SERVERERR, HTTP_SUCCESS
from utils.get_db import get_db
from utils.get_json import get_json
from utils.make_error import make_error
from utils.make_response import make_response

api_blueprint = Blueprint('posts_api', __name__)

# USER ----------------------------------------------------------------
@api_blueprint.route("/posts/get", methods=["POST"])
def get_posts():
    # data : {user_id}
    data = get_json(request.data)
    db = get_db()

    if data.get("user_id") != None:
        c = db.cursor(dictionary=True)

        c.execute(
            """
            select p.*, u.username, count(upvote.user_id) as upvotes
            from post as p 
            join user as u on p.user_id=u.id
            left join upvote on p.id = upvote.post_id

            where (
                p.user_id in (
                    select to_id from follow where (from_id=%s)
                )
                or
                p.user_id = %s
            )
            group by p.id;
            """,
            (data.get("user_id"), data.get("user_id"))
        )

        posts = c.fetchall()
        print(posts)

        c.close()
        if posts != None:
            return make_response(data=posts, status=HTTP_SUCCESS)
        else:
            return make_response(data=[], status=HTTP_SUCCESS)

    else:
        return make_error(message="Not authenticated", status=HTTP_BADREQ)

@api_blueprint.route("/posts/get/<id>", methods=["POST"])
def get_post_by_id(id):
    data = get_json(request.data)
    db = get_db()

    if data.get("user_id") != None:
        c = db.cursor(dictionary=True)

        c.execute(
            """
            select p.*, u.username, count(upvote.user_id) as upvotes
            from post as p 
            join user as u on p.user_id=u.id
            left join upvote on p.id = upvote.post_id

            where (
                p.id = %s
                and
                p.user_id in (
                    select to_id from follow where (from_id=%s)
                )
                or
                p.user_id = %s
            )
            group by p.id
            order by p.id desc;
            """,
            (id, data.get("user_id"), data.get("user_id"))
        )

        posts = c.fetchall()
        # print(posts)

        # get comments
        c.execute(
            """
            select p.id, count(pc.parent_id) 
            from post p 
            left join post pc on p.id = pc.parent_id
            group by p.id
            order by p.id desc;
            """
        )
        
        # comment_count = {}
        comments = c.fetchall()
        # comments_by_post = 
        # get tags

        if posts != None:
            return make_response(data=posts, status=HTTP_SUCCESS)
        else:
            return make_response(data=[], status=HTTP_SUCCESS)

    else:
        return make_error(message="Not authenticated", status=HTTP_BADREQ)

@api_blueprint.route("/posts/create", methods=["POST"])
def create_post():
    data = get_json(request.data)
    print(data)
    db = get_db()

    if data.get("user_id") != None:
        post = data.get("post")
        c = db.cursor()

        parent_id = post.get("parent_id") if post.get("parent_id") != None and post.get("parent_id") != -1 else None

        c.execute(
            """
            insert into post (title,content,user_id,parent_id) values (%s,%s,%s,%s);
            """,
            (post.get("title"), post.get("content"), data.get("user_id"), parent_id)
        )

        db.commit()
        
        if c.rowcount == 1 :
            c.close()
            return make_response(data={}, status=HTTP_SUCCESS)
        else :
            c.close()
            return make_error(message="Could not add post", status=HTTP_BADREQ)
        
        
    else:
        return make_error(message="Not authenticated", status=HTTP_BADREQ)

@api_blueprint.route("/posts/update", methods=["POST"])
def update_post():
    # data : {title, content, id, user_id}
    data = get_json(request.data)
    user_id = data.get("user_id")

    if user_id != None:
        try:
            db = get_db()
            c = db.cursor()
            title = data.get("title")
            content = data.get("content")
            id = data.get("id")

            q = """
                update post 
                set title=%s, content=%s 
                where id=%s;
            """
            c.execute(q, (title, content, id))
            db.commit()
            c.close()
            return make_response(data=data, status=HTTP_SUCCESS)

        except mysql.connector.Error as err:
            return make_error(message=err, status=HTTP_BADREQ)
    else:
        return make_error(message="Not authenticated", status=HTTP_BADREQ)

@api_blueprint.route("/posts/delete", methods=["POST"])
def delete_post():
    # data : {post_id, user_id}
    data = get_json(request.data)
    user_id = data.get("user_id")

    if user_id != None:
        try:
            db = get_db()
            c = db.cursor()
            post_id = data.get("post_id")

            q = """
                delete from post where id=%s;
            """
            c.execute(q, (post_id,))
            db.commit()
            print("QUERY EXECUTED!")
            c.close()
            return make_response(data=data, status=HTTP_SUCCESS)

        except mysql.connector.Error as err:
            return make_error(message=err, status=HTTP_BADREQ)
    else:
        return make_error(message="Not authenticated", status=HTTP_BADREQ)


@api_blueprint.route("/posts/upvote", methods=["POST"])
def upvote_post():
    data = get_json(request.data)
    
    user_id = data.get("user_id")

    if user_id != None:
        db = get_db()
        post_id = data.get("post_id")


        try:
            c = db.cursor()
            c.execute(
                """
                insert into upvote (user_id, post_id) values (%s,%s);
                """,
                (user_id, post_id)
            )
            db.commit()
            c.close()
            
            # get number of posts
            c = db.cursor(dictionary=True, buffered=True)
            c.execute(
                """
                select count(u.post_id) as upvotes
                from upvote u
                right join post p on u.post_id = p.id
                where p.id=%s
                group by p.id;
                """,
                (post_id,)
            )
            if c.rowcount >= 1:
                upvotes = c.fetchall()
                c.close()
                return make_response(data=upvotes[0], status=HTTP_SUCCESS)
            else :
                c.close()
                return make_error(message="Could not add upvote", status=HTTP_BADREQ)

        except mysql.connector.Error as err:
            return make_error(message=err.msg, status=HTTP_BADREQ)
        
        
    else:
        return make_error(message="Not authenticated", status=HTTP_BADREQ)

@api_blueprint.route("/user/<user_id>/posts", methods=["POST"])
def get_posts_by_user(user_id):
    db = get_db()
    return make_response(data={}, status=HTTP_SUCCESS)

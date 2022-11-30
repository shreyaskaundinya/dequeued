import mysql
from flask import g


def get_db():
    db = getattr(g, '_database', None)
    if db is None:
        db = g._database = mysql.connector.connect(
            host="localhost",
            user="root",
            password="K03n1g53gg008",
            database="dequeued_409"
        )
    return db


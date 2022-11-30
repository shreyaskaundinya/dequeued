import mysql
from flask_cors import CORS

from flask import Flask
from routes.posts import api as posts_api
from routes.user import api as user_api

app = Flask(__name__)
CORS(app)
app.register_blueprint(user_api.api_blueprint)
app.register_blueprint(posts_api.api_blueprint)

from flask import g


@app.teardown_appcontext
def teardown_db(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.close()

if __name__ == "__main__":
    app.run(port=5000, debug=True)

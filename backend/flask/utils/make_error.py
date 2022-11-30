from json import dumps

from flask import Response


def make_error(message, status):
    """
    i/p : message, status
    returns {"status":status, "message": message}
    """
    return Response(
        response=dumps({"status":status, "message": message}), 
        status=status
    )

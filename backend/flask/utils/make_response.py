import datetime
from json import dumps

from flask import Response


def serializer(o):
    if isinstance(o, datetime.datetime):
        return o.__str__()

def make_response(data, status):
    """
    i/p : data, status
    returns {"status":status, "data": data}
    """
    return Response(
        content_type="application/json",
        response=dumps({"status": status, "data": data}, default=serializer), 
        status=status
    )
  
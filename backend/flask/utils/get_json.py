from json import loads


def get_json(data):
    return loads(data.decode('ascii'))

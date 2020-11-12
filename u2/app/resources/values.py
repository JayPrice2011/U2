from flask_restful import Resource, reqparse
from passlib.hash import pbkdf2_sha256 as sha256
from db import DB
from flask_jwt_extended import (create_access_token, create_refresh_token, jwt_required, jwt_refresh_token_required, get_jwt_identity, get_raw_jwt)
import json

parser = reqparse.RequestParser()
parser.add_argument('params', type=dict, help = 'This field cannot be blank', required = True, action="append")
parser.add_argument('proc', help = 'This field cannot be blank', required = True)

class GetValue(Resource):
    """
    Get a single value
    """
    @jwt_required
    def get(self):
        return True


class GetValues(Resource):
    """
    Get all values
    """
    # @jwt_required
    def post(self):
        data = dict(parser.parse_args())
        try:
            db = DB()
            res = db.query(**data)
            return res
        except:
            return {'status': 500,'message': 'Something went wrong'}


class CreateValue(Resource):
    """
    Create a value
    """
    @jwt_required
    def post(self):
        data = dict(parser.parse_args())

        try:
            db = DB()
            res = db.commit(**data)
            return res
        except:
            return {'status': 500,'message': 'Something went wrong'}

from flask_restful import Resource, reqparse
from passlib.hash import pbkdf2_sha256 as sha256
from db import DB
from flask_jwt_extended import (create_access_token, create_refresh_token, jwt_required, jwt_refresh_token_required, get_jwt_identity, get_raw_jwt)
import json
from pprint import pprint

parser = reqparse.RequestParser()
parser.add_argument('params', type=dict, help = 'This field cannot be blank', required = True, action="append")
parser.add_argument('proc', help = 'This field cannot be blank', required = True)

class GetMasterValue(Resource):
    """
    Get a single master value
    """
    @jwt_required
    def get(self):
        return True


class GetMasterValues(Resource):
    """
    Get all master values
    """
    # @jwt_required
    def post(self):
        data = dict(parser.parse_args())
        pprint(data)
        try:
            db = DB()
            res = db.query(**data)
            return res
        except:
            return {'status': 500,'message': 'Something went wrong'}


class UpdateMasterValues(Resource):
    """
    'c' - Create master value(s)
    'r' - Replace master value(s)
    'u' - Update master value(s)
    'd' - Delete master value(s)
    """
    # @jwt_required
    def post(self):
        data = dict(parser.parse_args())

        try:
            db = DB()
            res = db.commit(**data)
            return res
        except:
            return {'status': 500,'message': 'Something went wrong'}

from flask_restful import Resource, reqparse
from passlib.hash import pbkdf2_sha256 as sha256
from db import DB
from flask_jwt_extended import (create_access_token, create_refresh_token, jwt_required, jwt_refresh_token_required, get_jwt_identity, get_raw_jwt)
import json
from flask_cors import cross_origin
from flask import jsonify


parser = reqparse.RequestParser()
parser.add_argument('params', type=dict, help = 'This field cannot be blank', required = True, action="append")
parser.add_argument('proc', help = 'This field cannot be blank', required = True)
parser.add_argument('procs', required=False, action="append")

class GetCode(Resource):
    """
    Get a single code
    """
    @jwt_required
    def get(self):
        return True

class GetCodes(Resource):
    """
    Get all codes
    """
    # @jwt_required
    def post(self):
        data = dict(parser.parse_args())
        try:
            if 'procs' in data:
                data['proc'] = data['procs']
                del data['procs']

            db = DB()
            res = db.query(**data)
            return jsonify(res)
        except:
            return {'status': 500,'message': 'Something went wrong'}

class CreateCode(Resource):
    """
    Create a code
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

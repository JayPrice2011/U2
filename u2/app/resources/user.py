from flask_restful import Resource, reqparse
from passlib.hash import pbkdf2_sha256 as sha256
from db import DB
from flask_jwt_extended import (create_access_token, create_refresh_token, jwt_required, jwt_refresh_token_required, get_jwt_identity, get_raw_jwt)
import json

parser = reqparse.RequestParser()
parser.add_argument('params', type=dict, help = 'This field cannot be blank', required = True)
parser.add_argument('proc', help = 'This field cannot be blank', required = True)


class test(Resource):
    def get(self):
        return {'status': 200, 'msg': "Hello world"}

class RegisterUser(Resource):
    """
    Registers a new user by storing username & hashing password
    """
    @jwt_required
    def post(self):
        data = dict(parser.parse_args())
        data['params']['password'] = sha256.hash(data['params']['password'])

        db = DB()
        res = db.commit(**data)

        if 'err' in res:
            return res

        access_token = create_access_token(identity = data['params']['username'])
        refresh_token = create_refresh_token(identity = data['params']['username'])

        res['msg'] = "User {} was created".format(data['params']['username'])
        res['tokens'] = {
            'access_token': access_token,
            'refresh_token': refresh_token
        }
        return res


class UserLogin(Resource):
    """
    Logs in user by verify username & password using JWT Auhtorization

    Returns access_token & refersh_token
    """
    def post(self):
        data = dict(parser.parse_args())
        password = data['params']['password']
        del data['params']['password']

        db = DB()
        res = db.query(**data)[0]
        print(res)

        if 'err' in res:
            return res

        print(password, res['password'])
        if sha256.verify(password, res['password']):
            access_token = create_access_token(identity = data['params']['username'])
            refresh_token = create_refresh_token(identity = data['params']['username'])
            return {
                'status':200,
                'message': 'Logged in as {}'.format(data['params']['username']),
                'access_token': access_token,
                'refresh_token': refresh_token
            }


        return {
            'status':401,
            'message': 'Could not login {}'.format(data['params']['username']),
        }


class ListUsers(Resource):
    """
    Lists all users
    """
    @jwt_required
    def post(self):
        data = dict(parser.parse_args())
        db = DB()
        return db.query(**data)


class RefreshToken(Resource):
    """
    Returns a new refreshed token
    """
    @jwt_refresh_token_required
    def post(self):
        user = get_jwt_identity()
        access_token = create_access_token(identity=user)
        return {'access_token': access_token}


class RequireJWT(Resource):
    """
    Example of how token decorater works
    """
    @jwt_required
    def get(self):
        return {'verification': "your token is verified!"}

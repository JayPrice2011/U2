from flask import Flask
from flask_restful import Api
from flask_jwt_extended import JWTManager
from flask_cors import CORS, cross_origin

app = Flask(__name__)
api = Api(app)
app.config['JWT_SECRET_KEY'] = 'jwt-secret-string'
jwt = JWTManager(app)

cors = CORS(app)
app.config['CORS_HEADERS'] = 'Content-Type'

from resources import user, codes, values, master_values
from db import DB

# User & token auth
api.add_resource(user.test, '/test')
api.add_resource(user.RegisterUser, '/registration')
api.add_resource(user.ListUsers, '/users')
api.add_resource(user.UserLogin, '/login')
api.add_resource(user.RequireJWT, '/token/test')
api.add_resource(user.RefreshToken, '/token/refresh')

# codes
api.add_resource(codes.GetCode, '/code')
api.add_resource(codes.GetCodes, '/codes')
api.add_resource(codes.CreateCode, '/code/add')

# values
api.add_resource(values.GetValue, '/value')
api.add_resource(values.GetValues, '/values')
api.add_resource(values.CreateValue, '/value/add')

# master values
api.add_resource(master_values.GetMasterValue, '/master-value')
api.add_resource(master_values.GetMasterValues, '/master-values')
api.add_resource(master_values.UpdateMasterValues, '/master-value/update')

import sys
sys.path.append('./configs')

import pymysql
import configparser
import psycopg2
import psycopg2.extras
from configs.db import cfg
from pprint import pprint
import json

class DB():
    def __init__(self):
        """
        Create new db object
        """
        self.conn = psycopg2.connect(**cfg)
        self.cur = self.conn.cursor(cursor_factory = psycopg2.extras.RealDictCursor)
        self.stmt = "SELECT * FROM _procs WHERE proc='%s'"


    def commit(self, proc, params):
        """
        Writes to database.
        """
        try:
            # query the proc stored in _procs
            self.cur.execute(self.stmt % proc)
            res = self.cur.fetchone();

            # handles dict
            if type(params) == dict:
                self.cur.execute(res['qry'], list(params.values()))
                res = 1

            # handles single item -> [{}]
            elif len(params) == 1:
                self.cur.execute(res['qry'], list(params[0].values()))
                res = 1

            # handles multiple items -> [{}, {}, ..... {}]
            elif len(params) > 1:
                _params = [tuple(p.values()) for p in params]
                print(res['qry'])
                psycopg2.extras.execute_batch(self.cur, res['qry'], _params)
                res = len(_params)
                

            self.conn.commit()
            self.conn.close()
            return  { 'status': 200, 'msg': "%s items were added." % res  }

        except (Exception, psycopg2.DatabaseError) as error:
            err = "Error: %s" % error
            print(err)
            return { 'status': 400, 'msg':err, 'err': 0}



    def query(self, proc, params):
        """
        Reads from db.
        """
        try:
            if type(proc) == list:
                res = {}
                for p in proc:
                    self.cur.execute(self.stmt % p)
                    _res = self.cur.fetchone()
                    self.cur.execute(_res['qry'])
                    res[p] = self.cur.fetchall()

            else:

                # query the proc stored in _sqlprocs
                self.cur.execute(self.stmt % proc)
                res = self.cur.fetchone();
                print(res['qry'])

                if len(params) == 1:
                    params = params[0]

                # if no prepared statement, return results
                if "%s" not in res['qry']:
                    self.cur.execute(res['qry'])
                    _res = self.cur.fetchall()

                    if 'added' in _res:
                        for r in _res:
                            r['added'] = str(r['added'])

                    res = _res
                else:
                    # run the query retrieved by with a prepared statement
                    self.cur.execute(res['qry'], list(params.values()))
                    res = self.cur.fetchall();

                self.conn.close()
            return res
        except (Exception, psycopg2.DatabaseError) as error:
            err = "Error: %s" % error
            print(err)
            return { 'status': 400, 'msg':err, 'err': 0}

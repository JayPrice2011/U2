#!/bin/bash
set -exou pipefail
sudo yum install python3.x86_64 -y || echo "python3.x86_64 failed to install"
sudo yum install python3-devel.x86_64 -y || echo "python3 dev tools failed to install"
sudo yum install gcc-c++ -y || echo "gcc-c++ failed to install" #maybe
sudo yum install git -y || echo "git failed to install"
sudo yum install tmux -y || echo "tmux failed to install"
sudo yum install iotop -y || echo "iotop failed to install"
pip3 install pipenv || echo "pipenv failed to install"
pip3 install wheel || echo "wheel failed to install"
pip3 install python-dotenv || echo "python-dotenv failed to install"
pip3 install flask || echo "flask failed to install"
pip3 install flask-cors || echo "flask-cors failed to install"
pip3 install boto3 || echo "boto3 failed to install"
pip3 install gunicorn || echo "gunicorn failed to install"
pip3 install requests || echo "requests failed"
pip3 install bs4 || echo "bs4 failed"
pip3 install praw || echo "praw install failed"
pip3 install black || echo "black install failed"
pip3 install psycopg2
pip3 install beautifulsoup4

pip3 install PyInquirer || echo "PyInquirer failed to install"
pip3 install pymysql || echo "pymysql failed to install"
pip3 install argparse || echo "argparse failed to install"
pip3 install flask-restful || echo "flask restful failed to install"
pip3 install flask_jwt_extended|| echo "flask _jwt_extended failed to install"
pip3 install passlib || echo "passlib failled to install"



#!/bin/bash
set -exou pipefail
rm tmp.sql  || echo "no tmp.sql found"
echo "select 'backout' script;">>tmp.sql
cat backout.sql>>tmp.sql

echo "select 'tables' script;">>tmp.sql
cat tables.sql>>tmp.sql

echo "select 'views' script;">>tmp.sql
cat views.sql>>tmp.sql

echo "select 'data' script;">>tmp.sql
cat data.sql>>tmp.sql
cat tmp.sql
u2 tmp.sql
rm tmp.sql



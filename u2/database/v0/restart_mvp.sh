#!/bin/bash
set -exou pipefail
rm tmp.sql  || echo "no tmp.sql found"
echo "select 'backout' script;">>tmp.sql
cat mvp_backout.sql>>tmp.sql
echo "select 'mvp_tables' script;">>tmp.sql
cat mvp_tables.sql>>tmp.sql
echo "select 'mvp_data' script;">>tmp.sql
cat mvp_data.sql>>tmp.sql
cat tmp.sql
u2 tmp.sql
rm tmp.sql
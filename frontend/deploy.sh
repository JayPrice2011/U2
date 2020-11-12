echo "Begin Deploy"
#echo "ng build turned off"
echo "build"

ng build
echo "clear bucket"
aws s3 rm s3://staging.test.magyk.cloud --recursive --profile magyk
aws s3 cp ./dist/frontend/ s3://staging.test.magyk.cloud --recursive --profile magyk
aws s3 rm s3://demo.magyk.cloud --recursive --profile magyk
aws s3 cp s3://staging.test.magyk.cloud s3://demo.magyk.cloud --recursive --profile magyk 
echo "end Deploy"



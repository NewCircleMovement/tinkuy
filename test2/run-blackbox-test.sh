rails server &
sleep 10
rm -rf test2/result; install -d test2/result; cd test2/result
for x in \
  "/" \
  "/events?dato=2015-07-06" \
  "/users" \
  "/resources" \
  "/info" 
do
  echo $x
  curl -s "http://localhost:3000$x" | grep -v token > ".$x-out"
done

ls -l
cd ..
killall ruby
sleep 1
# diff -r expected result

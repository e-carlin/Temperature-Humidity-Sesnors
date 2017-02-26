import requests
r = requests.post('http://localhost:3000/api/v1/readings', data = {'node_id' : '2', 'pin' : '8', 'temp': '22', 'hum' : '50', 'timeStamp' : '2017-02-15 00:46:34.521341'})
# r = requests.post('http://ec2-54-202-217-172.us-west-2.compute.amazonaws.com/api/v1/readings', data = {'temp': '22', 'hum' : '50', 'timeStamp' : '2017-02-15 00:46:34.521341'})
print r
print r.content

#{ "temp" : 50.36, "hum" : 46.50, "sID" : 16, "volt" : 3319,"timeStamp" : 2017-02-15 00:46:34.521341 }
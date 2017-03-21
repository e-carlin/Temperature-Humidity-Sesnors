import requests
r = requests.post('http://localhost:3000/api/v1/readings', headers={'Authorization' : 'rasPiAuth..0246'}, data = {"error" : "this is an error", "temp" : '58.82', "hum" : '50.50', "volt" : 3271,  "node_id" : 8, "timeStamp"  : "2017-03-06 14:44:13.193749-08:00"}
)
# r = requests.post('http://localhost:3000/api/v1/readings', data = {'err' : 'an error'})
# r = requests.post('http://ec2-54-202-217-172.us-west-2.compute.amazonaws.com/api/v1/readings', data = {'temp': '22', 'hum' : '50', 'timeStamp' : '2017-02-15 00:46:34.521341'})
print r.content
print r

#{ "temp" : 50.36, "hum" : 46.50, "sID" : 16, "volt" : 3319,"timeStamp" : 2017-02-15 00:46:34.521341 }
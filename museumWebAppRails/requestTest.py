import requests
r = requests.post('http://localhost:3000/api/v1/readings', data = 
	{'temperature': '66', 'humidity' : '80'})
print r
print r.content
import requests
r = requests.post('http://localhost:3000/api/v1/readings', data = 
	{'temp': '10', 'hum' : '80'})
print r
print r.content
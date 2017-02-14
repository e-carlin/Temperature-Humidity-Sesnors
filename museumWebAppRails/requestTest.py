import requests
r = requests.post('http://localhost:3000/api/v1/readings', data = 
	{'temp': '22', 'hum' : '50'})
print r
print r.content
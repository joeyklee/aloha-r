import pandas as pd
import geocoder
import time


f201401 = '/Users/Jozo/Projects/Github-local/Workshop/aloha-r/data/CaseLocationsDetails_2014_CSV/201401CaseLocationsDetails.csv'
f201402 = '/Users/Jozo/Projects/Github-local/Workshop/aloha-r/data/CaseLocationsDetails_2014_CSV/201402CaseLocationsDetails.csv'
data = pd.read_csv(f201401)


test = []
for i in data.Hundred_Block:
	if i == 'Intersection':
		test.append('')
	else:
		test.append(i.replace("#", "0"))

data['h_block'] = test
data['city'] = " Vancouver, BC, Canada"
data['full_address'] = data['h_block'] +" "+ data['Street_Name'] +","+data['city']
print data['full_address']


lat =[]
lon = [] 
for i in data['full_address']:
	# temp = geocoder.osm(i)
	temp = geocoder.bing(i, key='AjIweCKDtll_jAgD6sJeJJzco_aEzO2mwZ5SgpCLLmC1WIvvJXGVEkeWQtsehwc8')
	print(str(temp.lat) +",", str(temp.lng))
	lat.append(temp.lat)
	lon.append(temp.lng)
	# time.sleep(1)


data['lat'] = lat
data['lon'] = lon

data.to_csv('/Users/Jozo/Projects/Github-local/Workshop/aloha-r/data/CaseLocationsDetails_2014_CSV/201401CaseLocationsDetails-geo.csv')

# pk.eyJ1Ijoiam9leWtsZWUiLCJhIjoiMlRDV2lCSSJ9.ZmGAJU54Pa-z8KvwoVXVBw
# bing: AjIweCKDtll_jAgD6sJeJJzco_aEzO2mwZ5SgpCLLmC1WIvvJXGVEkeWQtsehwc8
# temp = geocoder.bing('COLLINGWOOD ST and W BROADWAY,Kitsilano, Vancouver, BC, Canada', key='AjIweCKDtll_jAgD6sJeJJzco_aEzO2mwZ5SgpCLLmC1WIvvJXGVEkeWQtsehwc8'); print temp.lat; print temp.lng
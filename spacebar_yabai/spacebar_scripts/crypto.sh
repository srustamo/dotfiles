#!/usr/bin/env python3
from bs4 import BeautifulSoup
import requests
import json
import sys

fiat = 'BTC'
if len(sys.argv) > 1:
    fiat = sys.argv[1]

if fiat.lower() == 'eth':
    cur = 1
    idx = '1027'
else:
    cur = 0
    idx = '1'
url = 'https://coinmarketcap.com/currencies/bitcoin'

cmc = requests.get(url)
soup = BeautifulSoup(cmc.content, 'html.parser')
data = soup.find('script', id='__NEXT_DATA__', type='application/json')
data = json.loads(data.contents[0])
crypt_data = data['props']['initialState']['cryptocurrency']['quotes'][idx]

percentChange = crypt_data['fmc24hpc']
price = crypt_data['p']
# percentChangeFormat = '<span color="{}">{}{:.2f}%</span>'
percentChangeFormat = '{}{:.2f}%'
precision = 2
if percentChange > 0:
    # percentChangeInfo = percentChangeFormat.format('#3BB92D', '', percentChange)
    percentChangeInfo = percentChangeFormat.format(' ', percentChange)
elif percentChange == 0:
    # percentChangeInfo = percentChangeFormat.format('#CCCCCC', '', percentChange)
    percentChangeInfo = percentChangeFormat.format('', percentChange)
else:
    # percentChangeInfo = percentChangeFormat.format('#F7555E', '', percentChange)
    percentChangeInfo = percentChangeFormat.format(' ', -percentChange)
print(('${:.' + str(precision) + 'f} {}').format(price, percentChangeInfo))  # Full Text

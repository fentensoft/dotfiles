#!/usr/bin/env python
#coding=utf8
import requests
params = {'action':'login','username':'10133700336','password':'{B}dG9ueTk4OUBwcGxl','ajax':'1','ac_id':'4'}
r = requests.post('http://10.9.27.18/include/auth_action.php', data=params)
print (r.text)

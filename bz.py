from PyQt5 import QtGui, QtCore
import os,sys,shutil
import codecs
import requests as rq
import json

from deepdiff import DeepDiff


class Bozorgrah(QtCore.QObject):
	
	def __init__(self, parent=None):
		QtCore.QObject.__init__(self,parent)
		self._server = ""
		self._username = ""
		self._password = ""
		
		self.last_data = None
		self.current_data = None
		
		self._log = ""
			
	@QtCore.pyqtProperty(str)
	def log(self):
		print(self._log)
		return self._log
	@log.setter
	def log(self,llog):
		self._log = self._log + "\n" + llog
		print(self._log)
		
	
	def lastData(self):
		#print(self.last_data)
		return self.last_data
		
	def currentData(self):
		#print(self.current_data)
		return self.current_data
		
	
	@QtCore.pyqtProperty(str)
	def server(self):
		return self._server
		
	@server.setter
	def server(self,value):
		self._server = value

	@QtCore.pyqtProperty(str)
	def username(self):
		return self._username
		
	@username.setter
	def username(self,value):
		self._username = value

	@QtCore.pyqtProperty(str)
	def password(self):
		return self._password
		
	@password.setter
	def password(self,value):
		self._password = value
		
	@QtCore.pyqtSlot()
	def getDataDirectory(self):
		if self._server.startswith("http://"):
			server = self._server[7:]
		else:
			server = self._server[8:]
		d = "data/"+server+"/"+self._username +"/"
		if not os.path.exists(d):
			os.makedirs(d)		
		return d
	@QtCore.pyqtSlot()
	def getLastData(self):		
		d = self.getDataDirectory()
		
		if os.path.isfile(d+'last.json'):
			f = codecs.open(d+'last.json','r','utf-8')
			t = f.read()
			f.close()
			self.last_data = json.loads(t)	
		else:
			self.last_data = None
	@QtCore.pyqtSlot()
	def getCurrentDataFromFile(self):
		d = self.getDataDirectory()
		
		if os.path.isfile(d+'current.json'):
			f = codecs.open(d+'current.json','r','utf-8')
			t = f.read()
			f.close()
			self.current_data = json.loads(t)	
		else:
			self.current_data = None			
	@QtCore.pyqtSlot()	
	def markAllRead(self):
		d = self.getDataDirectory()		
		if os.path.isfile(d+'current.json'):
			shutil.copy(d+'current.json',d+'last.json')
			
		self.compareLastAndCurrent()
	@QtCore.pyqtSlot()
	def getCurrentData(self):
		
		session = rq.Session()
		url = "%s/j_security_check"%self._server
		self.log = "loggin in "+self._server
		res1 = session.post(url,verify=False, data={'_spring_security_remember_me':'on','j_password':self._password,'j_username':self._username,'login':''})
		url = "%s/rest/task/dashboardTasks/1"%self._server
		self.log = "getting data ..."
		res2 = session.get(url,verify=False)

		d = self.getDataDirectory()
		
		f = codecs.open(d+'current.json','w+','utf-8')
		f.write(res2.text)
		f.close()
		self.compareLastAndCurrent()
		
	@QtCore.pyqtSlot()
	def compareLastAndCurrent(self):
		self.getLastData()
		self.getCurrentDataFromFile()
		if self.last_data is None:
			self.log = "it is first time you have logged in via me..."
			#print self.current_data
			self.log = "tasks:%d\nmeetings:%d\npoints:%d\nfollow ups:%d\nreminders:%d"%(len(self.current_data["tasks"]),
																								len(self.current_data["meetings"]),
																								len(self.current_data["points"]),
																								len(self.current_data["followUps"]),
																								len(self.current_data["reminders"]))
		else:
			self.log = "data fetched."
			r = DeepDiff(self.last_data,self.current_data)
			for k in r.changes.keys():
				self.log = k
				for d in r.changes[k]:
					self.log = d[:d.find(':')]

		
	


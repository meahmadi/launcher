from setuptools import setup
import os
import py2exe


import glob

  
def find_all_files(source,target):
	ret = {}
	for dirpath,_,filenames in os.walk(source):
	   for f in filenames:
		   ret[os.path.join(target,dirpath)] = os.path.abspath(os.path.join(dirpath, f))
	print(ret)
	return sorted(ret.items())
		
	
def find_data_files(source,target,patterns):
	if glob.has_magic(source) or glob.has_magic(target):
		raise ValueError("Magic not allowed in src, target")
	ret = {}
	for pattern in patterns:
		pattern = os.path.join(source,pattern)
		for filename in glob.glob(pattern):
			if os.path.isfile(filename):
				targetpath = os.path.join(target,os.path.relpath(filename,source))
				path = os.path.dirname(targetpath)
				ret.setdefault(path,[]).append(filename)
	return sorted(ret.items())


includes = ["sip",
			"PyQt5",
			"PyQt5.QtCore",
			"PyQt5.QtGui",
			"PyQt5.QtNetwork",
			"PyQt5.QtQml",
			"PyQt5.QtQuick",
			"deepdiff","json"]

datafiles = find_data_files('C:\\Python34\\Lib\\site-packages\\PyQt5\\plugins\\imageformats','imageformats',['*.dll']) +\
			[("platforms", ["C:\\Python34\\Lib\\site-packages\\PyQt5\\plugins" +\
							"\\platforms\\qwindows.dll"])]+\
			find_data_files('C:\\Python34\\Lib\\site-packages\\PyQt5\\qml\\QtQuick.2','QtQuick.2',['*']) +\
			find_data_files('C:\\Python34\\Lib\\site-packages\\PyQt5\\qml\\QtQuick\\Particles.2','QtQuick\\Particles.2',['*']) +\
			find_data_files('C:\\Python34\\Lib\\site-packages\\PyQt5\\qml\\QtQuick\\Controls','QtQuick\\Controls',['*']) +\
			find_data_files('C:\\Python34\\Lib\\site-packages\\PyQt5\\qml\\QtGraphicalEffects','QtGraphicalEffects',['*']) +\
			find_data_files('C:\\Python34\\Lib\\site-packages\\PyQt5\\qml\\QtGraphicalEffects\\private','QtGraphicalEffects\\private',['*'])

setup(
	name='launcher',
	url='',
	license='',
	windows=[{"script": "launcher.py"}],
	data_files=datafiles,
	options={
		"py2exe":{
			"includes": includes,
		}
	}
)			

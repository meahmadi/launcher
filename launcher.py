# -*- coding: utf-8 -*-
#!/usr/bin/env python

from PyQt5.QtCore import  QUrl,QObject, QUuid, pyqtSlot, pyqtProperty,Qt
from PyQt5.QtGui import QColor,QWindow, QGuiApplication
 
from PyQt5.QtQml import qmlRegisterType
from PyQt5.QtQuick import QQuickView
from bz import Bozorgrah

class LauncherEXUtils(QObject):
	def __init__(self):
		QObject.__init__(self)
		
	@pyqtProperty('QString')
	def newUUID(self):
		return QUuid.createUuid().toString()
		

if __name__ == '__main__':
	import os
	import sys

	app = QGuiApplication(sys.argv)
	app.setLayoutDirection(Qt.RightToLeft);


	view = QQuickView()
	context = view.rootContext()
	
	view.engine().setOfflineStoragePath(".")
	
	exutil = LauncherEXUtils()
	qmlRegisterType(LauncherEXUtils, 'ExUtils', 1, 0, 'ExUtils')
	qmlRegisterType(Bozorgrah,'Bozorgrah',1,0,'Bozorgrah')
	context.setContextProperty('exutils',exutil)
	
	view.setResizeMode(QQuickView.SizeRootObjectToView)
	try:
		approot = os.path.dirname(os.path.abspath(__file__))
	except NameError:  # We are the main py2exe script, not a module
		approot = os.path.dirname(os.path.abspath(sys.argv[0]))
	print(approot)
	view.setSource(
			QUrl.fromLocalFile(
					os.path.join(approot,'qml\\app.qml')))
					

	view.setFlags(Qt.Dialog or Qt.WindowStaysOnBottomHint);
	view.setTitle("ميزکار")
	view.show()
	
	view.engine().quit.connect(app.quit)

	sys.exit(app.exec_())

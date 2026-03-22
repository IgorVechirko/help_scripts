from fileinput import filename
from genericpath import isdir
import pathlib
import os
import shutil
import exifread

from posixpath import abspath
from stat import FILE_ATTRIBUTE_REPARSE_POINT
from xml.etree.ElementTree import tostring

#g_filesRootDir = 'H:\photos_sandbox\source'
#g_rootDrive = 'H:\photos_sandbox\photos'
#g_trashDir = 'H:\photos_sandbox\photos\\trash'

g_filesRootDir = 'H:\напівперебране\мамино'
g_rootDrive = 'H:\напівперебране\photos'
g_trashDir = 'H:\напівперебране\photos'

class TrashFileException(BaseException):
	
	def __init__(self):
		pass

def createAndGetDateDir(year:int, month:int) -> str:

	if year < 2000 or year > 2023:
		return g_trashDir

	if month < 1 or month > 12:
		return g_trashDir

	yearDir = g_rootDrive+"\\"+str(year)
	monthDir = yearDir+"\\"+str(month)

	if not os.path.exists(yearDir):
		os.mkdir(yearDir)

	if not os.path.exists(monthDir):
		os.mkdir(monthDir)

	return monthDir

def copyFileTo(filePath:str, copyPath:str):
	
	if not os.path.exists(filePath):
		print("Can't get", filePath)
		return

	if not os.path.isdir(copyPath):
		print("Invalid copy path", copyPath)
		return

	fileName = pathlib.Path(filePath).stem
	extensions = pathlib.Path(filePath).suffixes

	if not extensions.count:
		extensions.append('')

	copyFilePath = copyPath+'\\'+fileName+extensions[0]

	desFileExist = os.path.exists(copyFilePath)
	while desFileExist:
		fileName = fileName+"_copy"
		copyFilePath = copyPath+'\\'+fileName+extensions[0]
		desFileExist = os.path.exists(copyFilePath)


	#shutil.copy(filePath, copyFilePath)
	shutil.move(filePath, copyFilePath)

def isJPG(filePath:str) -> bool:

	extensions = pathlib.Path(filePath).suffixes

	if not extensions.count:
		return False

	extension=extensions[0].lower()

	return extension == '.jpg'

def getImageYearMonth(imagePath:str) -> tuple[int,int]:

	fd = open(imagePath, 'rb')
	tags = exifread.process_file(fd)
	dateTaken = tags["EXIF DateTimeOriginal"]
	parts = str(dateTaken).split(':')
	parts = parts[:2]

	year = parts[0]
	year = int(year.replace('\'', ''))
	month = parts[1]
	month = int(month.replace('\'', ''))

	return (year,month)


def recurseSort(path:str):

	if not os.path.isdir(path):
		return

	rootDirPath = pathlib.Path(path);
	for x in rootDirPath.iterdir():
		if x.is_dir():
			recurseSort(x)
		elif isJPG(x):
			try:
				year, month = getImageYearMonth(x)
				dateDir = createAndGetDateDir(year, month)
				copyFileTo(x, dateDir)
			except:
				print("Exeption",x)
			finally:
				pass#print("Exeption coused with", x)


recurseSort(g_filesRootDir)
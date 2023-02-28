#imports
import sys
import ftplib


#path and filename
strFileName = sys.argv[1]
strFileName = strFileName[0:len(strFileName)-2]
strFileName = strFileName + 'pc'

_ftp = ftplib.FTP(sys.argv[2])
_ftp.login()

print('Copying ',strFileName, ' to ', sys.argv[2])

_ftp.storbinary('STOR AnyFile.pc', open(strFileName, 'rb')) # todo: change anyfile to program name

#End of script
print('End of script')
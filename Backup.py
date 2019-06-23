### Importations ###

from tkinter import *
import os

### Variables ###

fen = Tk()
fen.title("Backup.py")
can = Canvas(fen, height = 160, width = 160)
txt1 = Label(can, text = "Nom :")
txt2 = Label(can, text = "Chemin : ")
txt3 = Label(can, text = "Nom :")
entr1 = Entry(can)
entr2 = Entry(can)
entr3 = Entry(can)

### Fonctions

def extract():
	os.system("./backup.sh extract")
	
def save():
	os.system("./backup.sh save %s %s" %(entr1, entr2))

def delete():
	os.system("./backup.sh delete %s" %(entr3))
	
def deleteAll():
	os.system("yes `echo YES` | ./backup.sh delete all")

### Buttons ###

boutton_Save = Button(can, text = "Save", command = save)
boutton_Delete = Button(can, text = "Delete", command = delete)
boutton_Delete_all = Button(can, text = "Delete All", command = deleteAll)
boutton_Extract = Button(can, text = "Extract", command = extract)

### Positions ###
txt1.grid(row = 1, column = 1)
entr1.grid(row = 1, column = 2)

txt2.grid(row = 1, column = 3)
entr2.grid(row = 1 , column = 4)
boutton_Save.grid(row = 1, column = 5)

txt3.grid(row = 4, column = 3)
entr3.grid(row = 4, column = 4)
boutton_Delete.grid(row = 4, column = 5)

boutton_Extract.grid(row = 4, column = 2)
boutton_Delete_all.grid(row = 5, column = 5)

can.grid(row = 5, column = 8, rowspan = 5)
fen.mainloop()
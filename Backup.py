### Importations ###

from tkinter import *
import os
from subprocess import check_output

### Variables ###

fen = Tk()
fen.title("Backup.py")
can = Canvas(fen, height = 200, width = 160)
txt1 = Label(can, text = "Nom :")
txt2 = Label(can, text = "Chemin : ")
txt3 = Label(can, text = "Nom :")

entr1_var = StringVar()
entr2_var = StringVar()
entr3_var = StringVar()
entr4_var = StringVar()

entr1 = Entry(can, textvariable = entr1_var)
entr2 = Entry(can, textvariable = entr2_var)
entr3 = Entry(can, textvariable = entr3_var)
entr4 = Entry(can, textvariable = entr4_var)

scrollbar = Scrollbar(can)

liste_bash = Listbox(can, xscrollcommand=scrollbar.set, width = 30)



### Fonctions

def extract():
	global entr3_var
	entr3_var = entr3_var.get()
	os.system("./backup.sh extract %s" %(entr3_var))

def save():
	global entr1_var, entr2_var
	entr1_var = entr1_var.get()
	entr2_var = entr2_var.get()
	os.system("./backup.sh save %s %s" %(entr1_var, entr2_var))

def delete():
	global entr3_var
	entr3_var = entr3_var.get()
	os.system("./backup.sh delete %s" %(entr3_var))
	
def deleteAll():
	os.system("yes `echo YES` | ./backup.sh delete all")

def listappend():
	os.system("./backup.sh list>file.txt")
	

### Buttons ###

boutton_Save = Button(can, text = "Save", command = save)
boutton_Delete = Button(can, text = "Delete", command = delete)
boutton_Delete_all = Button(can, text = "Delete All Backups", command = deleteAll)
boutton_Extract = Button(can, text = "Extract", command = extract)


### Positions ###
listappend()
fichier = open('file.txt','r')

for lignes in fichier:
	liste_bash.insert(1, lignes)


txt1.grid(row = 1, column = 1)
entr1.grid(row = 1, column = 2)

txt2.grid(row = 1, column = 3)
entr2.grid(row = 1 , column = 4)
boutton_Save.grid(row = 1, column = 5)

txt3.grid(row = 2, column = 3)
entr3.grid(row = 2, column = 4)
boutton_Delete.grid(row = 2, column = 5)

entr4.grid(row=3,column=4)
boutton_Extract.grid(row = 3, column = 5)

boutton_Delete_all.grid(row = 5, column = 2)
liste_bash.grid(row = 5, column=3)
scrollbar.grid(column = 3, row=6)
scrollbar.config(orient=HORIZONTAL, command=liste_bash.xview)

can.grid(row = 10, column = 5, rowspan = 3, padx=10, pady=10)
fen.mainloop()
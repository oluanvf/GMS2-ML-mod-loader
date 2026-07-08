import tkinter as tk
from tkinter import messagebox

# Cria uma janela invisível
janela = tk.Tk()
janela.withdraw()

# Mostra o popup
messagebox.showinfo(
    "Aviso",
    "Esta é uma mensagem de aviso!"
)

# Fecha o programa
janela.destroy()
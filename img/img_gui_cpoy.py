import flet as ft
from PIL import Image
import os
import pyperclip

def pixels(path):
    if not os.path.exists(path):
        print('Такого файла не существует')
        return

    try:
        image = Image.open(path)
        width, height = image.size
        print(f"Размер изображения: {width}x{height}")

        pix=[]

        for x in range(width):
            for y in range(height):

                rgb_pixel = image.getpixel((x, y))

                pix.append(f"({x}, {y}): {rgb_pixel}")

        with open("pixels.txt", "w", encoding='utf-8') as output:
            output.write("\n".join(pix))

    except Exception as e:
        print(f"Произошла ошибка {e}")
    return



def gui(page: ft.Page):
    page.title = "img_gui"
    page.theme_mode = "dark"
    page.vertical_alignment = ft.MainAxisAlignment.CENTER
    page.window.width = 550
    page.window.height = 600
    page.window.resizable = False


    def pix_action(e):
        path = user_path.value
        if path.startswith('"') and path.endswith('"'):
            path = path[1:-1]
        pixels(path)

    def eras(e):
        user_path.value = ''
        page.update()
    
    def cop(e):
        with open("pixels.txt", 'r', encoding='utf-8') as file:
            content = file.read()
        
        pyperclip.copy(content)

    user_path = ft.TextField(label="Путь")
    etnr_btn = ft.IconButton(ft.Icons.CALL_TO_ACTION_ROUNDED, width=50, on_click=pix_action)
    del_btn = ft.TextButton("Очистить поле ввода", on_click=eras)
    copy_btn = ft.IconButton(ft.Icons.COPY, on_click = cop)

    page.add(
        ft.Row(
            [
                del_btn
            ],
            alignment=ft.MainAxisAlignment.CENTER
        )
    ),

    page.add(
        ft.Row(
            [
                ft.Text("Путь до картинки"),
                user_path,
                etnr_btn
            ],
            alignment=ft.MainAxisAlignment.CENTER
        )
    ),

    page.add(
        ft.Row(
            [
                copy_btn
            ],
            alignment=ft.MainAxisAlignment.CENTER
        )
    )

ft.app(target=gui)


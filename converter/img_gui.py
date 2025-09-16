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
    page.window.width = 500
    page.window.height = 200
    page.window.resizable = False
    page.bgcolor = ft.Colors.GREY_900

    def on_file_selected(e: ft.FilePickerResultEvent):
        if e.files:
            directory = e.files[0].path
            print(f"Директория: {directory}")
            user_path.value = directory
            page.update()
        else:
            print('File pick canceled')
        
    file_picker = ft.FilePicker(on_result=on_file_selected)
    page.overlay.append(file_picker)

    def pix_action(e):
        path = user_path.value
        if path.startswith('"') and path.endswith('"'):
            path = path[1:-1]
        pixels(path)
        copy(e)

    def erase(e):
        user_path.value = ''
        page.update()
    
    def copy(e):
        with open("pixels.txt", 'r', encoding='utf-8') as file:
            content = file.read()
        
        pyperclip.copy(content)

    user_path = ft.TextField(label="Путь", 
                             width=300, 
                             border_color="Grey", 
                             cursor_color="Grey")

    enter_btn = ft.IconButton(ft.Icons.CALL_TO_ACTION_ROUNDED, 
                              icon_color="White", 
                              style=ft.ButtonStyle(side=ft.BorderSide(width=2, color=ft.Colors.GREY)), 
                              on_click=pix_action)

    del_btn = ft.TextButton(text="Очистить поле ввода", 
                            style=ft.ButtonStyle(color=ft.Colors.WHITE, text_style=ft.TextStyle(font_family="Comic Sans MS"), side=ft.BorderSide(width=2, color=ft.Colors.GREY)), 
                            on_click=erase)

    file_picker_btn = ft.IconButton(ft.Icons.FILE_OPEN, 
                                    icon_color="White", 
                                    style=ft.ButtonStyle(side=ft.BorderSide(width=2, color=ft.Colors.GREY)), 
                                    on_click=lambda _: file_picker.pick_files(allow_multiple=False))

    page.add(
        ft.Row(
            [
                ft.Text("Путь до картинки", font_family="Comic Sans MS", size=16)
            ],
            alignment=ft.MainAxisAlignment.CENTER
        )
    ),

    page.add(
        ft.Row(
            [
                file_picker_btn,
                user_path,
                enter_btn
            ],
            alignment=ft.MainAxisAlignment.CENTER
        )
    ),

    page.add(
        ft.Row(
            [
                del_btn
            ],
            alignment=ft.MainAxisAlignment.CENTER
        )
    ),


ft.app(target=gui)

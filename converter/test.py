import flet as ft

def main(page: ft.Page):
    def on_file_selected(e: ft.FilePickerResultEvent):
        if e.files:
            print(f"Выбран файл: {e.files[0].path}")
    
    file_picker = ft.FilePicker(on_result=on_file_selected)
    page.overlay.append(file_picker)
    
    select_btn = ft.ElevatedButton(
        "Выбрать файл",
        on_click=lambda _: file_picker.pick_files(allow_multiple=False)
    )
    
    page.add(select_btn)

ft.app(target=main)
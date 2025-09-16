import flet as ft

def main(page: ft.Page):
    # TextButton с измененным шрифтом
    custom_font_button = ft.TextButton(
        text="Кнопка с другим шрифтом",
        style=ft.ButtonStyle(
            text_style=ft.TextStyle(
                font_family="Arial",  # Название шрифта
                size=16,              # Размер текста
                weight=ft.FontWeight.BOLD  # Жирность
            )
        )
    )
    
    page.add(custom_font_button)

ft.app(target=main)
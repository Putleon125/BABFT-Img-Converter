import pyperclip
import os

def copy_file_to_clipboard(file_path):
    try:
        # Проверяем существование файла
        if not os.path.exists(file_path):
            print(f"Ошибка: файл '{file_path}' не найден")
            return False
        
        # Читаем содержимое файла
        with open(file_path, 'r', encoding='utf-8') as file:
            content = file.read()
        
        # Копируем текст в буфер обмена
        pyperclip.copy(content)
        print("Текст успешно скопирован в буфер обмена!")
        return True
        
    except Exception as e:
        print(f"Произошла ошибка: {str(e)}")
        return False

# Укажите путь к вашему файлу
file_path = "pixels.txt"  # Замените на путь к вашему файлу

# Вызываем функцию копирования
copy_file_to_clipboard(file_path)
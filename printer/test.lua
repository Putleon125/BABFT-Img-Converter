local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

-- Создаем GUI в ReplicatedStorage чтобы она сохранялась при ресете
local gui
if ReplicatedStorage:FindFirstChild("ImageBuilderGUI") then
    gui = ReplicatedStorage.ImageBuilderGUI:Clone()
else
    gui = Instance.new("ScreenGui")
    gui.Name = "ImageBuilderGUI"
    gui.ResetOnSpawn = false -- ВАЖНО: отключаем удаление при ресете
    gui.Parent = ReplicatedStorage
end

gui.Parent = player:WaitForChild("PlayerGui")
-- Основной фрейм
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 350, 0, 400)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
mainFrame.BorderSizePixel = 0

-- Закругленные углы
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = mainFrame

-- Тень
local uiShadow = Instance.new("UIStroke")
uiShadow.Color = Color3.fromRGB(20, 20, 20)
uiShadow.Thickness = 2
uiShadow.Parent = mainFrame

-- Заголовок
local titleFrame = Instance.new("Frame")
titleFrame.Size = UDim2.new(1, 0, 0, 40)
titleFrame.Position = UDim2.new(0, 0, 0, 0)
titleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
titleFrame.BorderSizePixel = 0

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 1, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "IMAGE BUILDER"
title.TextColor3 = Color3.fromRGB(220, 220, 220)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = titleFrame

titleFrame.Parent = mainFrame

-- Контентная область
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -60)
contentFrame.Position = UDim2.new(0, 10, 0, 50)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Поле ввода JSON
local jsonInputLabel = Instance.new("TextLabel")
jsonInputLabel.Size = UDim2.new(1, 0, 0, 20)
jsonInputLabel.Position = UDim2.new(0, 0, 0, 0)
jsonInputLabel.BackgroundTransparency = 1
jsonInputLabel.Text = "Pixel Data JSON:"
jsonInputLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
jsonInputLabel.Font = Enum.Font.Gotham
jsonInputLabel.TextSize = 14
jsonInputLabel.TextXAlignment = Enum.TextXAlignment.Left
jsonInputLabel.Parent = contentFrame

local jsonInput = Instance.new("TextBox")
jsonInput.Size = UDim2.new(1, 0, 0, 100)
jsonInput.Position = UDim2.new(0, 0, 0, 25)
jsonInput.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
jsonInput.TextColor3 = Color3.fromRGB(220, 220, 220)
jsonInput.Font = Enum.Font.Gotham
jsonInput.TextSize = 12
jsonInput.Text = "Вставь JSON данные пикселей здесь"
jsonInput.TextWrapped = true
jsonInput.ClearTextOnFocus = false

local jsonInputCorner = Instance.new("UICorner")
jsonInputCorner.CornerRadius = UDim.new(0, 8)
jsonInputCorner.Parent = jsonInput

local jsonInputStroke = Instance.new("UIStroke")
jsonInputStroke.Color = Color3.fromRGB(80, 80, 80)
jsonInputStroke.Thickness = 1
jsonInputStroke.Parent = jsonInput

jsonInput.Parent = contentFrame

-- Настройки
local settingsFrame = Instance.new("Frame")
settingsFrame.Size = UDim2.new(1, 0, 0, 120)
settingsFrame.Position = UDim2.new(0, 0, 0, 135)
settingsFrame.BackgroundTransparency = 1
settingsFrame.Parent = contentFrame

-- Выбор типа блока
local blockTypeLabel = Instance.new("TextBox")
blockTypeLabel.Size = UDim2.new(0.5, -5, 0, 20)
blockTypeLabel.Position = UDim2.new(0, 0, 0, 0)
blockTypeLabel.BackgroundTransparency = 1
blockTypeLabel.Text = "Тип блока:"
blockTypeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
blockTypeLabel.Font = Enum.Font.Gotham
blockTypeLabel.TextSize = 14
blockTypeLabel.TextXAlignment = Enum.TextXAlignment.Left
blockTypeLabel.Parent = settingsFrame

local blockTypeDropdown = Instance.new("TextButton")
blockTypeDropdown.Size = UDim2.new(0.5, -5, 0, 30)
blockTypeDropdown.Position = UDim2.new(0, 0, 0, 20)
blockTypeDropdown.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
blockTypeDropdown.TextColor3 = Color3.fromRGB(220, 220, 220)
blockTypeDropdown.Font = Enum.Font.Gotham
blockTypeDropdown.TextSize = 12
blockTypeDropdown.Text = "WoodBlock"

local blockTypeCorner = Instance.new("UICorner")
blockTypeCorner.CornerRadius = UDim.new(0, 6)
blockTypeCorner.Parent = blockTypeDropdown

local blockTypeStroke = Instance.new("UIStroke")
blockTypeStroke.Color = Color3.fromRGB(80, 80, 80)
blockTypeStroke.Thickness = 1
blockTypeStroke.Parent = blockTypeDropdown

blockTypeDropdown.Parent = settingsFrame

-- Размер блока
local blockSizeLabel = Instance.new("TextLabel")
blockSizeLabel.Size = UDim2.new(0.5, -5, 0, 20)
blockSizeLabel.Position = UDim2.new(0.5, 5, 0, 0)
blockSizeLabel.BackgroundTransparency = 1
blockSizeLabel.Text = "Размер блока:"
blockSizeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
blockSizeLabel.Font = Enum.Font.Gotham
blockSizeLabel.TextSize = 14
blockSizeLabel.TextXAlignment = Enum.TextXAlignment.Left
blockSizeLabel.Parent = settingsFrame

local blockSizeSlider = Instance.new("TextBox")
blockSizeSlider.Size = UDim2.new(0.5, -5, 0, 30)
blockSizeSlider.Position = UDim2.new(0.5, 5, 0, 20)
blockSizeSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
blockSizeSlider.TextColor3 = Color3.fromRGB(220, 220, 220)
blockSizeSlider.Font = Enum.Font.Gotham
blockSizeSlider.TextSize = 12
blockSizeSlider.Text = "4"

local blockSizeCorner = Instance.new("UICorner")
blockSizeCorner.CornerRadius = UDim.new(0, 6)
blockSizeCorner.Parent = blockSizeSlider

local blockSizeStroke = Instance.new("UIStroke")
blockSizeStroke.Color = Color3.fromRGB(80, 80, 80)
blockSizeStroke.Thickness = 1
blockSizeStroke.Parent = blockSizeSlider

blockSizeSlider.Parent = settingsFrame

-- Кнопка построения
local buildButton = Instance.new("TextButton")
buildButton.Size = UDim2.new(1, 0, 0, 40)
buildButton.Position = UDim2.new(0, 0, 1, -40)
buildButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
buildButton.TextColor3 = Color3.fromRGB(220, 220, 220)
buildButton.Font = Enum.Font.GothamBold
buildButton.TextSize = 16
buildButton.Text = "НАЧАТЬ ПОСТРОЕНИЕ"

local buildButtonCorner = Instance.new("UICorner")
buildButtonCorner.CornerRadius = UDim.new(0, 8)
buildButtonCorner.Parent = buildButton

local buildButtonStroke = Instance.new("UIStroke")
buildButtonStroke.Color = Color3.fromRGB(90, 90, 90)
buildButtonStroke.Thickness = 1
buildButtonStroke.Parent = buildButton

-- Анимация наведения
buildButton.MouseEnter:Connect(function()
    TweenService:Create(buildButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
end)

buildButton.MouseLeave:Connect(function()
    TweenService:Create(buildButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}):Play()
end)

buildButton.Parent = contentFrame

-- Функция построения
buildButton.MouseButton1Click:Connect(function()
    local jsonText = jsonInput.Text
    local blockType = blockTypeDropdown.Text
    local blockSize = tonumber(blockSizeSlider.Text) or 4
    
    -- Здесь будет вызов функции построения
    print("Начинаем построение...")
    print("Тип блока:", blockType)
    print("Размер:", blockSize)
    
    -- Временное сообщение
    buildButton.Text = "СТРОИТЕЛЬСТВО..."
    wait(2)
    buildButton.Text = "НАЧАТЬ ПОСТРОЕНИЕ"
end)

-- Делаем GUI перемещаемым
local dragging = false
local dragInput, dragStart, startPos

titleFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

mainFrame.Parent = gui

print("GUI загружена! Используйте для построения изображений.")
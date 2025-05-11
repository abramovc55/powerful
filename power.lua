-- Убедись, что эксплойт поддерживает HTTP-запросы (например, syn.request)

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

-- Создаём GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WebhookGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 250, 0, 100)
Frame.Position = UDim2.new(0.5, -125, 0.5, -50)
Frame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

-- Верхняя панель для перетаскивания
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 25)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TopBar.BorderSizePixel = 0
TopBar.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Text = "Trezub hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.Parent = TopBar

-- Кнопка
local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0.8, 0, 0, 40)
Button.Position = UDim2.new(0.1, 0, 0.55, 0)
Button.Text = "Нажми сюда"
Button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Font = Enum.Font.Gotham
Button.TextScaled = true
Button.BorderSizePixel = 0
Button.AutoButtonColor = true
Button.Parent = Frame

-- Функция отправки вебхука
local function sendWebhook()
    local url = "https://discord.com/api/webhooks/1338901334241316864/WycwHgydVLxZ0_D9Z46WYQhwmfyWQNl0ocmwdjiAGs5RM5DVh0qEJAgJfplZFDAeBpJG"

    local data = {
        ["content"] = "**Кнопка нажата** от игрока: " .. LocalPlayer.Name
    }

    local body = HttpService:JSONEncode(data)

    -- Используем syn.request или совместимую функцию
    if syn and syn.request then
        syn.request({
            Url = url,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = body
        })
    elseif http and http.request then
        http.request({
            Url = url,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = body
        })
    elseif request then
        request({
            Url = url,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = body
        })
    else
        warn("Эксплойт не поддерживает HTTP-запросы.")
    end
end

-- Обработка нажатия
Button.MouseButton1Click:Connect(function()
    sendWebhook()
end)

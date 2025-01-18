-- Notify Library
local Notify = {}

function Notify:CreateNotification(properties)
    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "NotifySystem"
    screenGui.Parent = playerGui

    local positionPresets = {
        BottomRight = UDim2.new(1, -310, 1, -70),
        BottomLeft = UDim2.new(0, 10, 1, -70),
        TopLeft = UDim2.new(0, 10, 0, 10),
        TopRight = UDim2.new(1, -310, 0, 10),
        TopCenter = UDim2.new(0.5, -150, 0, 10),
    }

    local startPosition = UDim2.new(0.5, 0, -0.1, 0) -- Começa fora da tela
    local endPosition = positionPresets[properties.Position or "BottomRight"]

    local frame = Instance.new("Frame")
    frame.Name = "Notification"
    frame.Size = UDim2.new(0, 300, 0, 60)
    frame.Position = startPosition
    frame.AnchorPoint = Vector2.new(0.5, 0)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    -- tema
    local theme = properties.Theme or "Default" -- Default, Hell Menu, Hyper Infinity
    local backgroundTransparency = properties.BackgroundTransparency or 0.3
    local backgroundColor = properties.BackgroundColor3 or Color3.fromRGB(45, 45, 45)

    -- Aplica estilos de tema
    if theme == "Hell Menu" then
        backgroundColor = Color3.fromRGB(0, 0, 0) -- Fundo preto
        backgroundTransparency = 0
        local gradient = Instance.new("UIGradient")
        gradient.Rotation = (properties.Position or "BottomRight"):match("Bottom") and 270 or 90
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), -- Vermelho
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)), -- Preto
        })
        gradient.Parent = frame
    elseif theme == "Hyper Infinity" then
        backgroundColor = Color3.fromRGB(0, 0, 0)
        backgroundTransparency = 0.4 -- Transparente
        local gradient = Instance.new("UIGradient")
        gradient.Rotation = (properties.Position or "BottomRight"):match("Bottom") and 270 or 90
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
        })
        gradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(1, 1),
        })
        gradient.Parent = frame
    end

    frame.BackgroundColor3 = backgroundColor
    frame.BackgroundTransparency = backgroundTransparency

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "NotificationText"
    textLabel.Text = properties.Text or "Nova notificação!"
    textLabel.Size = UDim2.new(1, -20, 1, -10)
    textLabel.Position = UDim2.new(0, 10, 0, 5)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = properties.TextColor3 or Color3.fromRGB(255, 255, 255)
    textLabel.Font = properties.Font or Enum.Font.GothamBold
    textLabel.TextSize = properties.TextSize or 18
    textLabel.TextWrapped = true
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = frame

    frame:TweenPosition(
        endPosition,
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        0.5,
        true
    )

    delay(properties.Duration or 3, function()
        frame:TweenPosition(
            startPosition,
            Enum.EasingDirection.In,
            Enum.EasingStyle.Quad,
            0.5,
            true,
            function()
                screenGui:Destroy()
            end
        )
    end)
end

return Notify

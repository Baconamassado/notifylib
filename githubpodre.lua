-- Notify Library
local Notify = {}

function Notify:CreateNotification(properties)
    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "NotifySystem"
    screenGui.Parent = playerGui

    local frame = Instance.new("Frame")
    frame.Name = "Notification"
    frame.Size = UDim2.new(0, 300, 0, 60)
    frame.Position = UDim2.new(0.5, 0, -0.1, 0) -- Começa fora da tela
    frame.AnchorPoint = Vector2.new(0.5, 0)
    frame.BackgroundColor3 = properties.BackgroundColor3 or Color3.fromRGB(45, 45, 45)
    frame.BackgroundTransparency = properties.BackgroundTransparency or 0.3
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    local shadow = Instance.new("Frame")
    shadow.Name = "Shadow"
    shadow.Size = frame.Size + UDim2.new(0, 6, 0, 6)
    shadow.Position = frame.Position + UDim2.new(0, 3, 0, 3)
    shadow.AnchorPoint = frame.AnchorPoint
    shadow.BackgroundColor3 = Color3.new(0, 0, 0)
    shadow.BackgroundTransparency = 0.8
    shadow.BorderSizePixel = 0
    shadow.Parent = screenGui
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = corner.CornerRadius
    shadowCorner.Parent = shadow

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
        UDim2.new(0.5, 0, 0.1, 0), 
        Enum.EasingDirection.Out, 
        Enum.EasingStyle.Quad, 
        0.5, 
        true
    )
    shadow:TweenPosition(frame.Position, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)

    delay(properties.Duration or 3, function()
        frame:TweenPosition(
            UDim2.new(0.5, 0, -0.1, 0), 
            Enum.EasingDirection.In, 
            Enum.EasingStyle.Quad, 
            0.5, 
            true,
            function()
                screenGui:Destroy()
            end
        )
        shadow:TweenPosition(frame.Position, Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.5, true)
    end)
end

return Notify

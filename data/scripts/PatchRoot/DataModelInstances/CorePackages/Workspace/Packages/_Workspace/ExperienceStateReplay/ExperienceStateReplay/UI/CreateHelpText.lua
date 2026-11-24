-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local scriptParent = script.Parent
local CreateButtonsTime = require(scriptParent.CreateButtonsTime)

function module.createHelpText(arg1)
    arg1.HelpRevealer = Instance.new("TextLabel")
    arg1.HelpRevealer.Name = "HelpRevealer"
    arg1.HelpRevealer.Font = Enum.Font.SourceSans
    arg1.HelpRevealer.TextXAlignment = Enum.TextXAlignment.Center
    arg1.HelpRevealer.TextYAlignment = Enum.TextYAlignment.Center
    arg1.HelpRevealer.Size = UDim2.new(0.5, 0, 1.3, 0)
    arg1.HelpRevealer.SizeConstraint = Enum.SizeConstraint.RelativeXY
    arg1.HelpRevealer.AnchorPoint = Vector2.new(0.5, 0.5)
    arg1.HelpRevealer.Position = UDim2.new(0.5, 0, 0.5, 0)
    arg1.HelpRevealer.BackgroundTransparency = 1
    arg1.HelpRevealer.Text = "?"
    arg1.HelpRevealer.TextColor3 = CreateButtonsTime.regularColor
    arg1.HelpRevealer.TextScaled = true
    arg1.HelpRevealer.Parent = arg1.HelpBar

    local uiPadding = Instance.new("UIPadding")
    uiPadding.PaddingBottom = UDim.new(0.05, 0)
    uiPadding.Parent = arg1.HelpRevealer

    arg1.HelpDescription = Instance.new("TextLabel")
    arg1.HelpDescription.Name = "HelpDescription"
    arg1.HelpDescription.Font = Enum.Font.SourceSans
    arg1.HelpDescription.TextXAlignment = Enum.TextXAlignment.Left
    arg1.HelpDescription.TextYAlignment = Enum.TextYAlignment.Top
    arg1.HelpDescription.AnchorPoint = Vector2.new(1, 1)
    arg1.HelpDescription.Position = UDim2.new(1, 0, 0, 0)
    arg1.HelpDescription.Size = UDim2.new(5.3, 0, 2.5, 0)
    arg1.HelpDescription.SizeConstraint = Enum.SizeConstraint.RelativeXY
    arg1.HelpDescription.BorderSizePixel = 0
    arg1.HelpDescription.BackgroundColor3 = arg1.defaultBackgroundColor3
    arg1.HelpDescription.BackgroundTransparency = arg1.defaultBackgroundTransparency
    arg1.HelpDescription.RichText = true
    arg1.HelpDescription.Text = "<b>Shortcuts</b>\n<u>space</u> - play/pause\n<u>r</u> - rewind\n<u>s</u> - stop"

    arg1.HelpDescription.TextColor3 = Color3.fromRGB(255, 255, 255)
    arg1.HelpDescription.TextScaled = Enum.AutomaticSize.XY
    arg1.HelpDescription.Parent = arg1.HelpBar
    arg1.HelpDescription.Visible = false

    local uiPadding2 = Instance.new("UIPadding")
    uiPadding2.PaddingLeft = UDim.new(0.02, 0)
    uiPadding2.PaddingBottom = UDim.new(0.02, 0)
    uiPadding2.Parent = arg1.HelpDescription

    arg1.HelpRevealer.MouseEnter:Connect(function()
        arg1.HelpRevealer.TextColor3 = CreateButtonsTime.hoverColor
        arg1.HelpDescription.Visible = true
    end)

    arg1.HelpRevealer.MouseLeave:Connect(function()
        arg1.HelpRevealer.TextColor3 = CreateButtonsTime.regularColor
        arg1.HelpDescription.Visible = false
    end)
end

return module

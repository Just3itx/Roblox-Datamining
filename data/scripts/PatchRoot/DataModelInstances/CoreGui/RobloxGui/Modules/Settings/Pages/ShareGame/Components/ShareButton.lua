-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:21:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local Theme = require(RobloxGui.Modules.Settings.Theme)

local Font = Theme.font(Enum.Font.SourceSansSemibold, "Semibold")
local TextSize = Theme.textSize(19)
local quillGrey = Color3.fromRGB(222, 225, 227)
local white = Color3.fromRGB(255, 255, 255)

local var3 = Roact.PureComponent:extend("ShareButton")

function var3.init(arg1)
    arg1.state = { isHovering = false }
end

function var3.render(arg1)
    local size = arg1.props.size
    local layoutOrder = arg1.props.layoutOrder
    local onShare = arg1.props.onShare
    local isEnabled = arg1.props.isEnabled
    local text = arg1.props.text

    local tbl1 = ({})
    tbl1.Border = Roact.createElement("UIStroke", {
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = if arg1.state.isHovering and isEnabled then quillGrey else white,
        Thickness = Theme.DefaultStokeThickness,
        Transparency = if isEnabled then 0 else 0.5
    })
    tbl1.UICorner = Roact.createElement("UICorner", { CornerRadius = Theme.DefaultCornerRadius })

    local createElement = Roact.createElement
    local str1 = "TextButton"
    local tbl2 = {
        LayoutOrder = layoutOrder,
        Size = size,
        Text = text,
        TextSize = TextSize,
        Font = Font,
        AutoButtonColor = false,
        BackgroundColor3 = if arg1.state.isHovering and isEnabled then quillGrey else white,
        Transparency = if isEnabled then 0 else 0.5
    }
    tbl2[Roact.Event.Activated] = function()
        if isEnabled then
            onShare()
        end
    end
    tbl2[Roact.Event.InputBegan] = function()
        arg1:setState({ isHovering = true })
    end
    tbl2[Roact.Event.InputEnded] = function()
        arg1:setState({ isHovering = false })
    end

    return createElement(str1, tbl2, tbl1)
end

return var3

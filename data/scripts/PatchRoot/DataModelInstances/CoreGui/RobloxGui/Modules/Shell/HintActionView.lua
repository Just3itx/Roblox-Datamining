-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Shell = game:GetService("CoreGui"):FindFirstChild("RobloxGui"):FindFirstChild("Modules"):FindFirstChild("Shell")

local ContextActionService = game:GetService("ContextActionService")
local TextService = game:GetService("TextService")

local GlobalSettings = require(Shell:FindFirstChild("GlobalSettings"))
local Utility = require(Shell:FindFirstChild("Utility"))
local RoactGamepad = require(CorePackages.Packages.RoactGamepad)
local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create

local getFFlagDebugLuaAppAlwaysUseGamepad = require(CorePackages.Workspace.Packages.SharedFlags).getFFlagDebugLuaAppAlwaysUseGamepad

local function createHintActionView(arg1, actionName, arg2)
    if arg2 == nil then
        arg2 = UDim2.new(1, -1, 1, -1)
    end

    local module = {}

    actionName = if actionName == nil or #actionName == 0 then "DefaultHintAction" else actionName

    local var1 = Create("Frame")(
        {
            Name = "HintActionContainer",
            Size = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            Parent = arg1
        }
    )
    local var2 = Create("TextLabel")({
        Name = "HintActionText",
        BackgroundTransparency = 1,
        Font = GlobalSettings.RegularFont,
        FontSize = GlobalSettings.TitleSize,
        TextColor3 = GlobalSettings.WhiteTextColor,
        TextXAlignment = Enum.TextXAlignment.Right,
        Text = "",
        ZIndex = 10,
        Parent = var1
    })

    local var3 = Create("ImageLabel")({
        Name = "HintActionImage",
        Size = UDim2.new(0, 83, 0, 83),
        BackgroundTransparency = 1,
        Image = "",
        ZIndex = 10,
        Parent = var1
    })

    local function updateLayout()
        local vector2 = TextService:GetTextSize(var2.Text, Utility.ConvertFontSizeEnumToInt(var2.FontSize), var2.Font, Vector2.new(0, 0))
        var2.Size = UDim2.new(0, vector2.x, 0, var3.Size.Y.Offset)
        var2.Position = UDim2.new(1, -vector2.x, 0, -4)

        local xOffset = vector2.x + var3.Size.X.Offset + 8

        var1.Size = UDim2.new(0, xOffset, 0, var3.Size.Y.Offset)

        var1.Position = UDim2.new(arg2.X.Scale, arg2.X.Offset * var1.Size.X.Offset, arg2.Y.Scale, arg2.Y.Offset * var1.Size.Y.Offset)
    end

    function module.BindAction(_, functionToBind, inputTypes)
        if not functionToBind then
            return
        end

        ContextActionService:UnbindCoreAction(actionName)
        if getFFlagDebugLuaAppAlwaysUseGamepad() and RoactGamepad.Config.DebugKeyboardBindings then
            local debugKeyboardBinding = RoactGamepad.Config.DebugKeyboardBindings[inputTypes] or {}
            ContextActionService:BindCoreAction(actionName, functionToBind, false, inputTypes, table.unpack(debugKeyboardBinding))
            return
        end
        ContextActionService:BindCoreAction(actionName, functionToBind, false, inputTypes)
    end

    function module.UnbindAction(_)
        ContextActionService:UnbindCoreAction(actionName)
    end

    function module.SetParent(_, arg3)
        var1.Parent = arg3
    end

    function module.SetVisible(_, visible)
        var1.Visible = visible
    end

    function module.SetTransparency(_, arg3)
        var2.TextTransparency = arg3
        var3.ImageTransparency = arg3
    end

    function module.SetVisibleWithTween(_, arg3)
        Utility.PropertyTweener(var2, "TextTransparency", var2.TextTransparency, arg3, 0.25, Utility.EaseOutQuad, true)
        Utility.PropertyTweener(var3, "ImageTransparency", var3.ImageTransparency, arg3, 0.25, Utility.EaseOutQuad, true)
    end

    function module.SetText(_, text)
        if text == var2.Text then
            return
        end

        var2.Text = text
        updateLayout()
    end

    function module.SetImage(_, image)
        if image == var3.Image then
            return
        end

        var3.Image = image
    end

    return module
end

return createHintActionView

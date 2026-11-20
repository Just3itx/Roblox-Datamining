-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local LocalizationService = game:GetService("LocalizationService")
local UserInputService = game:GetService("UserInputService")
local _RobloxGui = CoreGui:WaitForChild("RobloxGui")

local ReactUtils = require(CorePackages.Packages.ReactUtils)
local React = require(CorePackages.Packages.React)
local _UIBlox = require(CorePackages.Packages.UIBlox)
local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local normalizeFontFace = require(CorePackages.Packages.Foundation).Utility.normalizeFontFace

local FFlagEnableConsoleExpControls = SharedFlags.FFlagEnableConsoleExpControls

local useEventConnection = ReactUtils.useEventConnection
local GetTextSize = require(CorePackages.Workspace.Packages.Style).GetTextSize
local useDesignTokens = require(CorePackages.Workspace.Packages.Style).useDesignTokens
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local Chrome = scriptParentParentParentParent.Parent.Chrome
local var1 = require(CorePackages.Workspace.Packages.Chrome).Enabled()
local GamepadConnector = if FFlagEnableConsoleExpControls and not var1 then nil else require(scriptParentParentParentParent.Components.GamepadConnector)
local useObservableValue = require(Chrome.ChromeShared.Hooks.useObservableValue)

local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization

local function MenuNavigationToggleDialog(tbl1)
    local var2 = useDesignTokens()
    local captionMedium = var2.Typography.CaptionMedium
    local size400 = var2.Size.Size_400
    local size150 = var2.Size.Size_150
    local medium = var2.Radius.Medium
    local size600 = var2.Size.Size_600
    local overMedia0 = var2.Color.OverMedia.OverMedia_0
    local color3 = var2.Color.Content.Emphasis.Color3
    local size100 = var2.Size.Size_100

    local image = if game:GetEngineFeature("GetImageForKeyCode") then UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonSelect) else "rbxasset://textures/ui/Controls/DesignSystem/ButtonSelect@2x.png"

    local var4, var5 = React.useState(LocalizationService.RobloxLocaleId)
    useEventConnection(LocalizationService:GetPropertyChangedSignal("RobloxLocaleId"), function()
        var5(LocalizationService.RobloxLocaleId)
    end)

    local var6, var7 = React.useMemo(function()
        local localization = Localization.new(var4)

        local success, result = pcall(localization.Format, localization, "CoreScripts.InGameMenu.VirtualCursorHintPreIcon")
        local success2, result2 = pcall(localization.Format, localization, "CoreScripts.InGameMenu.VirtualCursorHintPostIcon")

        local var6 = if success then result else "Some experiences require pressing"
        if success2 then
            return var6, result2
        end

        return var6, "to toggle menu navigation"
    end, { var4 })

    local var8 = var6
    local var9 = var7

    local var10, var11 = React.useMemo(function()
        return GetTextSize(var8, captionMedium.FontSize, captionMedium.Font, Vector2.new(math.huge, math.huge)), (GetTextSize(var9, captionMedium.FontSize, captionMedium.Font, Vector2.new(math.huge, math.huge)))
    end, {
        captionMedium.FontSize,
        captionMedium.Font,
        var8,
        var9
    })
    local var12 = nil
    if var1 then
        if FFlagEnableConsoleExpControls then
            var12 = useObservableValue(GamepadConnector:getSelectedCoreObject())
        end
    else
        var12 = nil
    end

    return React.createElement("Frame", {
        BackgroundColor3 = overMedia0.Color3,
        BackgroundTransparency = overMedia0.Transparency,
        AutomaticSize = Enum.AutomaticSize.XY,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = tbl1.Position,
        Visible = not (var1 and FFlagEnableConsoleExpControls) or var12 ~= nil
    }, {
        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, medium) }),
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, size100)
        }),
        LeftText = React.createElement("TextLabel", {
            Size = UDim2.fromOffset(var10.X, var10.Y),
            Text = var8,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            TextColor3 = color3,
            FontFace = normalizeFontFace(captionMedium.Font),
            TextSize = captionMedium.FontSize,
            TextWrapped = false,
            BackgroundTransparency = 1,
            LayoutOrder = 0
        }),
        Icon = React.createElement(
            "ImageLabel",
            {
                Size = UDim2.fromOffset(size600, size600),
                BackgroundTransparency = 1,
                LayoutOrder = 100,
                Image = image
            }
        ),
        RightText = React.createElement("TextLabel", {
            Size = UDim2.fromOffset(var11.X, var11.Y),
            Text = var9,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            TextColor3 = color3,
            FontFace = normalizeFontFace(captionMedium.Font),
            TextSize = captionMedium.FontSize,
            TextWrapped = false,
            BackgroundTransparency = 1,
            LayoutOrder = 200
        }),
        Padding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, size150),
            PaddingBottom = UDim.new(0, size150),
            PaddingLeft = UDim.new(0, size400),
            PaddingRight = UDim.new(0, size400)
        })
    })
end

return MenuNavigationToggleDialog

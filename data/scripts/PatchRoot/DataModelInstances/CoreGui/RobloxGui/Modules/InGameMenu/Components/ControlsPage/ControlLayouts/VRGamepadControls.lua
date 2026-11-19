-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local UIBlox = InGameMenuDependencies.UIBlox

local InGameMenu = script:FindFirstAncestor("InGameMenu")
local Array = require(CorePackages.Packages.LuauPolyfill).Array

local ControlLayoutContainer = require(script.Parent.Parent.ControlLayoutContainer)
local ThemedTextLabel = require(InGameMenu.Components.ThemedTextLabel)

local Assets = require(InGameMenu.Resources.Assets)
local Controls = require(InGameMenu.Resources.Controls)
local React = require(CorePackages.Packages.React)

local withLocalization = require(InGameMenu.Localization.withLocalization)

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local Image = require(CorePackages.Packages.Foundation).Image
local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation

local tbl1 = {
    ResetCameraLabel = "CoreScripts.InGameMenu.Controls.ResetCameraLabel",
    MenuLabel = "CoreScripts.InGameMenu.Controls.MenuLabel",
    SelectItemLabel = "CoreScripts.InGameMenu.Controls.SelectItemLabel",
    BackExitLabel = "CoreScripts.InGameMenu.Controls.BackExitLabel",
    FirstPersonCameraLabel = "CoreScripts.InGameMenu.Controls.FirstPersonCameraLabel",
    JumpSelectLabel = "CoreScripts.InGameMenu.Controls.JumpSelectLabel"
}

local function GamepadControls(_)
    local createElement = Roact.createElement
    local var1 = ControlLayoutContainer
    local tbl2 = { titleText = "CoreScripts.InGameMenu.Controls.GamepadTitle" }

    local tbl3 = { GamepadImage = 0 }
    local createElement2 = Roact.createElement
    local var2 = if FFlagCoreUiMigrateUIBloxToFoundation then Image else ImageSetLabel
    local tbl4 = {
        BackgroundTransparency = if FFlagCoreUiMigrateUIBloxToFoundation then nil else 1,
        backgroundStyle = FFlagCoreUiMigrateUIBloxToFoundation and { Transparency = 1 } or nil,
        Image = Assets.Images.GamepadQuest,
        Size = UDim2.new(1, 0, 0.6, 0),
        Position = UDim2.new(0.5, 16.5, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
        testId = if FFlagCoreUiMigrateUIBloxToFoundation then "VRGamepadInstructions" else nil,
        [React.Tag] = if FFlagCoreUiMigrateUIBloxToFoundation then nil else "data-testid=VRGamepadInstructions"
    }

    tbl3.GamepadImage = createElement2(var2, tbl4, {
        Array.map(Controls.questGamepadLabels, function(arg1, layoutOrder)
            local var3 = tbl1[arg1.labelKey]

            return withLocalization({ var3 })(function(arg2)
                return Roact.createElement(ThemedTextLabel, {
                    key = arg1.labelKey,
                    fontKey = "Header2",
                    themeKey = "TextEmphasis",
                    TextXAlignment = arg1.xAlignment or Enum.TextXAlignment.Right,
                    Size = UDim2.new(arg1.width, 0, 0.026, 0),
                    Text = arg2[1],
                    LayoutOrder = layoutOrder,
                    Position = UDim2.new(arg1.xPosition, 0, arg1.yPosition, 0),
                    TextScaled = true
                })
            end)
        end)
    })

    return createElement(var1, tbl2, tbl3)
end

return GamepadControls

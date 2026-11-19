-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:20:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local UIBlox = InGameMenuDependencies.UIBlox

local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local ControlLayoutContainer = require(script.Parent.Parent.ControlLayoutContainer)
local ThemedTextLabel = require(scriptParentParentParentParent.Components.ThemedTextLabel)

local Assets = require(scriptParentParentParentParent.Resources.Assets)
local Controls = require(scriptParentParentParentParent.Resources.Controls)
local React = require(CorePackages.Packages.React)

local withLocalization = require(scriptParentParentParentParent.Localization.withLocalization)

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local Image = require(CorePackages.Packages.Foundation).Image
local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation

local yOffset = #Controls.gamepadLabels.right * 43 + 62

local function verticalControlsList(arg1)
    return withLocalization(arg1.controls)(function(arg2)
        local tbl1 = {
            ListLayout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 21) })
        }

        for layoutOrder, value in ipairs(arg2) do
            local var1 = "controlLabel_" .. layoutOrder
            tbl1[var1] = Roact.createElement(ThemedTextLabel, {
                fontKey = "Header2",
                themeKey = "TextEmphasis",
                TextXAlignment = arg1.TextXAlignment,
                Size = UDim2.new(0, 1, 0, 22),
                Text = value,
                LayoutOrder = layoutOrder
            })
        end

        return Roact.createElement(
            "Frame",
            {
                Position = arg1.Position,
                Size = UDim2.new(0, 0, 1, 0),
                BackgroundTransparency = 1
            },
            tbl1
        )
    end)
end

local function GamepadControls(arg1)
    local platform = UserInputService:GetPlatform()
    local bool1 = platform == Enum.Platform.XBox360 or platform == Enum.Platform.XBoxOne

    local createElement = Roact.createElement
    local var1 = ControlLayoutContainer
    local tbl1 = {
        titleText = "CoreScripts.InGameMenu.Controls.GamepadTitle",
        closeButtonRef = arg1.closeButtonRef
    }
    local tbl2 = {
        GamepadImage = Roact.createElement(if FFlagCoreUiMigrateUIBloxToFoundation then Image else ImageSetLabel, {
            BackgroundTransparency = if FFlagCoreUiMigrateUIBloxToFoundation then nil else 1,
            backgroundStyle = FFlagCoreUiMigrateUIBloxToFoundation and { Transparency = 1 } or nil,
            Image = bool1 and Assets.Images.GamepadXbox or Assets.Images.Gamepad,
            Size = UDim2.new(0, 473, 0, 465),
            Position = UDim2.new(0.5, 16.5, 0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            testId = if FFlagCoreUiMigrateUIBloxToFoundation then "GamepadInstructions" else nil,
            [React.Tag] = if FFlagCoreUiMigrateUIBloxToFoundation then nil else "data-testid=GamepadInstructions"
        }, {
            LeftControlsList = Roact.createElement(verticalControlsList, {
                TextXAlignment = Enum.TextXAlignment.Right,
                Position = UDim2.new(0, -26, 0, 62),
                controls = Controls.gamepadLabels.left
            }),
            RightControlsList = Roact.createElement(verticalControlsList, {
                TextXAlignment = Enum.TextXAlignment.Left,
                Position = UDim2.new(1, -7, 0, 62),
                controls = Controls.gamepadLabels.right
            }),
            RightIconsControlslIst = Roact.createElement(verticalControlsList, {
                TextXAlignment = Enum.TextXAlignment.Left,
                Position = UDim2.new(1, 26, 0, yOffset),
                controls = Controls.gamepadLabels.camera
            })
        })
    }
    return createElement(var1, tbl1, tbl2)
end

return GamepadControls

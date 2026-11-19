-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GameSettings = UserSettings().GameSettings

local LuauPolyfill = require(CorePackages.Packages.LuauPolyfill)

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = require(CorePackages.Packages.Roact)
local t = InGameMenuDependencies.t
local UIBlox = InGameMenuDependencies.UIBlox

local scriptParentParentParent = script.Parent.Parent.Parent
local ThemedTextLabel = require(scriptParentParentParent.Components.ThemedTextLabel)

local VRSafetyBubbleModeChanged = GameSettings:GetPropertyChangedSignal("VRSafetyBubbleMode")
local ExternalEventConnection = require(scriptParentParentParent.Utility.ExternalEventConnection)

local InputLabel = require(script.Parent.InputLabel)
local RadioButtonList = UIBlox.App.InputButton.RadioButtonList
local withLocalization = require(scriptParentParentParent.Localization.withLocalization)

local SendAnalytics = require(scriptParentParentParent.Utility.SendAnalytics)
local Constants = require(scriptParentParentParent.Resources.Constants)

local var1 = require(scriptParentParentParent.Flags.FFlagFixSafetyBubbleWidth)()

local tbl1 = {
    Title = "CoreScripts.InGameMenu.GameSettings.SafetyBubbleModeTitle",
    Description = "CoreScripts.InGameMenu.GameSettings.SafetyBubbleModeDescription",
    ["Enum.VRSafetyBubbleMode.NoOne"] = "CoreScripts.InGameMenu.GameSettings.SafetyBubbleModeNoOne",
    ["Enum.VRSafetyBubbleMode.OnlyFriends"] = "CoreScripts.InGameMenu.GameSettings.SafetyBubbleModeOnlyFriends",
    ["Enum.VRSafetyBubbleMode.Anyone"] = "CoreScripts.InGameMenu.GameSettings.SafetyBubbleModeAnyone"
}

local enumItems = Enum.VRSafetyBubbleMode:GetEnumItems()
local function getSafetyBubbleModeIndex(vrSafetyBubbleMode) -- Luacid: Inlined by compiler; 2 call sites recovered
    return LuauPolyfill.Array.indexOf(enumItems, vrSafetyBubbleMode)
end

local function setSafetyBubbleModeByIndex(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local vrSafetyBubbleMode = enumItems[arg1]
    GameSettings.VRSafetyBubbleMode = vrSafetyBubbleMode
    SendAnalytics(
        Constants.AnalyticsSettingsChangeName,
        Constants.AnalyticsSettingsSafetyBubbleModeChangeName,
        {
            mode = tostring(vrSafetyBubbleMode)
        }
    )
end
local var2 = Roact.PureComponent:extend("SafetyBubbleModeEntry")
var2.validateProps = t.strictInterface({ LayoutOrder = t.optional(t.integer) })

function var2.init(arg1)
    arg1:setState({ selectedMode = getSafetyBubbleModeIndex(GameSettings.VRSafetyBubbleMode) })
end

function var2.render(arg1)
    return withLocalization(tbl1)(function(arg2)
        local createFragment = Roact.createFragment

        local tbl2 = {
            VRSafetyBubbleModeListener = Roact.createElement(ExternalEventConnection, {
                event = VRSafetyBubbleModeChanged,
                callback = function()
                    arg1:setState({ selectedMode = getSafetyBubbleModeIndex(GameSettings.VRSafetyBubbleMode) })
                end
            }),
            SafetyBubbleModeEntrySelector = 0
        }

        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl3 = {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            LayoutOrder = arg1.props.LayoutOrder,
            ZIndex = 2
        }
        local tbl4 = {
            Padding = Roact.createElement("UIPadding", {
                PaddingLeft = UDim.new(0, 24),
                PaddingRight = UDim.new(0, 24),
                PaddingBottom = UDim.new(0, 15),
                PaddingTop = UDim.new(0, 15)
            }),
            ListLayout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 20)
            }),
            InputLabel = Roact.createElement(InputLabel, {
                localizationKey = tbl1.Title,
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, 0),
                AnchorPoint = Vector2.new(0, 0),
                LayoutOrder = 1
            }),
            InputDescription = Roact.createElement(ThemedTextLabel, {
                themeKey = "TextDefault",
                fontKey = "CaptionHeader",
                Text = arg2.Description,
                Size = UDim2.new(0.9, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                TextWrapped = true,
                LayoutOrder = 2,
                TextXAlignment = Enum.TextXAlignment.Left
            }),
            RadioList = Roact.createElement(RadioButtonList, {
                layoutOrder = 3,
                radioButtons = LuauPolyfill.Array.map(enumItems, function(arg3, _)
                    return {
                        label = arg2[tostring(arg3)]
                    }
                end),
                onActivated = function(arg3)
                    setSafetyBubbleModeByIndex(arg3)
                end,
                currentValue = arg1.state.selectedMode,
                automaticSize = true,
                padding = UDim.new(0, 20),
                elementSize = if var1 then UDim2.new(1, 0, 0, 20) else UDim2.new(0, 0, 0, 20)
            })
        }

        tbl2.SafetyBubbleModeEntrySelector = createElement(str1, tbl3, tbl4)
        return createFragment(tbl2)
    end)
end

return var2

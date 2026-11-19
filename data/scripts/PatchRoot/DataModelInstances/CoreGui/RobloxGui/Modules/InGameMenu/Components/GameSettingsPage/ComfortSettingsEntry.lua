-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GameSettings = UserSettings().GameSettings

local LuauPolyfill = require(CorePackages.Packages.LuauPolyfill)

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = require(CorePackages.Packages.Roact)
local t = InGameMenuDependencies.t
local SegmentedControl = InGameMenuDependencies.UIBlox.App.Control.SegmentedControl

local scriptParentParentParent = script.Parent.Parent.Parent
local ThemedTextLabel = require(scriptParentParentParent.Components.ThemedTextLabel)

local VRComfortSettingChanged = GameSettings:GetPropertyChangedSignal("VRComfortSetting")
local ExternalEventConnection = require(scriptParentParentParent.Utility.ExternalEventConnection)

local withLocalization = require(scriptParentParentParent.Localization.withLocalization)

local SendAnalytics = require(scriptParentParentParent.Utility.SendAnalytics)
local Constants = require(scriptParentParentParent.Resources.Constants)

local tbl1 = {
    Description = "CoreScripts.InGameMenu.GameSettings.ComfortSettingsDescription",
    ["Enum.VRComfortSetting.Comfort"] = "CoreScripts.InGameMenu.GameSettings.ComfortSettingComfort",
    ["Enum.VRComfortSetting.Normal"] = "CoreScripts.InGameMenu.GameSettings.ComfortSettingNormal",
    ["Enum.VRComfortSetting.Expert"] = "CoreScripts.InGameMenu.GameSettings.ComfortSettingExpert",
    ["Enum.VRComfortSetting.Custom"] = "CoreScripts.InGameMenu.GameSettings.ComfortSettingCustom"
}

local enumItems = Enum.VRComfortSetting:GetEnumItems()
local function getComfortSettingIndex(vrComfortSetting) -- Luacid: Inlined by compiler; 2 call sites recovered
    return LuauPolyfill.Array.indexOf(enumItems, vrComfortSetting)
end

local function setComfortSettingByIndex(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local vrComfortSetting = enumItems[arg1]
    GameSettings.VRComfortSetting = vrComfortSetting
    SendAnalytics(
        Constants.AnalyticsSettingsChangeName,
        Constants.AnalyticsSettingsVRComfortSettingChangeName,
        {
            mode = tostring(vrComfortSetting)
        }
    )
end
local var1 = Roact.PureComponent:extend("ComfortSettingsEntry")
var1.validateProps = t.strictInterface({ LayoutOrder = t.optional(t.integer) })

function var1.init(arg1)
    arg1:setState({ selectedMode = getComfortSettingIndex(GameSettings.VRComfortSetting) })
end

function var1.render(arg1)
    return withLocalization(tbl1)(function(arg2)
        return Roact.createFragment({
            VRComfortSettingListener = Roact.createElement(ExternalEventConnection, {
                event = VRComfortSettingChanged,
                callback = function()
                    arg1:setState({ selectedMode = getComfortSettingIndex(GameSettings.VRComfortSetting) })
                end
            }),
            ComfortSettingEntrySelector = Roact.createElement("Frame", {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                LayoutOrder = arg1.props.LayoutOrder,
                ZIndex = 2
            }, {
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
                InputDescription = Roact.createElement(ThemedTextLabel, {
                    themeKey = "TextDefault",
                    fontKey = "CaptionHeader",
                    Text = arg2.Description,
                    Size = UDim2.new(0.9, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    TextWrapped = true,
                    LayoutOrder = 1,
                    TextXAlignment = Enum.TextXAlignment.Left
                }),
                Frame = Roact.createElement(
                    "Frame",
                    {
                        Size = UDim2.new(1, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        BackgroundTransparency = 1,
                        LayoutOrder = 2
                    },
                    {
                        SegmentedControl = Roact.createElement(SegmentedControl, {
                            width = UDim.new(1, 0),
                            selectedTabIndex = arg1.state.selectedMode,
                            onTabActivated = function(arg3)
                                setComfortSettingByIndex(arg3)
                            end,
                            tabs = LuauPolyfill.Array.map(enumItems, function(arg3, _)
                                return {
                                    tabName = arg2[tostring(arg3)]
                                }
                            end)
                        })
                    }
                )
            })
        })
    end)
end
return var1

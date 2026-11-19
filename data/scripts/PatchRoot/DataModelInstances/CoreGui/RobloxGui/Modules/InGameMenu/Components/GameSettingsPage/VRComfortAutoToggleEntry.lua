-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t

local scriptParentParentParent = script.Parent.Parent.Parent

local ExternalEventConnection = require(scriptParentParentParent.Utility.ExternalEventConnection)

local ToggleEntry = require(script.Parent.ToggleEntry)

local SendAnalytics = require(scriptParentParentParent.Utility.SendAnalytics)
local Constants = require(scriptParentParentParent.Resources.Constants)

local VRComfortSettingChanged = UserGameSettings:GetPropertyChangedSignal("VRComfortSetting")

local var1 = Roact.PureComponent:extend("VRComfortAutoToggleEntry")
var1.validateProps = t.strictInterface({
    customValueKey = t.string,
    derivedValueKey = t.string,
    labelKey = t.string,
    LayoutOrder = t.integer,
    checkedValue = t.optional(t.any)
})

var1.defaultProps = { checkedValue = true }

function var1.init(arg1, arg2)
    arg1.derivedValueChangeEvent = UserGameSettings:GetPropertyChangedSignal(arg2.derivedValueKey)

    arg1:setState({
        checked = UserGameSettings[arg2.derivedValueKey] == arg2.checkedValue,
        vrComfortSetting = UserGameSettings.VRComfortSetting
    })

    function arg1.onExternalChange()
        local userGameSetting = UserGameSettings[arg2.derivedValueKey]
        arg1:setState({ checked = userGameSetting == arg2.checkedValue })
    end

    function arg1.onToggled()
        if arg1.state.vrComfortSetting ~= Enum.VRComfortSetting.Custom then
            return
        end

        if UserGameSettings[arg2.customValueKey] == arg2.checkedValue then
            UserGameSettings[arg2.customValueKey] = not arg2.checkedValue
        else
            UserGameSettings[arg2.customValueKey] = arg2.checkedValue
        end
        SendAnalytics(Constants.AnalyticsSettingsChangeName, nil, {}, true)
    end
end

function var1.render(arg1)
    local props = arg1.props

    return Roact.createFragment({
        Toggle = Roact.createElement(ToggleEntry, {
            checked = arg1.state.checked,
            labelKey = props.labelKey,
            LayoutOrder = props.LayoutOrder,
            onToggled = arg1.onToggled,
            isDisabled = arg1.state.vrComfortSetting ~= Enum.VRComfortSetting.Custom
        }),
        DerivedValueListener = Roact.createElement(ExternalEventConnection, { event = arg1.derivedValueChangeEvent, callback = arg1.onExternalChange }),
        VRComfortSettingListener = Roact.createElement(ExternalEventConnection, {
            event = VRComfortSettingChanged,
            callback = function()
                arg1:setState({ vrComfortSetting = UserGameSettings.VRComfortSetting })
            end
        })
    })
end

return var1

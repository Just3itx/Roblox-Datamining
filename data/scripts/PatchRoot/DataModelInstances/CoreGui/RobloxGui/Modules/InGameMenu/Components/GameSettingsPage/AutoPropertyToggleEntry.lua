-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t

local scriptParentParentParent = script.Parent.Parent.Parent

local ExternalEventConnection = require(scriptParentParentParent.Utility.ExternalEventConnection)

local ToggleEntry = require(script.Parent.ToggleEntry)

local SendAnalytics = require(scriptParentParentParent.Utility.SendAnalytics)
local Constants = require(scriptParentParentParent.Resources.Constants)

local var1 = Roact.PureComponent:extend("AutoPropertyToggleEntry")
var1.validateProps = t.strictInterface({
    instance = t.Instance,
    valueKey = t.string,
    lockedToOff = t.optional(t.boolean),
    onValue = t.optional(t.any),
    offValue = t.optional(t.any),
    labelKey = t.string,
    LayoutOrder = t.integer,
    subtextEnabled = t.optional(t.boolean),
    subtextKey = t.optional(t.string)
})

var1.defaultProps = {
    onValue = true,
    offValue = false,
    lockedToOff = false,
    subtextEnabled = false,
    subtextKey = ""
}

function var1.init(arg1, arg2)
    local var2 = arg2.instance[arg2.valueKey]
    arg1.changeEvent = arg2.instance:GetPropertyChangedSignal(arg2.valueKey)

    arg1:setState({ checked = not arg2.lockedToOff and var2 == arg2.onValue })

    function arg1.onExternalChange()
        local var3 = arg2.instance[arg2.valueKey]
        arg1:setState({ checked = var3 == arg2.onValue })
    end

    function arg1.onToggled()
        if arg1.props.lockedToOff then
            return
        end

        if arg2.instance[arg2.valueKey] == arg2.onValue then
            arg2.instance[arg2.valueKey] = arg2.offValue
        else
            arg2.instance[arg2.valueKey] = arg2.onValue
        end

        SendAnalytics(Constants.AnalyticsSettingsChangeName, nil, {}, true)
    end
end

function var1.render(arg1)
    local props = arg1.props

    return Roact.createFragment({
        Toggle = Roact.createElement(ToggleEntry, {
            checked = arg1.state.checked,
            lockedToOff = props.lockedToOff,
            labelKey = props.labelKey,
            LayoutOrder = props.LayoutOrder,
            onToggled = arg1.onToggled,
            subtextEnabled = props.subtextEnabled,
            subtextKey = props.subtextKey
        }),
        Listener = Roact.createElement(ExternalEventConnection, { event = arg1.changeEvent, callback = arg1.onExternalChange })
    })
end

return var1

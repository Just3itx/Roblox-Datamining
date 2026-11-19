-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local scriptParentParentParent = script.Parent.Parent.Parent

local SetInspectMenuEnabled = require(scriptParentParentParent.Actions.SetInspectMenuEnabled)

local EventConnection = require(script.Parent.EventConnection)

local var1 = Roact.PureComponent:extend("GuiServiceConnector")

function var1.render(arg1)
    return Roact.createFragment({
        InspectMenuEnabledConnection = Roact.createElement(EventConnection, {
            event = GuiService.InspectMenuEnabledChangedSignal,
            callback = function(arg2)
                arg1.props.setInspectMenuEnabled(arg2)
            end
        })
    })
end

return RoactRodux.connect(nil, function(arg1) -- name: mapDispatchToProps
    return {
        setInspectMenuEnabled = function(arg2)
            return arg1(SetInspectMenuEnabled(arg2))
        end
    }
end)(var1)

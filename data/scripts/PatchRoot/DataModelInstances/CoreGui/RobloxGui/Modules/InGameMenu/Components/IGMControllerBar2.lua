-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)

local ControllerBar = InGameMenuDependencies.UIBlox.App.Bar.ControllerBar
local scriptParentParent = script.Parent.Parent
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t
local RoactRodux = InGameMenuDependencies.RoactRodux
local Constants = require(scriptParentParent.Resources.Constants)
local IncrementControllerBar = require(scriptParentParent.Actions.IncrementControllerBar)
local DecrementControllerBar = require(scriptParentParent.Actions.DecrementControllerBar)
local var1 = Roact.PureComponent:extend("IGMControllerBar2")

var1.validateProps = t.strictInterface(
    {
        rightHints = t.table,
        leftHint = t.table,
        incrementControllerBar = t.callback,
        decrementControllerBar = t.callback
    }
)
function var1.init(arg1)
    arg1.props.incrementControllerBar()
end

function var1.willUnmount(arg1)
    arg1.props.decrementControllerBar()
end

function var1.render(arg1)
    return Roact.createElement(Roact.Portal, { target = CoreGui }, {
        IGMControllerBar = Roact.createElement("ScreenGui", {
            DisplayOrder = Constants.DisplayOrder.ControllerBar
        }, {
            ControllerBar = Roact.createElement(ControllerBar, { rightHints = arg1.props.rightHints, leftHint = arg1.props.leftHint })
        })
    })
end

return RoactRodux.UNSTABLE_connect2(nil, function(callback)
    return {
        incrementControllerBar = function()
            callback(IncrementControllerBar())
        end,
        decrementControllerBar = function()
            callback(DecrementControllerBar())
        end
    }
end)(var1)

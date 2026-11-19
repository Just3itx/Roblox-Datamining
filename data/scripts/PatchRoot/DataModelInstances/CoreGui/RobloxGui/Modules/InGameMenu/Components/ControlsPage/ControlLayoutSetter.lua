-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local UserInputService = game:GetService("UserInputService")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux

local scriptParentParentParent = script.Parent.Parent.Parent

local Controls = require(scriptParentParentParent.Resources.Controls)

local SetControlLayout = require(scriptParentParentParent.Actions.SetControlLayout)

local var1 = Roact.PureComponent:extend("ControlLayoutSetter")

function var1.init(arg1)
    local var2 = Controls.inputToControlTypeMap[UserInputService:GetLastInputType()]
    if var2 then
        arg1.props.dispatchSetControlLayout(var2)
    end
end

function var1.render(_)
    return nil
end

function var1.didMount(arg1)
    arg1.inputChangedConnection = UserInputService.LastInputTypeChanged:Connect(function(lastInputType: Enum.UserInputType)
        local var2 = Controls.inputToControlTypeMap[lastInputType]
        if var2 then
            arg1.props.dispatchSetControlLayout(var2)
        end
    end)
end

function var1.willUnmount(arg1)
    if arg1.inputChangedConnection then
        arg1.inputChangedConnection:Disconnect()
    end
end

return RoactRodux.UNSTABLE_connect2(nil, function(callback)
    return {
        dispatchSetControlLayout = function(arg1)
            callback(SetControlLayout(arg1))
        end
    }
end)(var1)

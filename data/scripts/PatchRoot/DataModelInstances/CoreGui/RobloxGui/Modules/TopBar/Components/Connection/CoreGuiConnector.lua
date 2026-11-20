-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:00:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local StarterGui = game:GetService("StarterGui")

local Modules = RobloxGui.Modules
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)

local scriptParentParentParent = script.Parent.Parent.Parent

local UpdateCoreGuiEnabled = require(scriptParentParentParent.Actions.UpdateCoreGuiEnabled)

local EventConnection = require(scriptParentParentParent.Parent.Common.EventConnection)

local FFlagMountCoreGuiBackpack = require(Modules.Flags.FFlagMountCoreGuiBackpack)
if require(scriptParentParentParent.Flags.FFlagTopBarDeprecateCoreGuiRodux) then
    return nil
end

local FFlagTopBarSignalizeHealthBar = require(CorePackages.Workspace.Packages.CoreGuiCommon).Flags.FFlagTopBarSignalizeHealthBar

local var1 = Roact.PureComponent:extend("CoreGuiConnector")

var1.validateProps = t.strictInterface({ updateCoreGuiEnabled = t.callback })

function var1.didMount(arg1)
    local enumItems = Enum.CoreGuiType:GetEnumItems()
    for _, enumItem in ipairs(enumItems) do
        if (not FFlagMountCoreGuiBackpack or enumItem ~= Enum.CoreGuiType.Backpack)
            and (not FFlagTopBarSignalizeHealthBar or enumItem ~= Enum.CoreGuiType.Health)
            and enumItem ~= Enum.CoreGuiType.All
        then
            arg1.props.updateCoreGuiEnabled(enumItem, StarterGui:GetCoreGuiEnabled(enumItem))
        end
    end
end

function var1.render(arg1)
    return Roact.createFragment({
        CoreGuiChangedConnection = Roact.createElement(EventConnection, {
            event = StarterGui.CoreGuiChangedSignal,
            callback = function(coreGuiType, arg2)
                if not FFlagMountCoreGuiBackpack or coreGuiType ~= Enum.CoreGuiType.Backpack then
                    arg1.props.updateCoreGuiEnabled(coreGuiType, arg2)
                end
            end
        })
    })
end

return RoactRodux.UNSTABLE_connect2(nil, function(arg1) -- name: mapDispatchToProps
    return {
        updateCoreGuiEnabled = function(arg2, arg3)
            return arg1(UpdateCoreGuiEnabled(arg2, arg3))
        end
    }
end)(var1)

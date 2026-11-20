-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:00:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)

local scriptParentParentParent = script.Parent.Parent.Parent
if require(scriptParentParentParent.Flags.FFlagTopBarDeprecateDisplayOptionsRodux) then
    return nil
end

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local ChatSelector = require(RobloxGui.Modules.ChatSelector)
local FFlagEnableNewBackpack = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableNewBackpack
local BackpackScript = if FFlagEnableNewBackpack then nil else require(RobloxGui.Modules.BackpackScript)
local EmotesMenuMaster = require(RobloxGui.Modules.EmotesMenu.EmotesMenuMaster)
local PlayerListManager = require(RobloxGui.Modules.PlayerList.PlayerListManager)

local var1 = Roact.PureComponent:extend("CoreGuiCEnabledNotifieronnector")

var1.validateProps = t.strictInterface({ topBarEnabled = t.boolean })

function var1.notifyEnabled(arg1)
    PlayerListManager:SetTopBarEnabled(arg1.props.topBarEnabled)
    ChatSelector:TopbarEnabledChanged(arg1.props.topBarEnabled)
    if not FFlagEnableNewBackpack and BackpackScript then
        BackpackScript:TopbarEnabledChanged(arg1.props.topBarEnabled)
    end
    EmotesMenuMaster:setTopBarEnabled(arg1.props.topBarEnabled)
end

function var1.didMount(arg1)
    arg1:notifyEnabled()
end

function var1.render(_)
    return nil
end

function var1.didUpdate(arg1, arg2, _)
    if arg1.props.topBarEnabled ~= arg2.topBarEnabled then
        arg1:notifyEnabled()
    end
end

return RoactRodux.UNSTABLE_connect2(function(arg1) -- name: mapStateToProps
    return {
        topBarEnabled = arg1.displayOptions.topbarEnabled
    }
end, nil)(var1)

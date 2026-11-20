-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:00:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)

local scriptParentParentParent = script.Parent.Parent.Parent

local FFlagTopBarSignalizeHealthBar = require(CorePackages.Workspace.Packages.CoreGuiCommon).Flags.FFlagTopBarSignalizeHealthBar

local SetIsDead = require(scriptParentParentParent.Actions.SetIsDead)
local UpdateHealth = require(scriptParentParentParent.Actions.UpdateHealth)

local EventConnection = require(scriptParentParentParent.Parent.Common.EventConnection)

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    LocalPlayer = Players.LocalPlayer
end

local var1 = Roact.PureComponent:extend("HealthConnector")

var1.validateProps = t.strictInterface({ setIsDead = t.callback, updateHealth = t.callback })

function var1.init(arg1)
    arg1:setState({ character = nil, humanoid = nil })
end

function var1.didMount(arg1)
    local character = LocalPlayer.Character
    local humanoid = if character then character:FindFirstChildOfClass("Humanoid") else nil
    arg1:setState({ character = character, humanoid = humanoid })
end

function var1.render(arg1)
    local tbl1 = ({})

    if arg1.state.humanoid then
        tbl1.HealthChangedConnection = Roact.createElement(EventConnection, {
            event = arg1.state.humanoid.HealthChanged,
            callback = function(_)
                arg1.props.updateHealth(arg1.state.humanoid.Health, arg1.state.humanoid.MaxHealth)
            end
        })

        tbl1.HumanoidDiedConnection = Roact.createElement(EventConnection, {
            event = arg1.state.humanoid.Died,
            callback = function()
                arg1.props.setIsDead(true)
            end
        })
    elseif arg1.state.character then
        tbl1.ChildAddedConnection = Roact.createElement(EventConnection, {
            event = arg1.state.character.ChildAdded,
            callback = function(humanoid)
                if humanoid:IsA("Humanoid") then
                    arg1:setState({ humanoid = humanoid })
                end
            end
        })
    end

    tbl1.CharacterAddedConnection = Roact.createElement(EventConnection, {
        event = LocalPlayer.CharacterAdded,
        callback = function(character)
            arg1:setState({ humanoid = character:FindFirstChildOfClass("Humanoid") or Roact.None, character = character })

            arg1.props.setIsDead(false)
        end
    })

    tbl1.CharacterRemovingConnection = Roact.createElement(EventConnection, {
        event = LocalPlayer.CharacterRemoving,
        callback = function()
            arg1:setState({ humanoid = Roact.None, character = Roact.None })
        end
    })

    return Roact.createFragment(tbl1)
end

function var1.didUpdate(arg1, _, arg2)
    if arg1.state.humanoid == nil then
        arg1.props.updateHealth(0, 0)
    elseif arg1.state.humanoid ~= arg2.humanoid then
        arg1.props.setIsDead(false)
        arg1.props.updateHealth(arg1.state.humanoid.Health, arg1.state.humanoid.MaxHealth)
    end

    if not arg1.state.character or arg1.state.character == arg2.character then
        return
    end

    local humanoid = arg1.state.character:FindFirstChildWhichIsA("Humanoid")
    if humanoid and humanoid ~= arg1.state.humanoid then
        arg1:setState({ humanoid = humanoid })
    end
end

local function mapDispatchToProps(arg1)
    return {
        setIsDead = function(arg2)
            return arg1(SetIsDead(arg2))
        end,
        updateHealth = function(arg2, arg3)
            return arg1(UpdateHealth(arg2, arg3))
        end
    }
end

return if FFlagTopBarSignalizeHealthBar then nil else RoactRodux.UNSTABLE_connect2(nil, mapDispatchToProps)(var1)

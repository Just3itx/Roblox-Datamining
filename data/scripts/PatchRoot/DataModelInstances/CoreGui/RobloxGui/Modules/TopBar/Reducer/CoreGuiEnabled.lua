-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local Rodux = require(CorePackages.Packages.Rodux)
local Cryo = require(CorePackages.Packages.Cryo)

local scriptParentParent = script.Parent.Parent

if require(scriptParentParent.Flags.FFlagTopBarDeprecateCoreGuiRodux) then
    return nil
end

local Actions = scriptParentParent.Actions
local UpdateCoreGuiEnabled = require(Actions.UpdateCoreGuiEnabled)
local tbl1

if require(RobloxGui.Modules.Flags.FFlagMountCoreGuiBackpack) then
    tbl1 = {
        [Enum.CoreGuiType.PlayerList] = true,
        [Enum.CoreGuiType.Health] = true,
        [Enum.CoreGuiType.Chat] = true,
        [Enum.CoreGuiType.EmotesMenu] = true
    }
else
    tbl1 = {
        [Enum.CoreGuiType.PlayerList] = true,
        [Enum.CoreGuiType.Health] = true,
        [Enum.CoreGuiType.Backpack] = true,
        [Enum.CoreGuiType.Chat] = true,
        [Enum.CoreGuiType.EmotesMenu] = true
    }
end

local createReducer = Rodux.createReducer
local tbl2 = {}
tbl2[UpdateCoreGuiEnabled.name] = function(arg1, arg2)
    if arg2.coreGuiType ~= Enum.CoreGuiType.All then
        return Cryo.Dictionary.join(arg1, { [arg2.coreGuiType] = arg2.enabled })
    end

    local result = ({})
    for k, _ in pairs(arg1) do
        result[k] = arg2.enabled
    end
    return result
end

return (createReducer(tbl1, tbl2))

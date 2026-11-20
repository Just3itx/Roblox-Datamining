-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:11:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)
local Cryo = require(CorePackages.Packages.Cryo)

local scriptParentParent = script.Parent.Parent
if require(scriptParentParent.Flags.FFlagTopBarDeprecateMoreMenuRodux) then
    return nil
end

local Actions = script.Parent.Parent.Actions
local SetMoreMenuOpen = require(Actions.SetMoreMenuOpen)
local SetBackpackOpen = require(Actions.SetBackpackOpen)
local SetEmotesOpen = require(Actions.SetEmotesOpen)
local SetLeaderboardOpen = require(Actions.SetLeaderboardOpen)
local SetEmotesEnabled = require(Actions.SetEmotesEnabled)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[SetMoreMenuOpen.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { open = arg2.open })
end

tbl1[SetBackpackOpen.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { open = false, backpackOpen = arg2.open })
end

tbl1[SetEmotesOpen.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { open = false, emotesOpen = arg2.open })
end

tbl1[SetEmotesEnabled.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { emotesEnabled = arg2.enabled })
end

tbl1[SetLeaderboardOpen.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { open = false, leaderboardOpen = arg2.open })
end

return (createReducer(
    {
        open = false,
        backpackOpen = false,
        leaderboardOpen = false,
        emotesOpen = false,
        emotesEnabled = true
    },
    tbl1
))

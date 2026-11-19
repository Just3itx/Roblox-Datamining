-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Cryo = InGameMenuDependencies.Cryo
local Rodux = InGameMenuDependencies.Rodux

local scriptParentParent = script.Parent.Parent

local SetRespawning = require(scriptParentParent.Actions.SetRespawning)
local SetRespawnBehavior = require(scriptParentParent.Actions.SetRespawnBehavior)
local SetMenuOpen = require(scriptParentParent.Actions.SetMenuOpen)
local SetCurrentPage = require(scriptParentParent.Actions.SetCurrentPage)

local createReducer = Rodux.createReducer

local tbl1 = {}
tbl1[SetRespawning.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { dialogOpen = arg2.respawning })
end

tbl1[SetMenuOpen.name] = function(arg1, arg2)
    if not arg2.menuOpen then
        return Cryo.Dictionary.join(arg1, { dialogOpen = false })
    end

    return arg1
end

tbl1[SetCurrentPage.name] = function(arg1, _)
    return Cryo.Dictionary.join(arg1, { dialogOpen = false })
end

tbl1[SetRespawnBehavior.name] = function(arg1, arg2)
    local dialogOpen = arg1.dialogOpen

    if not arg2.respawnEnabled then
        dialogOpen = false
    end

    return {
        customCallback = arg2.customCallback,
        enabled = arg2.respawnEnabled,
        dialogOpen = dialogOpen
    }
end

return createReducer({ dialogOpen = false, enabled = true, customCallback = nil }, tbl1)

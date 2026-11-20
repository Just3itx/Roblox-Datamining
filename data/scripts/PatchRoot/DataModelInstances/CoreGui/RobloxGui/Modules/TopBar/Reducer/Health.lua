-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)

local Actions = script.Parent.Parent.Actions
local UpdateHealth = require(Actions.UpdateHealth)
local SetIsDead = require(Actions.SetIsDead)

if require(CorePackages.Workspace.Packages.CoreGuiCommon).Flags.FFlagTopBarSignalizeHealthBar then
    return nil
end

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[UpdateHealth.name] = function(arg1, arg2)
    return {
        isDead = arg1.isDead,
        currentHealth = arg2.health,
        maxHealth = arg2.maxHealth
    }
end

tbl1[SetIsDead.name] = function(arg1, arg2)
    return {
        isDead = arg2.isDead,
        currentHealth = arg1.currentHealth,
        maxHealth = arg1.maxHealth
    }
end

return (createReducer({ isDead = false, currentHealth = 100, maxHealth = 100 }, tbl1))

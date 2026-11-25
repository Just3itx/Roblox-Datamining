-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")

local AppStorageService = game:GetService("AppStorageService")

local Constants = require(SquadsCore.Common.Constants)
local RoduxSquads = require(SquadsCore.RoduxSquads)

return function()
    AppStorageService:SetItem(Constants.ACTIVE_SQUAD_APP_STORAGE_KEY, "")
    AppStorageService:Flush()

    RoduxSquads.PersistManagers.currentSquadPersistManager.reset()
end

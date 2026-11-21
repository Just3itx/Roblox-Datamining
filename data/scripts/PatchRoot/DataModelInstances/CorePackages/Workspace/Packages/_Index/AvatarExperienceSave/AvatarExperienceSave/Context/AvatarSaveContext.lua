-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSave = script:FindFirstAncestor("AvatarExperienceSave")
local AvatarExperienceSaveParent = AvatarExperienceSave.Parent

local React = require(AvatarExperienceSaveParent.React)
local Signals = require(AvatarExperienceSaveParent.Signals)

local SaveStatusEnum = require(AvatarExperienceSave.Enums.SaveStatusEnum)

if not game:DefineFastFlag("FFlagAXFixAvatarSaveContext", false) then
    return (React.createContext(nil))
end

return (React.createContext({
    getHistorySignal = Signals.createSignal({}),
    getCurrentHistoryIndexSignal = Signals.createSignal(0),
    updateHistoryIndexAndGetCharacterData = function(_: number)
        return nil
    end,
    getLastSuccessfullySavedStateSignal = Signals.createSignal({}),
    getSaveEligibilityStatusSignal = Signals.createSignal(SaveStatusEnum.AlreadySaved),
    autoSaveNextNewSaveData = function(_: number?)
        return nil
    end,
    trySaveAvatar = function()
        return nil
    end
}))

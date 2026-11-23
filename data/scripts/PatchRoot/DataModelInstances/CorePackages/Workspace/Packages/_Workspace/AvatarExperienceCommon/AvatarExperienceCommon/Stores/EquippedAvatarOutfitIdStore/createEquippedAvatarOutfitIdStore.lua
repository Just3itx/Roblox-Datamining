-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent

local _Signals = require(AvatarExperienceCommonParent.Signals)
local createSessionScopedSignal = require(AvatarExperienceCommonParent.SignalsUtils).createSessionScopedSignal

local getCurrentlyWearingSavedOutfitId = require(AvatarExperienceCommon.Requests.getCurrentlyWearingSavedOutfitId)

local function createEquippedAvatarOutfitIdStore()
    local getLastEquippedAvatarOutfitId, setLastEquippedAvatarOutfitId = createSessionScopedSignal(nil)
    local num1 = 0

    local function commitOutfitId(str1: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
        if getLastEquippedAvatarOutfitId(false) == nil then
            setLastEquippedAvatarOutfitId(str1 or "")
        end
    end

    local function commitOutfitIdIfCurrent(num2: number, str1: string?) -- Luacid: Inlined by compiler; 1 call site recovered
        if num2 == num1 then
            commitOutfitId(str1)
        end
    end

    return {
        getLastEquippedAvatarOutfitId = getLastEquippedAvatarOutfitId,
        setLastEquippedAvatarOutfitId = setLastEquippedAvatarOutfitId,
        fetchCurrentlyWearingSavedOutfitId = function()
            if getLastEquippedAvatarOutfitId(false) ~= nil then
                return
            end

            num1 += 1
            local num2 = num1
            getCurrentlyWearingSavedOutfitId():andThen(function(str1: string?)
                commitOutfitIdIfCurrent(num2, str1)
            end, function()
                if num2 == num1 and getLastEquippedAvatarOutfitId(false) == nil then
                    setLastEquippedAvatarOutfitId("")
                end
            end)
        end
    }
end

return createEquippedAvatarOutfitIdStore

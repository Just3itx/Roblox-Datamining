-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InteractionFeedbackParent = script:FindFirstAncestor("InteractionFeedback").Parent

local SoundManager = require(InteractionFeedbackParent.SoundManager)
local SoundManager2 = SoundManager.SoundManager
local Sounds = SoundManager.Sounds
local SoundGroups = SoundManager.SoundGroups

local _InteractionFeedbackContext = require(script.Parent.InteractionFeedbackContext)
local triggerHaptic = require(script.Parent.triggerHaptic)

SoundManager2.init()

local function triggerFeedback(str1: string, arg1, arg2, vec1: vector, num1: number, str2: string?, tbl1)
    if not arg2 then
        error("No config table was provided to InteractionFeedbackManager. Something is wrong.")
    end

    local var1 = arg2[str1]
    if not var1 then
        return
    end

    local var2 = var1[arg1]
    if not var2 then
        return
    end

    local sound = var2.Sound
    if sound then
        local sound2 = Sounds[sound]
        if not sound2 then
            error(
                "Sound " .. sound .. " not found in SoundManager given contextKey: " .. str1 .. " and interactionType: " .. tostring(arg1) .. ". Please check the Sounds.lua file."
            )
        end
        SoundManager2:PlaySound(sound2.Name, {}, SoundGroups.AppBackground)
    end

    local haptic = var2.Haptic
    if haptic then
        triggerHaptic(haptic, vec1, num1, str1, arg1, str2, tbl1)
    end
end

return triggerFeedback

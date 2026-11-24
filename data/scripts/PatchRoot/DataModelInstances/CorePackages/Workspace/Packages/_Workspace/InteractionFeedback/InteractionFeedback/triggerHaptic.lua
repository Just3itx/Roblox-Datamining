-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InteractionFeedbackParent = script:FindFirstAncestor("InteractionFeedback").Parent
local Cryo = require(InteractionFeedbackParent.Cryo)

local _InteractionFeedbackContext = require(script.Parent.InteractionFeedbackContext)
local sendHapticAnalytics = require(script.Parent.sendHapticAnalytics)

local tbl1 = ({})

local function triggerHaptic(type, position: vector, radius: number, contextKey: string?, interactionType, str1: string?, tbl2)
    if not tbl1[type] then
        tbl1[type] = Instance.new("HapticEffect")
        tbl1[type].Parent = workspace
        tbl1[type].Type = type
    end
    tbl1[type].Position = position
    tbl1[type].Radius = radius
    tbl1[type]:Play()

    if not str1 then
        return
    end

    local var1 = Cryo.Dictionary.join({ hapticType = type.Name, contextKey = contextKey, interactionType = interactionType }, tbl2 or {})

    sendHapticAnalytics(var1, str1)
end

return triggerHaptic

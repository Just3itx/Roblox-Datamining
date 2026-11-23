-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Signals = require(BuildExperienceParent.Signals)
local _chatTypes = require(BuildExperience.Chat.chatTypes)

local function targetsMatch(tbl1, universeId: number?, sessionId: string?): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl1.universeId == universeId and (tbl1.sessionId == nil or tbl1.sessionId == sessionId)
end

local function createBuildPromptDraftStore()
    local getPendingDraft, var2 = Signals.createSignal(nil)

    return {
        getPendingDraft = getPendingDraft,
        queueDraft = function(tbl1)
            var2(tbl1)
        end,
        consumeDraft = function(universeId: number?, sessionId: string?)
            local var3 = getPendingDraft()

            if var3 == nil or not targetsMatch(var3, universeId, sessionId) then
                return nil
            end
            var2(nil)
            return var3.text
        end,
        reset = function()
            var2(nil)
        end
    }
end
return createBuildPromptDraftStore

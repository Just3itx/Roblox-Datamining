-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:01:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local _Signals = require(BuildExperienceParent.Signals)
local createSessionScopedSignal = require(BuildExperienceParent.SignalsUtils).createSessionScopedSignal

local function createVersionInformationStore()
    local getDraft, var2 = createSessionScopedSignal(function()
        return nil
    end)

    return {
        getDraft = getDraft,
        setDraft = function(placeId: number, title: string, description: string) -- name: saveDraft
            var2({ placeId = placeId, title = title, description = description })
        end,
        clearDraft = function(placeId: number)
            local var3 = getDraft()
            if var3 ~= nil and var3.placeId == placeId then
                var2(nil)
            end
        end,
        reset = function()
            var2(nil)
        end
    }
end
return createVersionInformationStore

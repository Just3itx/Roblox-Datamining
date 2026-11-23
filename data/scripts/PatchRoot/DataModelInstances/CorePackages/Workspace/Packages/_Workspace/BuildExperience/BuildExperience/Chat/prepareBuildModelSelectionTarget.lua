-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")

local _chatTypes = require(BuildExperience.Chat.chatTypes)
local GetBuildModelSelectionStore = require(BuildExperience.Stores.GetBuildModelSelectionStore)

local function prepareBuildModelSelectionTarget(arg1)
    if arg1.isNewGameTarget ~= true or arg1.universeId ~= nil and arg1.universeId > 0 then
        return arg1
    end
    local buildModelSelectionStore = GetBuildModelSelectionStore(false)
    if arg1.modelSelectionDraftId ~= nil and buildModelSelectionStore.getDraft(arg1.modelSelectionDraftId) ~= nil then
        return arg1
    end
    local var1 = table.clone(arg1)
    var1.modelSelectionDraftId = buildModelSelectionStore.createDraft()
    return var1
end

return prepareBuildModelSelectionTarget

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent

local _SduiLoadTimer = require(SduiSharedUtilities.SduiLoadTimer)
local createTemplateApiPrewarmRequestConfig = require(SduiSharedUtilities.createTemplateApiPrewarmRequestConfig)
local getSduiApiStore = require(SduiSharedUtilities.getSduiApiStore)
local Promise = require(SduiSharedUtilitiesParent.Promise)

local function fetchSduiTemplates(tbl1, bool1: boolean?)
    local templateApiPrewarmRequestConfig = createTemplateApiPrewarmRequestConfig(tbl1)
    if templateApiPrewarmRequestConfig == nil then
        return Promise.reject("No valid SDUI surfaceKeys provided")
    end
    return getSduiApiStore().fetchIfNeeded(templateApiPrewarmRequestConfig, bool1)
end

return fetchSduiTemplates

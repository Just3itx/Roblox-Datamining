-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local _createBuildLibraryStore = require(BuildExperience.Stores.BuildLibrary.createBuildLibraryStore)
local _chatTypes = require(BuildExperience.Chat.chatTypes)
local clientDataModelCollector = require(BuildExperience.Chat.clientDataModelCollector)

local function toResourceUri(str1: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return "rbx-dm:" .. str1
end

return {
    toResourceUri = toResourceUri,
    toResourceAttachment = function(arg1)
        return {
            type = "resource_link",
            name = arg1.displayName,
            uri = toResourceUri(arg1.path),
            mimeType = "datamodel.instance/v1"
        }
    end,
    toChatResource = function(arg1)
        return {
            path = if arg1.instance ~= nil then clientDataModelCollector.getInstancePath(arg1.instance) else arg1.path,
            displayName = arg1.displayName,
            className = arg1.className
        }
    end
}

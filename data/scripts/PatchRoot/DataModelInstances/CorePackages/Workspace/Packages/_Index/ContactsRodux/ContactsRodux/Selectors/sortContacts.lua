-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local getDeepValue = require(scriptParentParentParent.LuaSocialLibrariesDeps).SocialLibraries.config({}).Dictionary.getDeepValue

return function(arg1)
    local keyPath = arg1.keyPath
    return function(arg2)
        local deepValue = getDeepValue(arg2, keyPath .. ".byContactId") or {}
        local result = {}
        for contactId, value in pairs(deepValue) do
            table.insert(result, {
                contactId = contactId,
                contactName = value.contactName,
                headshotThumbnailUrl = value.headshotThumbnailUrl,
                avatarThumbnailUrl = value.avatarThumbnailUrl
            })
        end

        table.sort(result, function(arg3, arg4): boolean
            if arg3.contactName and arg4.contactName and arg3.contactName ~= arg4.contactName then
                return arg3.contactName < arg4.contactName
            end

            return arg3.contactId < arg4.contactId
        end)

        return result
    end
end

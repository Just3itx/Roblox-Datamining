-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContactImporter = script:FindFirstAncestor("ContactImporter")
local dependencies = require(ContactImporter.dependencies)
local Dash = dependencies.Dash
local _LocalTypes = require(ContactImporter.Common.LocalTypes)
local getDeepValue = dependencies.SocialLibraries.Dictionary.getDeepValue

return function(arg1, arg2)
    local deepValue = getDeepValue(arg2 or {}, "hasSentRequest") or {}

    return Dash.map(arg1 or {}, function(arg3)
        return Dash.join(arg3, { hasSentRequest = deepValue[arg3.contactId], isMatchedContact = true })
    end)
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CompleteExternalNavigationIntoChat = require(script.Parent.Parent.Parent.Actions.CompleteExternalNavigationIntoChat)

return function(callback)
    return {
        completeExternalNavigation = function(arg1)
            callback(CompleteExternalNavigationIntoChat(arg1))
        end
    }
end

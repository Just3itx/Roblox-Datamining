-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _DataHydration = require(AppChatParent.DataHydration)
local React = require(AppChatParent.React)

local useProfileNames = require(AppChat.Hooks.useProfileNames)

local function useProfileName(str1: string?)
    local var1 = React.useMemo(function(): {[any]: any} | {string}
        return if str1 then { str1 } else {}
    end, { str1 })
    local var2 = useProfileNames(var1)

    return React.useMemo(function()
        local var3 = if str1 then var2.namesByUserId[str1] else nil
        return {
            status = var2.status,
            combinedName = if var3 then var3.combinedName else nil,
            username = if var3 then var3.username else nil
        }
    end, { var2, str1 })
end

return useProfileName

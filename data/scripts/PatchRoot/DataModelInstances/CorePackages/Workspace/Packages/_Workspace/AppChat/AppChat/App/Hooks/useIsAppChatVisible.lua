-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local AppChatVisible = require(AppChat.App.AppChatVisible)
local useExternalEvent = require(AppChatParent.RoactUtils).Hooks.useExternalEvent
local useState = React.useState
local useCallback = React.useCallback

local function useIsAppChatVisible(bool1: boolean?)
    local var1, var2 = useState(bool1 or false)

    useExternalEvent(AppChatVisible.BindableEvent.Event, function(bool2: boolean)
        if bool2 ~= var1 then
            var2(bool2)
        end
    end, { var1 })

    return var1, (useCallback(function()
        var2(false)
    end, { var2 }))
end

return useIsAppChatVisible

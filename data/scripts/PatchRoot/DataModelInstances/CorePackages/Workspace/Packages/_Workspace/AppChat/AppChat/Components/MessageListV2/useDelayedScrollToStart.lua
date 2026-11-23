-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local _ViewRecycler = require(AppChatParent.ViewRecycler)

local FIntAppChatOsaAutoScrollDelayMs = require(AppChat.Flags.FIntAppChatOsaAutoScrollDelayMs)

local function useDelayedScrollToStart(bool1: boolean, bool2: boolean, tbl1)
    local var1 = React.useRef(false)
    React.useEffect(function()
        if bool2 then
            var1.current = false
            return nil
        end
        if not bool1 or var1.current then
            return nil
        end
        var1.current = true
        local var2 = nil
        var2 = task.delay(FIntAppChatOsaAutoScrollDelayMs / 1000, function()
            var2 = nil
            local current = tbl1.current
            if current ~= nil then
                current.scrollToStart()
            end
        end)
        return function()
            if var2 ~= nil then
                task.cancel(var2)
                var2 = nil

                var1.current = false
            end
        end
    end, { bool1, bool2 })
end

return useDelayedScrollToStart

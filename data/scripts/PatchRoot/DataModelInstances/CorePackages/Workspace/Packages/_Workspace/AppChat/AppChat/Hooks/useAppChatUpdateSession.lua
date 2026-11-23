-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SessionService = game:GetService("SessionService")

local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)
local useEffect = React.useEffect
local useRef = React.useRef

local ChatSessionRefCount = require(script.Parent.ChatSessionRefCount)

return function(bool1: boolean?, arg1)
    if bool1 == nil then
        bool1 = true
    end

    local var1 = arg1 or SessionService

    local var2 = useRef(false)

    if bool1 then
        if not var2.current then
            ChatSessionRefCount.acquire(var1)
            var2.current = true
        end
    elseif var2.current then
        ChatSessionRefCount.release(var1)
        var2.current = false
    end

    useEffect(function()
        return function()
            if var2.current then
                ChatSessionRefCount.release(var1)
                var2.current = false
            end
        end
    end, {})
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)

local sampleMomentShareCardVideoFrame = require(script.Parent.sampleMomentShareCardVideoFrame)

local function useMomentShareCardVideoFrame(arg1)
    local var1, var2 = React.useState(function()
        return nil
    end)

    React.useEffect(function()
        var2(nil)
        if arg1 == nil then
            return
        end

        local bool1 = false
        task.spawn(function()
            local var3 = sampleMomentShareCardVideoFrame(arg1)
            if not bool1 and var3 ~= nil then
                var2(var3)
            end
        end)

        return function()
            bool1 = true
        end
    end, { arg1 })

    return var1
end

return useMomentShareCardVideoFrame

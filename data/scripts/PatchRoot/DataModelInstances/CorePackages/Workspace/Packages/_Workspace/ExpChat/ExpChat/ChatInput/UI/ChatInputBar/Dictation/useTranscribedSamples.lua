-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:00:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local React = require(ExpChatParent.React)

local function useTranscribedSamples()
    local binding, var2 = React.useBinding({})
    local var3 = React.useRef(nil)

    return {
        binding = binding,
        begin = function(num1: number)
            var3.current = var3.current or num1
        end,
        commit = function(endIdx: number)
            local current = var3.current
            var3.current = nil
            if current == nil or endIdx < current then
                return
            end
            local var4 = table.clone(binding:getValue())
            table.insert(var4, { startIdx = current, endIdx = endIdx })
            var2(var4)
        end,
        reset = function()
            var3.current = nil
            var2({})
        end
    }
end
return useTranscribedSamples

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _RegExp = require(scriptParentParent.RegExp)

local function matchAllRegex(input: string, arg1)
    local var1 = arg1:exec(input)
    if not var1 then
        return {}
    end

    local index = var1.index
    local matchedText = var1[1]
    local capturedGroups = {}
    if #var1 > 1 then
        for i = 2, #var1 do
            table.insert(capturedGroups, var1[i])
        end
    end

    local num1 = utf8.offset(input, index)
    local str1 = input:sub(num1 + #matchedText)
    return {
        { index = num1, input = input, matchedText = matchedText, capturedGroups = capturedGroups },
        unpack((matchAllRegex(str1, arg1)))
    }
end

return matchAllRegex

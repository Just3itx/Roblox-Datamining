-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)
local React = dependencies.React

local getTextBoundsAsync = dependencies.Foundation.Utility.getTextBoundsAsync

return function(str1: string, arg1, num1: number, num2: number?)
    local var1, var2 = React.useState(nil)

    React.useEffect(function()
        local bool1 = false
        task.spawn(function()
            local textBoundsAsync = getTextBoundsAsync(str1, arg1, num1, num2)
            if textBoundsAsync and not bool1 then
                var2(textBoundsAsync)
            end
        end)

        return function()
            bool1 = true
        end
    end, {
        str1,
        arg1,
        num1,
        num2
    })
    return var1
end

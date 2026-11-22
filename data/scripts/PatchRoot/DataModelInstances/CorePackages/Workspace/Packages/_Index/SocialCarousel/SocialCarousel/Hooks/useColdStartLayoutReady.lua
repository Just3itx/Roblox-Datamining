-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarouselParent = script:FindFirstAncestor("SocialCarousel").Parent
local React = require(SocialCarouselParent.React)

local function useColdStartLayoutReady(bool1: boolean, vector2: Vector2, num1: number, num2: number)
    local var1 = React.useRef(not bool1)
    local var2, var3 = React.useState(not var1.current)

    React.useEffect(function()
        if var2 or not var1.current then
            return
        end

        if not bool1 or vector2.X <= 1 or vector2.Y <= 1 or num1 <= 1 or num1 > vector2.X then
            return
        end

        local var4 = task.delay(0.5, function()
            var3(true)
        end)
        return function()
            pcall(task.cancel, var4)
        end
    end, {
        var2,
        bool1,
        vector2.X,
        vector2.Y,
        num1,
        num2
    })
    return var2
end

return useColdStartLayoutReady

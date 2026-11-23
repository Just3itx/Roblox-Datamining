-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent

local React = require(AppBloxParent.React)
local ReactOtter = require(AppBloxParent.ReactOtter)

local function useAnimateFullscreen(bool1: boolean, func1: (...any) -> (...any), arg1)
    local bool2 = func1 ~= nil
    local var1 = bool1 and bool2 and 0 or 1
    local var2, var3 = React.useState(var1)

    local var4, var5 = React.useState(false)
    local var6 = React.useCallback(function()
        var5(false)
    end, {})

    local var7, var8 = ReactOtter.useAnimatedBinding(var1, var6)

    React.useEffect(function()
        if var1 ~= var2 then
            var3(var1)
            var5(true)
            var8(ReactOtter.spring(var1, arg1))
        end

        return nil
    end, { var1, var2, arg1 })

    if not var4 then
        bool2 = bool1 and bool2
    end
    return bool2, var7
end

return useAnimateFullscreen

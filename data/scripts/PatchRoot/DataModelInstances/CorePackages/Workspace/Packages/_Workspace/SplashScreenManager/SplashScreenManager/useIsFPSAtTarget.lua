-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplashScreenManagerParent = script:FindFirstAncestor("SplashScreenManager").Parent
local React = require(SplashScreenManagerParent.React)
local SplashScreenManager = require(script.Parent.SplashScreenManager)

local function useIsFPSAtTarget()
    local var1, var2 = React.useState(SplashScreenManager.isFPSAtTarget())
    local var3 = React.useCallback(function(arg1)
        var2(arg1)
    end, { var2 })

    React.useEffect(function()
        SplashScreenManager.addStatusChangeListener(var3)
        return function()
            SplashScreenManager.removeStatusChangeListener(var3)
        end
    end, {})

    return var1
end

return useIsFPSAtTarget

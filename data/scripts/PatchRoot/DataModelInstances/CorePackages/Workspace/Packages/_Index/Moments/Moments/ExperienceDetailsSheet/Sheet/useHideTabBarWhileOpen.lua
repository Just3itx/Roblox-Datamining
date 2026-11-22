-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)
local AppTabBarRodux = require(MomentsParent.AppTabBarRodux)
local useDispatch = require(MomentsParent.RoactUtils).Hooks.RoactRodux.useDispatch

local SetTabBarVisible = AppTabBarRodux.Actions.SetTabBarVisible

local function useHideTabBarWhileOpen(bool1: boolean)
    local var1 = useDispatch()

    React.useEffect(function()
        if bool1 then
            var1(SetTabBarVisible(false))
        end

        return function()
            if bool1 then
                var1(SetTabBarVisible(true))
            end
        end
    end, { bool1, var1 })
end

return useHideTabBarWhileOpen

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:20:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Otter = require(FoundationParent.Otter)
local React = require(FoundationParent.React)
local useAnimatedBinding = require(FoundationParent.ReactOtter).useAnimatedBinding

local usePreferences = require(Foundation.Providers.Preferences.usePreferences)
local useTokens = require(Foundation.Providers.Style.useTokens)

local function useOverlayTransition(tbl1)
    local var1 = useTokens()
    local reducedMotion = usePreferences().reducedMotion
    local isOpen = tbl1.isOpen
    local onExited = tbl1.onExited

    local var2, var3 = React.useState(isOpen)

    local isAnimating, var5 = React.useState(isOpen)
    local num1 = if isOpen then 1 else 0

    local progress, var7 = useAnimatedBinding(0, function(num2: number)
        var5(false)
        if num2 ~= 0 or isOpen or not var2 then
            return
        end

        var3(false)
        if onExited then
            onExited()
        end
    end)

    React.useEffect(function()
        if isOpen then
            var3(true)
        end

        if reducedMotion then
            var7((Otter.instant(num1)))
            return
        end
        var5(progress:getValue() ~= num1)
        var7(
            Otter.ease(num1, {
                easingStyle = if isOpen then var1.Ease.StandardOut else var1.Ease.StandardIn,
                duration = if isOpen then var1.Time.Time_300 else var1.Time.Time_200
            })
        )
    end, {
        isOpen,
        num1,
        reducedMotion,
        var1,
        progress,
        var7
    })
    return {
        isMounted = isOpen or var2,
        isAnimating = isAnimating,
        progress = progress
    }
end

return useOverlayTransition

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)
local ReactOtter = require(MomentsParent.ReactOtter)

local CommentLongPressTiming = require(script.Parent.CommentLongPressTiming)

local useTokens = Foundation.Hooks.useTokens

local tbl1 = {
    duration = 0.08,
    easingStyle = Enum.EasingStyle.Quad
}
local tbl2 = {
    duration = 0.15,
    easingStyle = Enum.EasingStyle.Quad
}

return React.memo(function(tbl3) -- name: CommentRowHighlight
    local var1 = useTokens()
    local var2, var3 = ReactOtter.useAnimatedBinding(0)
    React.useEffect(function()
        if tbl3.phase ~= "Charging" then
            var3(ReactOtter.ease(if tbl3.phase == "Active" then 1 else 0, if tbl3.phase == "Active" then tbl1 else tbl2))

            return nil
        end

        local var4 = task.delay(CommentLongPressTiming.CHARGE_DELAY_SECONDS, function()
            var3(
                ReactOtter.ease(1, {
                    duration = CommentLongPressTiming.HOLD_SECONDS - CommentLongPressTiming.CHARGE_DELAY_SECONDS,
                    easingStyle = Enum.EasingStyle.Sine
                })
            )
        end)

        return function()
            task.cancel(var4)
        end
    end, { tbl3.phase })

    local shift200 = var1.Color.Shift.Shift_200
    local backgroundStyle = var2:map(function(num1: number)
        return {
            Color3 = shift200.Color3,
            Transparency = math.lerp(1, shift200.Transparency, num1)
        }
    end)

    return React.createElement(Foundation.View, {
        tag = {
            ["size-full radius-medium"] = true,
            ["shadow-raised-100"] = tbl3.phase == "Active"
        },
        backgroundStyle = backgroundStyle,
        ZIndex = 0,
        testId = `moments-comment-highlight-{tbl3.commentId}`
    })
end)

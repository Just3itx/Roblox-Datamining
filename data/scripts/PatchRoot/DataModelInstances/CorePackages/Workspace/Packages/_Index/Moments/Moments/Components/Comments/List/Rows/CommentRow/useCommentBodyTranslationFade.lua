-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local _Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)
local ReactOtter = require(MomentsParent.ReactOtter)

local FFlagMomentsCommentTranslation = require(Moments.Flags.FFlagMomentsCommentTranslation)
local _CommentRowTypes = require(script.Parent.Parent.CommentRowTypes)

local tbl1 = {
    duration = 0.15,
    easingStyle = Enum.EasingStyle.Quad
}

local function useCommentBodyTranslationFade(commentId: string, translationState: string, style)
    if not FFlagMomentsCommentTranslation then
        return style
    end

    local var1 = React.useRef(nil)

    local var2 = React.useCallback(function(num1: number)
        local current = var1.current
        if num1 >= 1 and current ~= nil then
            current((ReactOtter.ease(0, tbl1)))
        end
    end, {})
    local fade, current = ReactOtter.useAnimatedBinding(0, var2)
    var1.current = current

    local var5 = React.useRef({ commentId = commentId, translationState = translationState })
    React.useLayoutEffect(function()
        local current2 = var5.current
        var5.current = { commentId = commentId, translationState = translationState }
        if current2.commentId ~= commentId then
            current((ReactOtter.instant(0)))
        elseif current2.translationState ~= nil and translationState ~= nil and current2.translationState ~= translationState then
            current((ReactOtter.instant(1)))
        end
    end, { commentId, translationState })

    return React.useMemo(function()
        return React.joinBindings({ style = style, fade = fade }):map(function(arg2)
            local style = arg2.style
            local styleTransparency = style.Transparency or 0
            return {
                Color3 = style.Color3,
                Transparency = styleTransparency + (1 - styleTransparency) * arg2.fade
            }
        end)
    end, { style, fade })
end

return useCommentBodyTranslationFade

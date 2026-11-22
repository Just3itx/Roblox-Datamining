-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local ReactOtter = require(MomentsParent.ReactOtter)
local Signals = require(MomentsParent.Signals)
local SignalsReact = require(MomentsParent.SignalsReact)

local getCommentsSheetStore = require(Moments.Components.Comments.Sheet.getCommentsSheetStore)
local tbl1 = {
    duration = require(script.Parent.MomentContext).SCRUB_FADE_SECONDS,
    easingStyle = Enum.EasingStyle.Quad
}

local function useCommentsChromeTransparency(str1: string?)
    local var1 = React.useMemo(function()
        local commentsSheetStore = getCommentsSheetStore(false)
        return Signals.createComputed(function(arg1)
            return not (str1 == nil) and commentsSheetStore.getIsOpen(arg1) and commentsSheetStore.getFeedItemId(arg1) == str1
        end)
    end, { str1 or false })
    local var2 = SignalsReact.useSignalState(var1)

    local var3, var4 = React.useState(var2)
    local var5 = React.useCallback(function(num1: number)
        if num1 <= 0 then
            var4(false)
        end
    end, {})
    local var6, var7 = ReactOtter.useAnimatedBinding(if var2 then 1 else 0, var5)

    React.useEffect(function()
        if var2 then
            var4(true)
        end
        var7(ReactOtter.ease(if var2 then 1 else 0, tbl1))
    end, { var2 })

    return if var2 or var3 then var6 else nil
end

return useCommentsChromeTransparency

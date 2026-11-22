-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProgressLoadingParent = script:FindFirstAncestor("ProgressLoading").Parent

local React = require(ProgressLoadingParent.React)
local Motion = require(ProgressLoadingParent.Motion)

local Foundation = require(ProgressLoadingParent.Foundation)
local View = Foundation.View
local Progress = Foundation.Progress
local ProgressShape = Foundation.Enums.ProgressShape
local useTokens = Foundation.Hooks.useTokens

local computeSpan = require(script.Parent.computeSpan)
local Constants = require(script.Parent.Constants)

local tbl1 = {
    visible = Motion.createState({ groupTransparency = 0, barScale = 1 }),
    hidden = Motion.createState({ groupTransparency = 1, barScale = 0 }, { default = Motion.transition({ duration = 0.1 }) })
}

return React.memo(function(tbl2) -- name: ProgressLoadingAssets
    local scale = useTokens().Config.UI.Scale

    local var1, var2 = Motion.useMotion(tbl1.visible)

    React.useEffect(function()
        local bool1 = false
        if tbl2.isVisible == false then
            var2(tbl1.hidden, {
                onAnimationComplete = function(arg1)
                    if not bool1 and arg1 == true and tbl2.onHideComplete then
                        tbl2.onHideComplete()
                    end
                end
            })
        else
            var2(tbl1.visible)
        end
        return function()
            bool1 = true
        end
    end, { tbl2.isVisible, tbl2.onHideComplete })

    local var3, var4 = React.useBinding(0)
    local width = var3:map(function(arg1)
        return computeSpan(arg1, scale, Constants.PROGRESS_BAR_MARGIN, Constants.PROGRESS_BAR_MAX_WIDTH)
    end)
    local var6 = React.joinBindings({ width = width, barScale = var1.barScale }):map(function(tbl3): UDim2
        return UDim2.fromOffset(tbl3.width * tbl3.barScale, 0)
    end)

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var4(arg1.AbsoluteSize.X)
    end, {})

    return React.createElement(View, {
        tag = "size-full col align-x-center align-y-center bg-surface-0",
        GroupTransparency = var1.groupTransparency,
        onAbsoluteSizeChanged = onAbsoluteSizeChanged
    }, {
        ProgressBarContainer = React.createElement(
            View,
            { tag = "auto-y", Size = var6 },
            {
                ProgressBar = React.createElement(Progress, { shape = ProgressShape.Bar, testId = "progress-loading-assets-bar" })
            }
        )
    })
end)

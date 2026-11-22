-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)

local View = Foundation.View

local Constants = require(Moments.Constants)
local useChromeRatio = require(Moments.Hooks.useChromeRatio)

local FFlagMomentsImmersiveHeaderFadeOut = require(Moments.Flags.FFlagMomentsImmersiveHeaderFadeOut)

local function ImmersiveHeaderChrome(tbl1)
    local ratio = useChromeRatio()

    local var2 = FFlagMomentsImmersiveHeaderFadeOut
    local bool1 = not FFlagMomentsImmersiveHeaderFadeOut

    local var3, var4 = React.useState(function()
        return var2 and ratio:getValue() < 1
    end)

    React.useEffect(function()
        if not var2 then
            return
        end

        local function applyRatio(num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
            local bool2 = num1 < 1
            var4(function(bool3: boolean): boolean
                return if bool3 == bool2 then bool3 else bool2
            end)
        end

        applyRatio((ratio:getValue()))
        return React.__subscribeToBinding(ratio, applyRatio)
    end, { ratio, var2 })

    local height, var6 = React.useBinding(0)
    local var7 = React.useCallback(function(arg1)
        var6(arg1.AbsoluteSize.Y)
    end, {})

    local var8 = React.joinBindings({ ratio = ratio, height = height }):map(function(tbl2): UDim2
        return UDim2.new(0, 0, 0, (tbl2.ratio - 1) * tbl2.height)
    end)

    local tbl2 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = tbl1.layoutOrder,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Interactable = ratio:map(function(num1: number): boolean
            return num1 > 0.01
        end),
        ZIndex = Constants.DisplayOrder.FeedTopBar,
        [React.Tag] = "data-testid=--moments-immersive-header-chrome"
    }

    if bool1 then
        tbl2.Position = var8
        tbl2[React.Change.AbsoluteSize] = var7
    end

    local str1

    if var2 and var3 then
        tbl2.GroupTransparency = ratio:map(function(num1: number): number
            return 1 - num1
        end)

        str1 = "CanvasGroup"
    else
        str1 = "Frame"
    end

    return React.createElement(str1, tbl2, { Header = React.createElement(View, { tag = "size-full-0 auto-y" }, tbl1.children) })
end

return ImmersiveHeaderChrome

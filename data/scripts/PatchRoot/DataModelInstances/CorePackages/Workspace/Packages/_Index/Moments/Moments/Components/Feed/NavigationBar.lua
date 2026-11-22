-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:30:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local BuilderIcons = require(MomentsParent.BuilderIcons)

local Foundation = require(MomentsParent.Foundation)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local React = require(MomentsParent.React)

local ChevronLargeUp = BuilderIcons.Icon.ChevronLargeUp
local ChevronLargeDown = BuilderIcons.Icon.ChevronLargeDown

local IconButton = Foundation.IconButton
local View = Foundation.View

local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useFormFactor = MomentsCommon.Hooks.useFormFactor
local usePreferredInput = require(Moments.Hooks.usePreferredInput)
local useTokens = Foundation.Hooks.useTokens

local FFlagLuaSupportMicroGamepadPreferredInput = require(MomentsParent.SharedFlags).FFlagLuaSupportMicroGamepadPreferredInput

local FormFactor = MomentsCommon.Enums.FormFactor

local function NavigationBar(tbl1)
    local var1 = useDeviceInsets()
    local var2 = useFormFactor()
    local var3 = usePreferredInput()
    local var4 = useTokens()

    local fFlagMomentsAlignFeedNavArrowsWithHeader = require(Moments.Flags.FFlagMomentsAlignFeedNavArrowsWithHeader)
    local var5 = if fFlagMomentsAlignFeedNavArrowsWithHeader then require(MomentsParent.AppComposition).useCompositionLayout() else nil

    if var2 == FormFactor.MobileLandscape then
        return nil
    end

    local var6 = var3 == Enum.PreferredInput.Gamepad
        or FFlagLuaSupportMicroGamepadPreferredInput and var3 == Enum.PreferredInput.MicroGamepad
    if var3 ~= Enum.PreferredInput.KeyboardAndMouse and not var6 then
        return nil
    end

    if not tbl1.active then
        return nil
    end

    local offset = math.max(var1.right, var4.Padding.XLarge)
    if fFlagMomentsAlignFeedNavArrowsWithHeader then
        offset = require(script.Parent.resolveFeedRightChromeInset)(var1, if var5 == nil then nil else var5.margin, var4.Padding.XLarge)
    end

    return React.createElement(
        View,
        {
            padding = {
                right = UDim.new(0, offset)
            },
            tag = "size-full",
            ZIndex = tbl1.zIndex
        },
        {
            NavControls = React.createElement(View, {
                tag = "col align-x-center align-y-center position-center-right anchor-center-right auto-xy radius-circle clip bg-over-media-0"
            }, {
                PreviousButton = React.createElement(IconButton, {
                    icon = ChevronLargeUp,
                    isCircular = true,
                    isDisabled = tbl1.currentIndex == 1,
                    LayoutOrder = 1,
                    onActivated = tbl1.onScrollToPrevious,
                    size = Foundation.Enums.IconSize.Medium
                }),
                NextButton = React.createElement(IconButton, {
                    icon = ChevronLargeDown,
                    isCircular = true,
                    isDisabled = tbl1.currentIndex == tbl1.numItems,
                    LayoutOrder = 2,
                    onActivated = tbl1.onScrollToNext,
                    size = Foundation.Enums.IconSize.Medium
                })
            })
        }
    )
end
return NavigationBar

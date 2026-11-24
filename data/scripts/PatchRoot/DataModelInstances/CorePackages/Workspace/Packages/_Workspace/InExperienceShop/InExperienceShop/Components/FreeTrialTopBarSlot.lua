-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)
local ReactRoblox = require(InExperienceShopParent.ReactRoblox)
local Foundation = require(InExperienceShopParent.Foundation)
local FocusNavigationUtils = require(InExperienceShopParent.FocusNavigationUtils)
local ReactFocusNavigation = require(InExperienceShopParent.ReactFocusNavigation)
local SignalsReact = require(InExperienceShopParent.SignalsReact)
local useLocalization = require(InExperienceShopParent.Localization).Hooks.useLocalization

local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize
local View = Foundation.View
local useFocusRoot = FocusNavigationUtils.useFocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local Provider = FocusNavigationUtils.FocusNavigableSurfaceRegistry.Provider

local TopBarChip = require(InExperienceShop.Components.TopBarChip)
local submitFreeTrialTopBarChip = require(InExperienceShop.submitFreeTrialTopBarChip)
local FFlagEnableFreeTrialChipReveal = require(InExperienceShop.Flags.FFlagEnableFreeTrialChipReveal)
local FFlagFreeTrialChipBuyAnimation = require(InExperienceShop.Flags.FFlagFreeTrialChipBuyAnimation)
local getCloseButtonPosition = require(script.Parent.getCloseButtonPosition)
local useFreeTrialChipDismiss = require(script.Parent.useFreeTrialChipDismiss)
local useFreeTrialChipReveal = if FFlagEnableFreeTrialChipReveal then require(script.Parent.useFreeTrialChipReveal) else nil
game:DefineFastInt("FreeTrialChipTopBarRightPadding", 100)

local function readHostShown(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(arg1) == "boolean" then
        return arg1
    elseif arg1 == nil then
        return true
    end
    return arg1:getValue()
end

local function assignRef(arg1, current) -- Luacid: Inlined by compiler; 1 call site recovered
    if type(arg1) == "function" then
        arg1(current)
    elseif arg1 ~= nil then
        arg1.current = current
    end
end

local function FreeTrialChipRevealFrame(tbl1)
    local var1 = useFocusRoot({ surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp, isAutoFocusRoot = false })

    local ref = React.useCallback(function(current)
        tbl1.revealRef.current = current
        assignRef(var1, current)
    end, { tbl1.revealRef, var1 })

    local maxWidth = tbl1.maxWidth
    return React.createElement("Frame", {
        AutomaticSize = if maxWidth ~= nil then Enum.AutomaticSize.Y else Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        ClipsDescendants = maxWidth ~= nil,
        Position = UDim2.fromScale(1, 0),
        ref = ref,
        Size = if maxWidth ~= nil then UDim2.fromOffset(maxWidth, 0) else UDim2.fromScale(0, 0),
        Visible = tbl1.hostShown,
        ZIndex = 100
    }, {
        Chip = tbl1.chip
    })
end

local function FreeTrialChipRevealPortal(tbl1)
    local value = React.useMemo(function()
        return ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)
    end, {})

    React.useEffect(function()
        return function()
            value:teardown()
        end
    end, { value })

    return React.createElement(ReactFocusNavigation.FocusNavigationContext.Provider, {
        value = value
    }, {
        Registry = React.createElement(Provider, nil, {
            Reveal = ReactRoblox.createPortal({
                FreeTrialChipReveal = React.createElement(
                    FreeTrialChipRevealFrame,
                    {
                        revealRef = tbl1.revealRef,
                        chip = tbl1.chip,
                        maxWidth = tbl1.maxWidth,
                        hostShown = tbl1.hostShown
                    }
                )
            }, tbl1.revealLayer)
        })
    })
end

local function FreeTrialTopBarSlot(tbl1)
    local isVisible = SignalsReact.useSignalState(
        if FFlagFreeTrialChipBuyAnimation then submitFreeTrialTopBarChip.isPresented else submitFreeTrialTopBarChip.isShowing
    )

    local var2 = SignalsReact.useSignalState(submitFreeTrialTopBarChip.image)
    local var3 = SignalsReact.useSignalState(submitFreeTrialTopBarChip.textKey)
    local var4 = SignalsReact.useSignalState(submitFreeTrialTopBarChip.isEmphasis)
    if tbl1.isEmphasis ~= nil then
        var4 = tbl1.isEmphasis
    end

    local var5 = useLocalization({ label = var3 })

    local hostVisible = tbl1.hostVisible
    local var6, var7 = React.useState(readHostShown(hostVisible))

    local var8 = React.useRef(hostVisible)
    var8.current = hostVisible

    React.useEffect(function()
        if typeof(hostVisible) == "boolean" or hostVisible == nil then
            var7(readHostShown(hostVisible))
            return function() end
        end
        local function applyVisible(bool1: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
            var7(bool1)
        end
        applyVisible((hostVisible:getValue()))
        return React.__subscribeToBinding(hostVisible, applyVisible)
    end, { hostVisible })
    local chipRef = React.useRef(nil)
    local var10 = if FFlagFreeTrialChipBuyAnimation then SignalsReact.useSignalState(submitFreeTrialTopBarChip.handle) else nil
    local var11 = if FFlagEnableFreeTrialChipReveal then useFreeTrialChipReveal(isVisible, if FFlagFreeTrialChipBuyAnimation then var10 else nil) else nil
    local var12 = useFreeTrialChipDismiss({
        isVisible = isVisible,
        isSettled = not FFlagEnableFreeTrialChipReveal or var11 == nil or var11.isSettled,
        revealLayer = if FFlagEnableFreeTrialChipReveal and var11 ~= nil then var11.revealLayer else nil,
        chipRef = chipRef
    })
    local image = var2 or ""

    local current = game:GetFastInt("FreeTrialChipTopBarRightPadding")
    local maxWidth = tbl1.maxWidth

    local var14, var15 = React.useState(0)
    local var16 = React.useRef(0)
    local var17 = React.useRef(var3)
    local var18 = React.useRef(current)
    if var17.current ~= var3 or var18.current ~= current then
        var17.current = var3
        var18.current = current
        if var16.current ~= 0 then
            var16.current = 0
            var15(0)
        end
    end
    local function onSlotAbsoluteSizeChanged(arg1)
        if maxWidth == nil then
            return
        end
        if var11 ~= nil then
            if FFlagFreeTrialChipBuyAnimation and not var11.revealSizeIsOwnRef.current then
                return
            end
            local current = var11.placeholderRef.current
            local absoluteSize = if current == nil then nil else current.AbsoluteSize

            if absoluteSize ~= nil and (absoluteSize.X <= 0 or absoluteSize.Y <= 0) then
                return
            end
        end
        local absoluteSizeX = arg1.AbsoluteSize.X
        local current = var16.current
        if not (absoluteSizeX <= 0)
            and absoluteSizeX ~= current
            and not (current > 0 and absoluteSizeX < current and absoluteSizeX <= maxWidth)
        then
            var16.current = absoluteSizeX
            var15(absoluteSizeX)
        end
    end
    React.useEffect(function()
        submitFreeTrialTopBarChip()
    end, { submitFreeTrialTopBarChip })
    local function reportMountedAndViewed()
        if not isVisible then
            return
        end
        submitFreeTrialTopBarChip.reportMounted()

        if var6 and readHostShown(var8.current) then
            submitFreeTrialTopBarChip.reportViewed()
        end
    end
    if FFlagFreeTrialChipBuyAnimation then
        React.useEffect(reportMountedAndViewed, { isVisible, var3, var10, var6 })
    else
        React.useEffect(reportMountedAndViewed, { isVisible, var3, var6 })
    end

    if FFlagFreeTrialChipBuyAnimation then
        local isSettled = if FFlagEnableFreeTrialChipReveal and var11 ~= nil then var11.isSettled else false
        local sampleOnSettleRef = if var11 == nil then nil else var11.sampleOnSettleRef
        local slotRef = if var11 == nil then nil else var11.slotRef

        React.useLayoutEffect(function()
            if not isSettled or maxWidth == nil or sampleOnSettleRef == nil or not sampleOnSettleRef.current then
                return
            end
            sampleOnSettleRef.current = false
            if var16.current ~= 0 or slotRef == nil then
                return
            end
            local current = slotRef.current
            if current ~= nil then
                onSlotAbsoluteSizeChanged(current)
            end
        end, {
            isSettled,
            maxWidth,
            sampleOnSettleRef,
            slotRef
        })
    end
    local function onChipActivated()
        if var12.consumeSuppressedActivation() then
            return
        end

        if submitFreeTrialTopBarChip.promptsPurchase(false) then
            submitFreeTrialTopBarChip.promptPurchase()
        else
            submitFreeTrialTopBarChip.reportActivated()
            if tbl1.onActivated ~= nil then
                tbl1.onActivated()
            end
        end
    end
    if not isVisible then
        return nil
    end

    local bool1 = not (maxWidth == nil or not (var14 > 0)) and maxWidth < var14
    local offset = if bool1 then 0 else current
    if bool1 then
        var14 = math.max(0, var14 - current)
    end

    local bool2 = not (maxWidth == nil) and maxWidth < var14
    local var1 = if bool2 then maxWidth else nil
    local element = React.createElement(TopBarChip, {
        text = var5.label,
        image = image,
        chipRef = chipRef,
        onActivated = onChipActivated,
        onStateChanged = if var12.pointerDismiss then var12.onChipStateChanged else nil,
        isEmphasis = var4,
        testId = "FreeTrialTopBarSlot",
        maxWidth = var1
    })
    local hovered = var12.pointerDismiss and var12.hovered
    if FFlagEnableFreeTrialChipReveal and var11 ~= nil then
        hovered = hovered and var11.isSettled
    end

    local element2

    if hovered then
        element2 = React.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.new(1, -offset, 1, 0),
                ZIndex = 2
            },
            {
                Button = React.createElement(View, {
                    Position = getCloseButtonPosition(),
                    onActivated = var12.onCloseActivated,
                    onStateChanged = var12.onCloseStateChanged,
                    tag = "align-x-center align-y-center anchor-top-right size-500 radius-circle bg-surface-0",
                    testId = "FreeTrialTopBarSlot--close"
                }, {
                    Icon = React.createElement(Icon, { name = "x", size = IconSize.XSmall })
                })
            }
        )
    else
        element2 = nil
    end

    local tbl2 = {
        tag = {
            ["auto-y clip"] = bool2,
            ["auto-xy"] = not bool2
        },
        LayoutOrder = tbl1.LayoutOrder,
        ZIndex = 100,
        padding = offset > 0 and {
            right = UDim.new(0, offset)
        } or nil,
        onAbsoluteSizeChanged = if maxWidth == nil then nil else onSlotAbsoluteSizeChanged,
        Size = if bool2 then UDim2.fromOffset(maxWidth, 0) else nil,
        sizeConstraint = bool2 and {
            MaxSize = Vector2.new(maxWidth, math.huge)
        } or nil,
        ref = nil,
        testId = nil
    }

    if not FFlagEnableFreeTrialChipReveal or var11 == nil then
        return React.createElement(View, tbl2, { Chip = element, Close = element2 })
    end

    tbl2.ref = var11.slotRef
    tbl2.testId = "FreeTrialTopBarSlot--slot"
    local createElement = React.createElement
    local var20 = View
    local tbl3 = { SlideContainer = 0, Reveal = 0, Close = 0 }
    local element3

    if var11.isSettled then
        element3 = React.createElement(
            "Frame",
            {
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(0, 0)
            },
            {
                Slide = React.createElement(
                    "Frame",
                    {
                        AutomaticSize = Enum.AutomaticSize.XY,
                        BackgroundTransparency = 1,
                        Size = UDim2.fromScale(0, 0)
                    },
                    { Chip = element }
                )
            }
        )
    else
        element3 = React.createElement("Frame", {
            BackgroundTransparency = 1,
            ref = var11.placeholderRef,
            Size = if var11.revealChipSize ~= nil then UDim2.fromOffset(var11.revealChipSize.X, var11.revealChipSize.Y) else UDim2.fromScale(0, 0)
        })
    end

    tbl3.SlideContainer = element3

    tbl3.Reveal = if var11.isSettled or var11.revealLayer == nil then nil else React.createElement(
        FreeTrialChipRevealPortal,
        {
            revealLayer = var11.revealLayer,
            revealRef = var11.revealRef,
            chip = element,
            maxWidth = var1,
            hostShown = tbl1.hostVisible == nil or tbl1.hostVisible
        }
    )

    tbl3.Close = element2
    return createElement(var20, tbl2, tbl3)
end

return FreeTrialTopBarSlot

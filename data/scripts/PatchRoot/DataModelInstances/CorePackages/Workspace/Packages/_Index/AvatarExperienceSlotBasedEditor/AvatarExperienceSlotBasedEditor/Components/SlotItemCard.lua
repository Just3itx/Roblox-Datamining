-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditorParent = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor").Parent

local React = require(AvatarExperienceSlotBasedEditorParent.React)
local AXTooltip = require(AvatarExperienceSlotBasedEditorParent.AXCommon).Components.AXTooltip
local AvatarExperienceUIKit = require(AvatarExperienceSlotBasedEditorParent.AvatarExperienceUIKit)
local ItemCard = AvatarExperienceUIKit.ItemCardComponents.ItemCard
local ItemCardHeader = AvatarExperienceUIKit.ItemCardComponents.ItemCardHeader
local SlotItemCardFooter = require(script.Parent.SlotItemCardFooter)
local Foundation = require(AvatarExperienceSlotBasedEditorParent.Foundation)

local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens
local ReactOtter = require(AvatarExperienceSlotBasedEditorParent.ReactOtter)

local FFlagAXSlotBasedEditorCategoryTooltip = require(AvatarExperienceSlotBasedEditorParent.AvatarExperienceFlags).FFlagAXSlotBasedEditorCategoryTooltip

local tooltipStorageKey = game:DefineFastString("AXSlotBasedEditorCategoryTooltipKey", "SlotEditorSecondCategory")

local tbl1 = { dampingRatio = 1, frequency = 1 }

return (React.forwardRef(function(tbl2, ref)
    local var1 = useTokens()
    local backgroundTransparency, var3 = ReactOtter.useAnimatedBinding(1)
    local var4, var5 = React.useState(false)

    local onStateChanged = React.useCallback(function(arg1)
        if arg1 == Foundation.Enums.ControlState.Default then
            var5(false)
        elseif arg1 == Foundation.Enums.ControlState.Hover then
            var5(true)
        end
    end, {})

    React.useEffect(function()
        local var7 = if var4 then var1.Color.Stroke.Emphasis.Transparency else 1
        var3(ReactOtter.spring(var7, tbl1))
    end, { var4 })

    local ref2 = nil
    local onActivated

    if FFlagAXSlotBasedEditorCategoryTooltip then
        ref2 = React.createRef()

        onActivated = React.useCallback(function()
            if ref2.current then
                ref2.current()
            end
            if tbl2.onActivated then
                tbl2.onActivated()
            end
        end, { tbl2.onActivated })
    else
        onActivated = nil
    end

    local createElement = React.createElement
    local var7 = ItemCard
    local tbl3 = {
        Size = tbl2.Size or UDim2.fromOffset(var1.Size.Size_2500, 0),
        LayoutOrder = tbl2.LayoutOrder,
        AutomaticSize = Enum.AutomaticSize.Y,
        onActivated = if FFlagAXSlotBasedEditorCategoryTooltip then onActivated else tbl2.onActivated,
        ref = ref,
        headerSlot = 0,
        footerSlot = 0
    }
    local createElement2 = React.createElement
    local var8 = ItemCardHeader
    local tbl4 = { LayoutOrder = 1, BackgroundTransparency = 1 }

    local createElement3 = React.createElement
    local var9 = View
    local tbl5 = {
        onStateChanged = onStateChanged,
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        },
        onActivated = 0,
        Size = 0,
        backgroundStyle = 0,
        selection = 0,
        padding = 0
    }
    if not FFlagAXSlotBasedEditorCategoryTooltip then
        onActivated = tbl2.onActivated
    end

    tbl5.onActivated = onActivated

    tbl5.Size = UDim2.fromScale(1, 1)
    tbl5.backgroundStyle = { Transparency = 1 }

    tbl5.selection = { Selectable = false }

    tbl5.padding = {
        top = UDim.new(0, var1.Padding.XXSmall),
        bottom = UDim.new(0, var1.Padding.XXSmall),
        left = UDim.new(0, var1.Padding.XXSmall),
        right = UDim.new(0, var1.Padding.XXSmall)
    }
    local tbl6 = {
        CornerRadius = React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Radius.Medium) }),
        HeaderSlot = tbl2.renderHeaderSlot(),
        HoverFrame = React.createElement(
            "Frame",
            {
                Size = UDim2.fromScale(1, 1),
                ZIndex = 2,
                BackgroundTransparency = backgroundTransparency
            },
            {
                CornerRadius = React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Radius.Medium) })
            }
        ),
        BorderFrame = 0,
        AXTooltip = 0
    }

    local createElement4 = React.createElement
    local str2 = "Frame"
    local tbl7 = {
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = var1.Color.Surface.Surface_200.Color3,
        BackgroundTransparency = tbl2.BackgroundTransparency or 0
    }
    local tbl8 = {
        CornerRadius = React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Radius.Medium) }),
        Stroke = React.createElement("UIStroke", {
            Color = var1.Color.Stroke.Default.Color3,
            Transparency = if tbl2.isActive then var1.Color.Selection.End.Transparency else var1.Color.State.Press.Transparency,
            Thickness = var1.Stroke.Thick
        })
    }
    tbl6.BorderFrame = createElement4(str2, tbl7, tbl8)

    tbl6.AXTooltip = FFlagAXSlotBasedEditorCategoryTooltip
        and React.createElement(AXTooltip, {
            popoverSide = "Top",
            tooltipLocalizationKey = "Feature.Avatar.Tooltip.CustomizeOverhaulSubcategories",
            tooltipStorageKey = tooltipStorageKey,
            dismissTooltipRef = ref2,
            showTooltip = tbl2.showSecondCategoryTooltip
        })
    tbl3.headerSlot = createElement2(var8, tbl4, createElement3(var9, tbl5, tbl6))

    tbl3.footerSlot = React.createElement(
        SlotItemCardFooter,
        {
            LayoutOrder = 2,
            title = tbl2.title,
            TextXAlignment = Enum.TextXAlignment.Center
        }
    )
    return createElement(var7, tbl3)
end))

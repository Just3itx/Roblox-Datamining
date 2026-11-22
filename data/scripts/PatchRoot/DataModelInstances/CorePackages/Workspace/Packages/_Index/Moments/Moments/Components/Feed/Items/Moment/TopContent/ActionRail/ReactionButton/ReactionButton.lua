-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local BuilderIcons = require(MomentsParent.BuilderIcons)
local Foundation = require(MomentsParent.Foundation)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local React = require(MomentsParent.React)
local SignalsReact = require(MomentsParent.SignalsReact)
local ReactOtter = require(MomentsParent.ReactOtter)
local FFlagMomentsUseSharedReactions = require(Moments.Flags.FFlagMomentsUseSharedReactions)

local Icon = Foundation.Icon
local View = Foundation.View
local Popover = Foundation.Popover
local IconSize = Foundation.Enums.IconSize
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide
local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens
local useSignalState = SignalsReact.useSignalState
local Reaction = if FFlagMomentsUseSharedReactions then require(MomentsParent.Reactions.Reaction) else MomentsCommon.Components.Reaction
local ReactionPickerPopover = if FFlagMomentsUseSharedReactions then require(MomentsParent.Reactions.ReactionPickerPopover) else nil
local ReactionSize = MomentsCommon.Enums.ReactionSize
local ReactionType = MomentsCommon.Enums.ReactionType

local RailItem = require(script.Parent.Parent.RailItem)
local ReactionPicker = require(script.Parent.ReactionPicker)
local usePickerReactions = require(script.Parent.usePickerReactions)
local MomentContext = require(script.Parent.Parent.Parent.Parent.MomentContext)
local useReactionCommit = require(script.Parent.Parent.Parent.Parent.Reactions.useReactionCommit)
local useMomentGestures = require(script.Parent.Parent.Parent.Parent.Reactions.useMomentGestures)
local getColorStyleWithTransparency = require(Moments.Utils.getColorStyleWithTransparency)
local usePreferredInput = require(Moments.Hooks.usePreferredInput)

local FFlagLuaSupportMicroGamepadPreferredInput = require(MomentsParent.SharedFlags).FFlagLuaSupportMicroGamepadPreferredInput

local ThumbUp = BuilderIcons.Icon.ThumbUp
local tbl1 = {
    Color3 = Color3.new(1, 1, 1),
    Transparency = 0
}
local function func1() end

return React.memo(function(tbl2) -- name: ReactionButton
    local var1 = useTokens()
    local var2 = usePreferredInput()
    local var3 = var2 == Enum.PreferredInput.Gamepad
        or FFlagLuaSupportMicroGamepadPreferredInput and var2 == Enum.PreferredInput.MicroGamepad

    local store = MomentContext.useMoment().store
    local var4 = useReactionCommit()

    local isOpen = useSignalState(store.getIsReactionPickerOpen)
    local current = useSignalState(store.getSelectedReaction)
    local bool1 = current ~= nil

    local var7 = React.useCallback(function()
        store.setReactionPickerOpen(false)
    end, { store })

    local transition, var9 = ReactOtter.useAnimatedBinding(if bool1 then 1 else 0)
    React.useEffect(function()
        var9(ReactOtter.spring(if bool1 then 1 else 0, { frequency = 6, dampingRatio = 1 }))
    end, { bool1 })

    local var10 = React.useRef(ReactionType.ThumbsUp)
    if current ~= nil then
        var10.current = current
    end
    local reactionType = current or var10.current

    local var12 = React.useCallback(function()
        if store.getIsReacted(false) then
            var4("tapButton", nil, nil)
        end
        store.setReactionPickerOpen(true)
    end, { store, var4 })

    local bool2 = not (var3 or tbl2.isDisabled)

    local var13 = useMomentGestures(not FFlagMomentsUseSharedReactions and bool2, { onTap = var12 })
    local var14, var15, var16, var17, var18

    if FFlagMomentsUseSharedReactions then
        var14 = React.useRef(nil)

        var15 = usePickerReactions()

        var16 = React.useCallback(function()
            store.setReactionPickerOpen(true)
        end, { store })

        var17 = React.useCallback(function(arg1, vector2: Vector2)
            var4("pickerSelect", vector2, arg1)
            store.setReactionPickerOpen(false)
        end, { store, var4 })

        var18 = React.useMemo(function()
            if current == nil then
                return nil
            end
            local result = ({})
            result[current] = true
            return result
        end, { current })
    else
        var14 = nil
        var17 = nil
        var16 = nil
        var15 = nil
        var18 = nil
    end

    local style = React.joinBindings({ transition = transition, scrub = tbl2.animationRatio }):map(function(tbl3)
        local var19 = (1 - tbl3.transition) * (1 - tbl3.scrub)
        return getColorStyleWithTransparency(var1.Color.Content.Emphasis, 1 - var19)
    end)
    local imageStyle = React.joinBindings({ transition = transition, scrub = tbl2.animationRatio }):map(function(tbl3)
        local var20 = tbl3.transition * (1 - tbl3.scrub)
        return getColorStyleWithTransparency(tbl1, 1 - var20)
    end)

    local reactButton = React.createElement(RailItem, {
        animationRatio = tbl2.animationRatio,
        isDisabled = tbl2.isDisabled,
        onActivated = if var3 then var12 else func1,
        LayoutOrder = tbl2.LayoutOrder,
        nativeRef = if FFlagMomentsUseSharedReactions then var14 else var13.ref,
        slot = React.createElement(View, { tag = "size-800-800" }, {
            Thumb = React.createElement(Icon, {
                name = ThumbUp,
                size = IconSize.Large,
                style = style,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5)
            }),
            Reacted = React.createElement(Reaction, {
                reactionType = reactionType,
                size = IconSize.Medium,
                imageStyle = imageStyle,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5)
            })
        })
    })

    if not FFlagMomentsUseSharedReactions then
        return React.createElement(Popover.Root, { isOpen = isOpen }, {
            Anchor = React.createElement(Popover.Anchor, nil, { ReactButton = reactButton }),
            Content = React.createElement(Popover.Content, {
                side = {
                    position = PopoverSide.Top,
                    offset = 8
                },
                align = PopoverAlign.End,
                hasArrow = false,
                radius = Radius.Circle,
                backgroundStyle = var1.Color.OverMedia.OverMedia_100,
                onPressedOutside = var7
            }, {
                ReactionPicker = React.createElement(ReactionPicker)
            })
        })
    end

    assert(ReactionPickerPopover ~= nil, "expected ReactionPickerPopover when FFlagMomentsUseSharedReactions is on")
    assert(
        not (var14 == nil) and var17 ~= nil,
        "expected the shared picker hooks when FFlagMomentsUseSharedReactions is on"
    )

    local createElement = React.createElement
    local fragment = React.Fragment
    local var21 = nil
    local tbl3 = { ReactButton = reactButton, Picker = 0 }
    local createElement2 = React.createElement
    local var22 = ReactionPickerPopover
    local tbl4 = {
        isOpen = isOpen,
        anchorRef = var14,
        onReactionSelected = var17,
        onDismiss = var7,
        onOpen = 0,
        onTap = 0,
        reactions = 0,
        reactionSize = 0,
        selectedReactions = 0,
        side = 0,
        align = 0,
        backgroundStyle = 0
    }

    if not bool2 then
        var16 = nil
    end

    tbl4.onOpen = var16
    if not bool2 then
        var12 = nil
    end

    tbl4.onTap = var12
    tbl4.reactions = var15
    tbl4.reactionSize = ReactionSize.Medium
    tbl4.selectedReactions = var18
    tbl4.side = {
        position = PopoverSide.Top,
        offset = 8
    }
    tbl4.align = PopoverAlign.End
    tbl4.backgroundStyle = var1.Color.OverMedia.OverMedia_100
    tbl3.Picker = createElement2(var22, tbl4)
    return createElement(fragment, var21, tbl3)
end)

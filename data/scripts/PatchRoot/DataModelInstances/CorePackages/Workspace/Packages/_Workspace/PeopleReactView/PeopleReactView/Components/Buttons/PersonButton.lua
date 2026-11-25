-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactViewParent = script:FindFirstAncestor("PeopleReactView").Parent

local Foundation = require(PeopleReactViewParent.Foundation)
local React = require(PeopleReactViewParent.React)
local SignalsReact = require(PeopleReactViewParent.SignalsReact)
local Signals = require(PeopleReactViewParent.Signals)
local PeopleService = require(PeopleReactViewParent.PeopleService)

local View = Foundation.View
local Icon = Foundation.Icon
local IconButton = Foundation.IconButton
local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local IconSize = Foundation.Enums.IconSize
local useTokens = Foundation.Hooks.useTokens
local useCursor = Foundation.Hooks.useCursor
local useSignalState = SignalsReact.useSignalState

local service = PeopleService.getService("Flags")
local GetFFlagAddPeoplePageCardLayout = service.GetFFlagAddPeoplePageCardLayout
local GetFFlagNewPeoplePageIcons = service.GetFFlagNewPeoplePageIcons

local function useIconName(tbl1, str1: string, bool1: boolean)
    return React.useMemo(function()
        if tbl1.animatedIcon then
            return str1
        end

        if not tbl1.icon then
            return ""
        end

        if tbl1.icon.off and tbl1.buttonState then
            if bool1 then
                return tbl1.icon.off
            end

            return tbl1.icon.on
        end

        return tbl1.icon.on
    end, {
        str1,
        bool1,
        tbl1.icon,
        tbl1.animatedIcon,
        tbl1.buttonState
    })
end

local function useTransparency(bool1: boolean, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return React.useMemo(function()
        if bool1 then
            return arg1.Color.Common.Shadow.Transparency
        end

        return nil
    end, { bool1 })
end

local function useButtonSize(bool1: boolean, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return React.useMemo(function(): UDim2
        if bool1 then
            if GetFFlagNewPeoplePageIcons() then
                return UDim2.fromOffset(arg1.Size.Size_1800 * 2, arg1.Size.Size_1000)
            end
            return UDim2.new(0, arg1.Size.Size_1800 * 2, 1, 0)
        end

        return UDim2.fromOffset(arg1.Size.Size_1000, arg1.Size.Size_1000)
    end, { bool1 })
end

local function MemoizedIconElement(tbl1)
    local var1 = useTokens()

    local var2 = useSignalState(tbl1.animatedIcon or Signals.createSignal(""))
    local var3 = useSignalState(tbl1.buttonState or Signals.createSignal(false))
    local isDisabled = useSignalState(tbl1.isGrayedOut or Signals.createSignal(false))

    local var5 = useIconName(tbl1, var2, var3)
    local var6 = useTransparency(isDisabled, var1)

    if tbl1.isBuilderIcon then
        var6 = nil
    end
    return React.useMemo(function()
        if not var5 or var5 == "" then
            return nil
        elseif tbl1.isBuilderIcon then
            return (React.createElement(IconButton, {
                icon = var5,
                size = IconSize.Medium,
                LayoutOrder = tbl1.LayoutOrder,
                Selectable = false,
                variant = ButtonVariant.Utility,
                isDisabled = isDisabled,
                onActivated = tbl1.onActivated,
                ref = tbl1.onMount
            }))
        end

        return (React.createElement(
            Icon,
            {
                name = var5,
                size = IconSize.Medium,
                LayoutOrder = tbl1.LayoutOrder,
                style = { Transparency = var6 }
            }
        ))
    end, {
        tbl1.isBuilderIcon,
        var5,
        tbl1.LayoutOrder,
        isDisabled,
        tbl1.onActivated,
        tbl1.onMount,
        var6
    })
end

local function createTextElement(text: string, bool1: boolean?, variant, onActivated: (...any) -> (...any), layoutOrder: number) -- Luacid: unused: defined but never referenced
    if not text then
        return nil
    end

    local createElement = React.createElement
    local var1 = Button
    local tbl1 = {
        text = text,
        fillBehavior = FillBehavior.Fill,
        Selectable = false,
        variant = 0,
        onActivated = 0,
        LayoutOrder = 0
    }
    if bool1 then
        variant = ButtonVariant.Text
    end

    tbl1.variant = variant
    tbl1.onActivated = onActivated
    tbl1.LayoutOrder = layoutOrder
    return createElement(var1, tbl1)
end

local function PersonButton(tbl1)
    local var1 = useTokens()

    local isDisabled = useSignalState(tbl1.isDisabled or Signals.createSignal(false))
    local text = useSignalState(type(tbl1.text) == "function" and tbl1.text or Signals.createSignal(tbl1.text))
    local var4 = useSignalState(
        type(tbl1.buttonVariant) == "function" and tbl1.buttonVariant or Signals.createSignal(tbl1.buttonVariant)
    )
    local var5 = useButtonSize(tbl1.text ~= nil, var1)

    local selectionImageObject = useCursor({ radius = UDim.new(0, var1.Radius.Medium), offset = var1.Size.Size_150, borderWidth = var1.Stroke.Thicker })

    local onActivated = tbl1.onActivated
    local var7

    if text then
        local createElement = React.createElement
        local var8 = Button
        local tbl2 = {
            text = text,
            fillBehavior = FillBehavior.Fill,
            Selectable = false,
            variant = 0,
            onActivated = 0,
            LayoutOrder = 2
        }
        if isDisabled then
            var4 = ButtonVariant.Text
        end

        tbl2.variant = var4
        tbl2.onActivated = onActivated
        var7 = createElement(var8, tbl2)
    else
        var7 = nil
    end

    return React.createElement(View, {
        tag = GetFFlagAddPeoplePageCardLayout()
            and {
                ["radius-medium row align-y-center align-x-center"] = true,
                ["bg-action-standard"] = not (tbl1.text or tbl1.isBackgroundTransparent)
            }
            or {
                ["radius-medium row align-y-center align-x-center"] = tbl1.text ~= nil,
                ["radius-medium row align-y-center align-x-center bg-action-standard"] = tbl1.text == nil
            },
        Size = var5,
        LayoutOrder = tbl1.LayoutOrder,
        onActivated = tbl1.onActivated,
        isDisabled = isDisabled,
        selection = { SelectionImageObject = selectionImageObject },
        ref = tbl1.onMount
    }, {
        Icon = React.createElement(MemoizedIconElement, {
            icon = tbl1.icon,
            animatedIcon = tbl1.animatedIcon,
            buttonState = tbl1.buttonState,
            LayoutOrder = tbl1.LayoutOrder,
            isGrayedOut = tbl1.isGrayedOut,
            isBuilderIcon = tbl1.isBuilderIcon,
            onActivated = tbl1.onActivated,
            onMount = tbl1.onMount
        }),
        Text = var7
    })
end

return PersonButton

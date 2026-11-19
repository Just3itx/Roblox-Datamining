-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:20:57Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BuilderIcons = require(FoundationParent.BuilderIcons)
local Logger = require(Foundation.Utility.Logger)
local React = require(FoundationParent.React)

local Constants = require(Foundation.Constants)

local Icon = require(Foundation.Components.Icon)
local Popover = require(Foundation.Components.Popover)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)

local useTokens = require(Foundation.Providers.Style.useTokens)

local useBindable = require(Foundation.Utility.useBindable)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local useComposedRef = require(FoundationParent.ReactUtils).useComposedRef

local _InputSize = require(Foundation.Enums.InputSize)
local PopoverAlign = require(Foundation.Enums.PopoverAlign)
local PopoverSide = require(Foundation.Enums.PopoverSide)
local Radius = require(Foundation.Enums.Radius)

local Flags = require(Foundation.Utility.Flags)

local BaseMenuItemAccessory = require(script.Parent.BaseMenuItemAccessory)
local BaseMenuContext = require(script.Parent.BaseMenuContext)
local BaseMenuScrollContainer = require(script.Parent.BaseMenuScrollContainer)

local useBaseMenuItemVariants = require(script.Parent.useBaseMenuItemVariants)
local useMenuItemHover = require(script.Parent.useMenuItemHover)

local tbl1 = { isChecked = false }

local function resolveAccessory(iconName) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if iconName == nil then nil elseif type(iconName) == "string" then {
        iconName = iconName
    } else iconName
end

local function getInputSinkAll()
    if not Flags.FoundationGuiObjectInputSinkProperty then
        return nil
    end

    local success, result = pcall(game.GetEngineFeature, game, "GuiObjectInputSink")
    if not (success and result) then
        return nil
    end

    local success2, result2 = pcall(function(): Enum.InputSink
        return Enum.InputSink.All
    end)

    return if success2 then result2 else nil
end

local InputSink = getInputSinkAll()

local function getContainerPadding(container, bool1: boolean)
    local var1 = if bool1 then container.paddingLeftWithCheck else container.paddingLeftWithoutCheck
    return {
        left = UDim.new(0, var1 or 0),
        right = UDim.new(0, container.paddingRight or 0)
    }
end

return React.memo(React.forwardRef(function(arg1, arg2) -- name: BaseMenuItem
    local var1 = withDefaults(arg1, tbl1)
    local var2 = React.useContext(BaseMenuContext)
    local bool1 = if var1.menuHasLeading ~= nil then var1.menuHasLeading else var2.hasLeading == true
    local bool2 = if var1.menuHasCheck ~= nil then var1.menuHasCheck else var1.isChecked == true
    local tokens = useTokens()
    local size = var1.size or var2.size
    local depth = var2.depth

    local isSubmenu = var1.children ~= nil
    local isOpen = isSubmenu and var2.hoverOpenPath[depth] == var1.id

    local accessory = resolveAccessory(var1.leading or var1.icon)
    local var3 = resolveAccessory(var1.trailing)
    local bool5 = var2.maxHeight ~= nil
    local var6 = useBaseMenuItemVariants(tokens, size, bool5)

    local var7 = React.useRef(nil)
    local bool6 = var1.isChecked == true and not isSubmenu
    local hasLeading, var9 = React.useState(false)
    local setHasLeading = React.useCallback(function()
        var9(true)
    end, {})

    local bool7 = accessory ~= nil
    React.useEffect(function()
        if bool7 and var2.setHasLeading then
            var2.setHasLeading()
        end
    end, { bool7, var2.setHasLeading })

    useMenuItemHover({
        itemRef = var7,
        id = var1.id,
        depth = depth,
        isSubmenu = isSubmenu,
        isDisabled = var1.isDisabled,
        hoverOpenAtDepth = var2.hoverOpenAtDepth,
        hoverCloseAtDepth = var2.hoverCloseAtDepth
    })

    local onActivated = React.useCallback(function()
        if isSubmenu then
            if var1.isDisabled then
                return
            end

            if var2.hoverOpenAtDepth and not isOpen then
                var2.hoverOpenAtDepth(depth, var1.id, true)
            end

            return
        end

        if var2.hoverReset then
            var2.hoverReset()
        end

        local onActivated = if var1.onActivated then var1.onActivated else var2.onActivated

        if not onActivated then
            Logger:warning("Menu should have either onActivated on itself or on all of its children")
        else
            onActivated(var1.id)
        end

        if depth > 1 and var2.onNestedLeafActivated then
            var2.onNestedLeafActivated()
        end
    end, {
        isSubmenu,
        var1.isDisabled,
        isOpen,
        depth,
        var1.id,
        var1.onActivated,
        var2.onActivated,
        var2.onNestedLeafActivated,
        var2.hoverOpenAtDepth,
        var2.hoverReset
    })

    local onPressedOutside = React.useCallback(function()
        if var2.hoverReset then
            var2.hoverReset()
        end
    end, { var2.hoverReset })

    local maxHeight = useBindable(var2.maxHeight)

    local cursor = React.useMemo(function()
        return {
            radius = UDim.new(0, tokens.Radius.Small),
            offset = tokens.Size.Size_200,
            borderWidth = tokens.Stroke.Thicker
        }
    end, { tokens })

    local ref = useComposedRef(var7, arg2)

    local padding = getContainerPadding(var6.container, bool2)
    local layout = {
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0, 0),
        SortOrder = Enum.SortOrder.LayoutOrder
    }
    local gap = var6.wrapper and var6.wrapper.gap or 0
    local element

    if bool2 then
        element = React.createElement(View, {
            LayoutOrder = 1,
            tag = `{var6.slotAlign.tag} {var6.check.tag}`,
            testId = `{var1.testId}--check-column`
        }, {
            Check = if bool6 then React.createElement(Icon, {
                name = BuilderIcons.Icon.Check,
                style = var6.check.style,
                size = var6.check.size,
                testId = `{var1.testId}--checkmark`
            }) else nil
        })
    else
        element = nil
    end

    local element2 = nil
    if accessory ~= nil then
        element2 = React.createElement(BaseMenuItemAccessory, {
            LayoutOrder = 1,
            accessory = accessory,
            iconVariant = var6.icon,
            size = size,
            tokens = tokens,
            testId = `{var1.testId}--leading`
        })
    elseif bool1 then
        element2 = React.createElement(View, { LayoutOrder = 1, tag = `{var6.slotAlign.tag} {var6.icon.tag}` })
    end

    local title = React.createElement(Text, { LayoutOrder = 2, Text = var1.text, tag = var6.text.tag })

    local element4 = nil
    if isSubmenu then
        element4 = React.createElement(Icon, {
            LayoutOrder = 3,
            name = BuilderIcons.Icon.ChevronSmallRight,
            style = var6.check.style,
            size = var6.chevron.size,
            testId = `{var1.testId}--chevron`
        })
    elseif var3 ~= nil then
        element4 = React.createElement(BaseMenuItemAccessory, {
            LayoutOrder = 3,
            accessory = var3,
            iconVariant = var6.icon,
            size = size,
            tokens = tokens,
            testId = `{var1.testId}--trailing`
        })
    end

    local createElement = React.createElement
    local var16 = View
    local var17 = withCommonProps
    local tbl3 = {
        GroupTransparency = if var1.isDisabled then Constants.DISABLED_TRANSPARENCY else nil,
        isDisabled = var1.isDisabled,
        onActivated = onActivated,
        selection = {
            Selectable = not var1.isDisabled
        },
        cursor = cursor,
        tag = var6.container.tag,
        padding = padding,
        layout = layout,
        ref = ref
    }
    local element5 = createElement(var16, var17(var1, tbl3), {
        Check = element,
        Wrapper = React.createElement(View, {
            LayoutOrder = 2,
            tag = "auto-xy",
            flexItem = {
                FlexMode = Enum.UIFlexMode.Fill
            },
            layout = {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, gap),
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        }, { Leading = element2, Title = title, Trailing = element4 })
    })

    local value = React.useMemo(function()
        return {
            onActivated = var2.onActivated,
            onNestedLeafActivated = var2.onNestedLeafActivated,
            size = size,
            hasLeading = hasLeading,
            setHasLeading = setHasLeading,
            hoverOpenPath = var2.hoverOpenPath,
            hoverOpenAtDepth = var2.hoverOpenAtDepth,
            hoverCloseAtDepth = var2.hoverCloseAtDepth,
            hoverReset = var2.hoverReset,
            depth = depth + 1,
            maxHeight = var2.maxHeight
        }
    end, {
        var2.onActivated,
        var2.onNestedLeafActivated,
        size,
        hasLeading,
        var2.hoverOpenPath,
        var2.hoverOpenAtDepth,
        var2.hoverCloseAtDepth,
        var2.hoverReset,
        depth,
        var2.maxHeight
    })

    if not isSubmenu then
        return element5
    end

    local standard = tokens.Stroke.Standard
    local size2 = var6.groupPadding.size

    local element6 = React.createElement(BaseMenuContext.Provider, { value = value }, var1.children)
    local element7 = if bool5 then React.createElement(
        BaseMenuScrollContainer,
        {
            maxHeight = maxHeight,
            scrollViewProps = {
                tag = var6.submenuContent.tag,
                InputSink = InputSink
            }
        },
        element6
    ) else React.createElement(View, { tag = var6.submenuContent.tag, InputSink = InputSink }, element6)
    return React.createElement(React.Fragment, nil, {
        Item = element5,
        Submenu = React.createElement(Popover.Root, {
            isOpen = isOpen,
            testId = `{var1.testId}--submenu`
        }, {
            Anchor = React.createElement(Popover.Anchor, { anchorRef = var7 }),
            Content = React.createElement(Popover.Content, {
                side = {
                    position = PopoverSide.Right,
                    offset = size2 / 2 + standard
                },
                align = {
                    position = PopoverAlign.Start,
                    offset = -size2
                },
                hasArrow = false,
                onPressedOutside = onPressedOutside,
                backgroundStyle = tokens.Color.Surface.Surface_200,
                radius = Radius.Medium
            }, element7)
        })
    })
end))

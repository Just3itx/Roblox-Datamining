-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BuilderIcons = require(FoundationParent.BuilderIcons)
local _Otter = require(FoundationParent.Otter)
local React = require(FoundationParent.React)

local ReactOtter = require(FoundationParent.ReactOtter)

local Icon = BuilderIcons.Icon

local Divider = require(Foundation.Components.Divider)
local Icon2 = require(Foundation.Components.Icon)
local Text = require(Foundation.Components.Text)

local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local usePreferences = require(Foundation.Providers.Preferences.usePreferences)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local useAccordion = require(script.Parent.Parent.useAccordion)
local useTokens = require(Foundation.Providers.Style.useTokens)

local InputPlacement = require(Foundation.Enums.InputPlacement)
local _InputSize = require(Foundation.Enums.InputSize)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local useAccordionItemVariants = require(script.Parent.Parent.useAccordionItemVariants)

local tbl1 = { hasDivider = true, isExpanded = false }

local function getCommonEaseConfig(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        easingStyle = arg1.Ease.StandardOut,
        duration = arg1.Time.Time_300
    }
end

return React.memo(React.forwardRef(function(arg1, ref) -- name: AccordionItem
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local reducedMotion = usePreferences().reducedMotion
    local var3 = React.useMemo(function()
        return getCommonEaseConfig(var2)
    end, { var2 })

    local var4, var5 = React.useState(var1.isExpanded)

    local var6 = React.useRef(false)
    local rotation, var8 = ReactOtter.useAnimatedBinding(0)
    local var9, var10 = ReactOtter.useAnimatedBinding(0, function()
        if var6.current then
            var5(false)
            var6.current = false
        end
    end)
    local var7 = React.useRef(nil)
    local var12 = React.useCallback(function()
        if reducedMotion then
            var10((ReactOtter.instant(0)))
            var8((ReactOtter.instant(0)))
            var5(false)
            var6.current = false
            return
        end

        var6.current = true
        var10(ReactOtter.ease(0, var3))
        var8(ReactOtter.ease(0, var3))
    end, { reducedMotion, var3 })

    local onAbsoluteSizeChanged = React.useCallback(function()
        if not var7 or not var7.current or not var4 then
            return
        end

        if reducedMotion then
            var10((ReactOtter.instant(var7.current.AbsoluteSize.Y)))
            return
        end
        var10(ReactOtter.ease(var7.current.AbsoluteSize.Y, var3))
    end, {
        var7,
        var4,
        reducedMotion,
        var3
    })

    React.useEffect(function()
        if var4 and not var1.isExpanded then
            var12()
            return
        end
        var5(var1.isExpanded)
    end, { var1.isExpanded })

    React.useEffect(function()
        if not var4 then
            return
        end

        if reducedMotion then
            var8((ReactOtter.instant(-180)))
            return
        end
        var8(ReactOtter.ease(-180, var3))
    end, { var4, reducedMotion, var3 })

    local var14 = useAccordion()
    local onAccordionItemActivated = var14.onAccordionItemActivated
    local itemSize = var14.itemSize
    local isContained = var14.isContained
    local chevronPosition = var14.chevronPosition

    local var15 = useAccordionItemVariants(var2, itemSize, isContained)
    local bool1 = chevronPosition == InputPlacement.Start
    local layoutOrder = if bool1 then 3 else 1
    local num1 = if bool1 then 1 else 3

    local var16 = React.useCallback(function()
        if var4 then
            var12()
            return
        end
        var5(true)
    end, { var4 })

    if var1.onActivated then
        var16 = var1.onActivated
    elseif onAccordionItemActivated then
        var16 = onAccordionItemActivated(var1.id, var4)
    end

    var1.testId = `{var14.testId}--item-{var1.id}`

    local bool2 = var1.description ~= nil
    local title = React.createElement(Text, {
        LayoutOrder = 2,
        Text = var1.text,
        tag = {
            [var15.text.tag] = true,
            grow = not bool2,
            ["size-full-0"] = bool2
        },
        testId = `{var1.testId}--title`
    })
    local var17 = if var1.icon then var1.icon else var1.leadingIcon
    local createElement = React.createElement
    local var18 = View
    local var19 = withCommonProps(
        var1,
        {
            tag = var15.container.tag,
            AutomaticSize = Enum.AutomaticSize.Y,
            stateLayer = var15.container.stateLayer,
            ref = ref
        }
    )
    local tbl2 = { Header = 0, Content = 0, Divider = 0 }
    local createElement2 = React.createElement
    local var20 = View
    local tbl3 = {
        LayoutOrder = 1,
        tag = var15.header.tag,
        AutomaticSize = if bool2 then Enum.AutomaticSize.Y else nil,
        onActivated = var16,
        testId = `{var1.testId}--header`
    }
    local tbl4 = { Icon = 0, Title = 0, TextContainer = 0, CollapseIcon = 0 }
    local element2

    if var17 then
        element2 = React.createElement(Icon2, {
            LayoutOrder = layoutOrder,
            name = if type(var17) == "table" then var17.name else var17,
            variant = if type(var17) == "table" then var17.variant else nil,
            style = var15.icon.style,
            size = var15.icon.size,
            testId = `{var1.testId}--leading-icon`
        })
    else
        element2 = nil
    end

    tbl4.Icon = element2

    tbl4.Title = if bool2 then nil else title
    local element3

    if bool2 then
        element3 = React.createElement(
            View,
            {
                LayoutOrder = 2,
                tag = var15.textContainer.tag,
                testId = `{var1.testId}--text-container`
            },
            {
                Title = title,
                Description = React.createElement(Text, {
                    LayoutOrder = 3,
                    Text = var1.description,
                    TextWrapped = false,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    tag = var15.description.tag,
                    testId = `{var1.testId}--description`
                })
            }
        )
    else
        element3 = nil
    end

    tbl4.TextContainer = element3

    tbl4.CollapseIcon = React.createElement(
        View,
        {
            tag = "auto-xy",
            LayoutOrder = num1,
            testId = `{var1.testId}--collapse-icon-container`
        },
        {
            Icon = React.createElement(Icon2, {
                name = Icon.ChevronLargeDown,
                Rotation = rotation,
                style = var15.icon.style,
                size = var15.icon.size,
                testId = `{var1.testId}--collapse-icon`
            })
        }
    )
    tbl2.Header = createElement2(var20, tbl3, tbl4)
    local var21

    if var4 then
        local createElement3 = React.createElement
        local var22 = View

        local tbl5 = {
            tag = "col",
            LayoutOrder = 2,
            testId = `{var1.testId}--content`,
            Size = if var9 then var9:map(function(yOffset: number?): UDim2
                return UDim2.new(1, 0, 0, yOffset)
            end) else nil,
            ClipsDescendants = true
        }

        var21 = createElement3(var22, tbl5, {
            AnimatedContainer = React.createElement(View, {
                tag = var15.content.tag,
                ref = var7,
                onAbsoluteSizeChanged = onAbsoluteSizeChanged,
                flexItem = {
                    FlexMode = Enum.UIFlexMode.None
                },
                testId = `{var1.testId}--animated-content`
            }, { var1.children })
        })
    else
        var21 = nil
    end

    tbl2.Content = var21

    tbl2.Divider = if var1.hasDivider then React.createElement(Divider, { LayoutOrder = 3, testId = `{var1.testId}--divider` }) else nil
    return createElement(var18, var19, tbl2)
end))

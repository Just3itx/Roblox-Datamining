-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local Foundation = require(SduiSharedContentParent.Foundation)
local React = require(SduiSharedContentParent.React)
local ReactOtter = require(SduiSharedContentParent.ReactOtter)

local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local List = Foundation.List

local function hasContent(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if typeof(arg1) ~= "table" or React.isValidElement(arg1) then
        return not (arg1 == nil) and arg1 ~= false
    end
    for _, value in arg1 do
        if value ~= false then
            return true
        end
    end
    return false
end

local function partId(str1: string?, str2: string) -- Luacid: unused: defined but never referenced
    if str1 then
        return `{str1}--{str2}`
    end

    return nil
end

return React.memo(function(tbl1) -- name: SduiExpandableListItem
    local var1 = Foundation.Hooks.useTokens()
    local testId = tbl1.testId

    local bool1 = hasContent(tbl1.children)
    local bool2 = hasContent(tbl1.trailing)

    local bool3, var2 = React.useState(tbl1.initiallyExpanded == true)
    local bool4 = tbl1.isExpanded ~= nil
    if bool4 then
        bool3 = tbl1.isExpanded == true
    end
    local var3 = React.useRef(bool3)
    var3.current = bool3
    local function toggle()
        local current = not var3.current
        var3.current = current
        if not bool4 then
            var2(current)
        end
        if tbl1.onExpandedChanged then
            tbl1.onExpandedChanged(current)
        end
    end

    local reducedMotion = Foundation.Hooks.usePreferences().reducedMotion
    local rotation, var5 = ReactOtter.useAnimatedBinding(if bool3 then -180 else 0)
    React.useEffect(function()
        local num1 = if bool3 then -180 else 0
        var5(
            if reducedMotion then ReactOtter.instant(num1) else ReactOtter.ease(num1, { easingStyle = var1.Ease.StandardOut, duration = var1.Time.Time_300 })
        )
    end, { bool3, reducedMotion, var1 })

    local leading = React.useMemo(function()
        local leadingIcon = tbl1.leadingIcon
        return if leadingIcon == nil then nil else IconName[leadingIcon] or {
            iconName = leadingIcon
        }
    end, { tbl1.leadingIcon })

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = { tag = "row align-y-center gap-xsmall auto-xy" }

    local tbl3 = {
        Actions = if bool2 then React.createElement(Foundation.View, { tag = "row align-y-center gap-xsmall auto-xy", LayoutOrder = 1 }, tbl1.trailing) else nil,
        Toggle = 0
    }
    local element

    if bool1 then
        local createElement2 = React.createElement
        local view2 = Foundation.View
        local tbl4 = {
            tag = "size-600-600 radius-small",
            onActivated = toggle,
            testId = if testId then `{testId}--toggle` else nil,
            LayoutOrder = 2
        }
        local tbl5 = {
            Chevron = React.createElement(Foundation.Icon, {
                name = IconName.ChevronSmallDown,
                size = IconSize.Large,
                Rotation = rotation,
                testId = if testId then `{testId}--chevron` else nil
            })
        }
        element = createElement2(view2, tbl4, tbl5)
    else
        element = React.createElement(Foundation.View, { tag = "size-600-600", LayoutOrder = 2 })
    end

    tbl3.Toggle = element
    local trailing = createElement(view, tbl2, tbl3)

    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl4 = {
        tag = {
            ["col size-full-0 auto-y"] = true,
            [tbl1.tag or ""] = tbl1.tag ~= nil
        },
        LayoutOrder = tbl1.layoutOrder
    }
    local tbl5 = { Row = 0, Content = 0 }
    local createElement3 = React.createElement
    local view3 = Foundation.View
    local tbl6 = {
        tag = "size-full-0 auto-y expandable-list-item-row",
        testId = if testId then `{testId}--row` else nil,
        LayoutOrder = 1
    }
    local tbl7 = {
        Highlight = React.createElement(Foundation.View, {
            tag = {
                ["radius-medium expandable-list-item-highlight"] = true,
                ["bg-shift-200"] = tbl1.isSelected == true
            },
            Position = UDim2.fromOffset(-var1.Padding.Small, var1.Padding.XSmall),
            Size = UDim2.new(1, var1.Padding.Small * 2, 1, -var1.Padding.XSmall * 2),
            ZIndex = 0,
            testId = if testId then `{testId}--highlight` else nil
        }),
        Item = 0
    }
    local createElement4 = React.createElement
    local item = List.Item
    local tbl8 = {
        title = tbl1.title or "",
        description = tbl1.description,
        leading = leading,
        trailing = trailing,
        input = Foundation.Enums.ListItemInputType.None,
        onActivated = 0,
        LayoutOrder = 1,
        testId = 0
    }
    local onActivated = tbl1.onActivated

    if onActivated then
        toggle = onActivated
    elseif not bool1 then
        toggle = nil
    end

    tbl8.onActivated = toggle

    tbl8.testId = testId
    tbl7.Item = createElement4(item, tbl8)
    tbl5.Row = createElement3(view3, tbl6, tbl7)
    local var7

    if bool1 and bool3 then
        local createElement5 = React.createElement
        local view4 = Foundation.View
        local tbl9 = {
            tag = "size-full-0 auto-y",
            padding = {
                left = UDim.new(0, var1.Size.Size_300)
            },
            LayoutOrder = 2
        }
        local tbl10 = {
            List = React.createElement(List.Root, {
                size = tbl1.size or Foundation.Enums.InputSize.Medium,
                hasDivider = false,
                isContained = { isContained = false, hasMargin = false },
                testId = if testId then `{testId}--content` else nil
            }, tbl1.children)
        }
        var7 = createElement5(view4, tbl9, tbl10)
    else
        var7 = nil
    end

    tbl5.Content = var7
    return createElement2(view2, tbl4, tbl5)
end)

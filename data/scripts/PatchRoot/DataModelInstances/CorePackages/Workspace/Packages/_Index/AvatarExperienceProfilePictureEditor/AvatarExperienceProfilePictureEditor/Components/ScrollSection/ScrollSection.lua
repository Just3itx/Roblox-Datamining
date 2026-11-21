-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditorParent = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor").Parent

local React = require(AvatarExperienceProfilePictureEditorParent.React)
local Foundation = require(AvatarExperienceProfilePictureEditorParent.Foundation)

local View = Foundation.View
local Divider = Foundation.Divider
local ScrollView = Foundation.ScrollView
local Visibility = Foundation.Enums.Visibility

local scroll = {
    ScrollingDirection = Enum.ScrollingDirection.Y,
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    CanvasSize = UDim2.fromScale(0, 0),
    scrollBarVisibility = Visibility.Auto
}

local function renderScrollView(tbl2)
    return React.createElement(
        ScrollView,
        {
            tag = "grow size-full-0",
            LayoutOrder = tbl2.scrollLayoutOrder,
            scroll = scroll,
            selection = { Selectable = false },
            onAbsoluteCanvasSizeChanged = tbl2.onAbsoluteCanvasSizeChanged,
            onAbsoluteWindowSizeChanged = tbl2.onAbsoluteWindowSizeChanged
        },
        {
            Content = React.createElement(View, { tag = "col size-full-0 auto-y padding-bottom-xlarge" }, tbl2.contentChildren)
        }
    )
end

local function hasVerticalScrollOverflow(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.AbsoluteCanvasSize.Y > arg1.AbsoluteWindowSize.Y + 1
end

local function ScrollSection(tbl2)
    local pinHeader = tbl2.pinHeader
    local useInternalScroll = tbl2.useInternalScroll
    local children = tbl2.children

    local var1, var2 = React.useState(false)

    local var3 = React.useCallback(function(arg1)
        var2(not not hasVerticalScrollOverflow(arg1))
    end, {})

    local onAbsoluteCanvasSizeChanged = React.useCallback(function(arg1)
        var3(arg1)
    end, { var3 })

    local onAbsoluteWindowSizeChanged = React.useCallback(function(arg1)
        var3(arg1)
    end, { var3 })

    local element = if var1 then React.createElement(Divider, { Size = UDim2.new(1, 0, 0, 1), LayoutOrder = 2 }) else nil
    local header = if tbl2.header then React.createElement(View, { tag = "auto-xy", LayoutOrder = 1 }, tbl2.header) else nil
    local tbl3 = {
        onAbsoluteCanvasSizeChanged = onAbsoluteCanvasSizeChanged,
        onAbsoluteWindowSizeChanged = onAbsoluteWindowSizeChanged
    }

    local var6 = pinHeader and header ~= nil
    local tbl4

    if not useInternalScroll then
        tbl4 = { StaticContent = 0 }
        local createElement = React.createElement
        local var7 = View
        local tbl5 = {
            tag = "col size-full-0 auto-y padding-bottom-xlarge",
            LayoutOrder = if var6 then 2 else 1
        }
        local tbl6 = {
            Header = if var6 then nil else header or nil,
            Body = if children then React.createElement(React.Fragment, nil, children) else nil
        }
        tbl4.StaticContent = createElement(var7, tbl5, tbl6)
    elseif var6 then
        tbl4 = {
            Header = header,
            ScrollContent = renderScrollView({
                contentChildren = children or {},
                scrollLayoutOrder = 2,
                onAbsoluteCanvasSizeChanged = tbl3.onAbsoluteCanvasSizeChanged,
                onAbsoluteWindowSizeChanged = tbl3.onAbsoluteWindowSizeChanged
            })
        }
    else
        tbl4 = { ScrollContent = 0 }
        local func1 = renderScrollView
        local tbl5 = {
            contentChildren = {
                Header = header,
                Body = if children then React.createElement(React.Fragment, nil, children) else nil
            },
            scrollLayoutOrder = 1,
            onAbsoluteCanvasSizeChanged = tbl3.onAbsoluteCanvasSizeChanged,
            onAbsoluteWindowSizeChanged = tbl3.onAbsoluteWindowSizeChanged
        }
        tbl4.ScrollContent = func1(tbl5)
    end

    if not useInternalScroll then
        tbl4 = var6 and {
            Header = header,
            StaticContent = tbl4.StaticContent
        } or tbl4
    end

    local createElement = React.createElement
    local var7 = View
    local tbl5 = {
        tag = {
            ["col size-full-0 padding-top-xlarge"] = true,
            grow = useInternalScroll,
            ["auto-y"] = not useInternalScroll
        },
        LayoutOrder = tbl2.layoutOrder
    }
    local tbl6 = {
        Inner = React.createElement(View, {
            tag = {
                ["col gap-small size-full-0"] = true,
                grow = useInternalScroll,
                ["auto-y"] = not useInternalScroll
            },
            LayoutOrder = 1
        }, tbl4),
        ScrollAffordanceDivider = 0
    }

    if not useInternalScroll then
        element = nil
    end

    tbl6.ScrollAffordanceDivider = element
    return createElement(var7, tbl5, tbl6)
end

return ScrollSection

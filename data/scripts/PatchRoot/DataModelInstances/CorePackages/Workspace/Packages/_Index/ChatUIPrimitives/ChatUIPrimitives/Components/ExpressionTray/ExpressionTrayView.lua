-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local React = require(ChatUIPrimitivesParent.React)

local ExpressionEntryButtonView = require(script.Parent.ExpressionEntryButtonView)
local ExpressionFlyOutView = require(script.Parent.ExpressionFlyOutView)
local ExpressionTrayFocusRoot = require(script.Parent.ExpressionTrayFocusRoot)
local ExpressionTabBar = require(script.Parent.ExpressionTabBar)
local ExpressionSheetView = require(script.Parent.ExpressionSheetView)
local ExpressionPillView = require(script.Parent.ExpressionPillView)
local expressionKey = require(script.Parent.expressionKey).expressionKey
local _Types = require(ChatUIPrimitives.UniversalMessage.Types)
local _useLayoutMode = require(ChatUIPrimitives.Hooks.useLayoutMode)
local getDefaultCooldownKey = require(ChatUIPrimitives.getDefaultCooldownKey)
local createNextOrder = require(ChatUIPrimitivesParent.ReactUtils).createNextOrder

local function expressionText(content) -- Luacid: Inlined by compiler; 1 call site recovered
    if content.kind == "plain-text" then
        return content.text
    elseif content.kind == "preset" then
        return content.text or ""
    elseif content.kind == "emoji" then
        return content.unicode or content.name or content.altText or ""
    end

    return content.altText or ""
end

local function buildEntryButton(tbl1, buttonRef) -- Luacid: Inlined by compiler; 1 call site recovered
    return React.createElement(ExpressionEntryButtonView, {
        onActivated = tbl1.onEntryActivated,
        isActive = tbl1.isOpen,
        size = Foundation.Enums.InputSize.Medium,
        buttonRef = buttonRef
    })
end

local function buildContent(tbl1, buttonRef)
    local var1 = nil
    for _, categoryGroup in tbl1.categoryGroups do
        if categoryGroup.categoryGroupId == tbl1.activeGroupId then
            var1 = categoryGroup
            break
        end
    end

    local tabs = {}
    for _, categoryGroup in tbl1.categoryGroups do
        table.insert(tabs, { id = categoryGroup.categoryGroupId, text = categoryGroup.name or categoryGroup.categoryGroupId })
    end

    local nextOrder = createNextOrder()
    local tbl3 = {}
    local bool1 = false
    if var1 then
        for _, value in var1.categories do
            local tbl4 = ({})
            for layoutOrder, item in value.items do
                local content = item.content

                local defaultCooldownKey = getDefaultCooldownKey(content)
                local cooldownEndsAt = if defaultCooldownKey == nil or tbl1.cooldownEndsAtByKey == nil then nil else tbl1.cooldownEndsAtByKey[defaultCooldownKey]
                local bool2 = not (buttonRef == nil) and not bool1

                if bool2 then
                    bool1 = true
                end

                local var3 = expressionKey(content)
                tbl4[var3] = React.createElement(ExpressionPillView, {
                    text = expressionText(content),
                    content = content,
                    layoutOrder = layoutOrder,
                    cooldownDurationSeconds = tbl1.cooldownDurationSeconds,
                    cooldownEndsAt = cooldownEndsAt,
                    onActivated = tbl1.onExpressionActivated,
                    buttonRef = if bool2 then buttonRef else nil
                })
            end

            local nextOrder2 = createNextOrder()
            local var2 = "Category_" .. value.categoryId
            local createElement = React.createElement
            local view = Foundation.View
            local tbl5 = {
                LayoutOrder = nextOrder(),
                tag = "col gap-small size-full-0 auto-y"
            }
            local tbl6 = {
                Header = React.createElement(Foundation.Text, {
                    LayoutOrder = nextOrder2(),
                    Text = value.name or value.categoryId,
                    tag = "size-full-0 auto-y text-label-medium text-align-x-left content-default"
                }),
                Messages = React.createElement(Foundation.View, {
                    LayoutOrder = nextOrder2(),
                    tag = "size-full-0 auto-y",
                    layout = {
                        FillDirection = Enum.FillDirection.Horizontal,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, 8),
                        Wraps = true
                    }
                }, tbl4)
            }
            tbl3[var2] = createElement(view, tbl5, tbl6)
        end
    end

    local footerText = if var1 and var1.footerText then var1.footerText else tbl1.footerText

    if footerText then
        tbl3.Footer = React.createElement(Foundation.Text, {
            LayoutOrder = nextOrder(),
            Text = footerText,
            TextWrapped = true,
            tag = "size-full-0 auto-y text-body-small text-align-x-left content-muted",
            selection = tbl1.focusNavEnabled == true and { Selectable = true } or nil
        })
    end

    local nextOrder2 = createNextOrder()
    local createElement = React.createElement
    local view = Foundation.View
    local tbl4 = { tag = "col size-full" }

    local tbl5 = {
        Header = React.createElement(ExpressionTabBar, {
            LayoutOrder = nextOrder2(),
            tabs = tabs,
            activeTabId = tbl1.activeGroupId,
            onTabActivated = tbl1.onGroupActivated,
            onKeyboardActivated = tbl1.onKeyboardActivated,
            showKeyboardButton = tbl1.layoutMode == "Tray" and tbl1.canLocalUserChat,
            focusNavEnabled = tbl1.focusNavEnabled == true
        }),
        Divider = React.createElement(Foundation.Divider, { LayoutOrder = nextOrder2() }),
        Scroll = React.createElement(
            Foundation.ScrollView,
            {
                LayoutOrder = nextOrder2(),
                tag = "grow size-full-0",
                scroll = {
                    scrollBarVisibility = Foundation.Enums.ScrollBarVisibility.Always,
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    CanvasSize = UDim2.fromScale(0, 0)
                },
                selection = tbl1.focusNavEnabled and { Selectable = false } or nil
            },
            {
                Categories = React.createElement(Foundation.View, { tag = "col gap-large size-full-0 auto-y padding-large" }, tbl3)
            }
        )
    }
    return createElement(view, tbl4, tbl5)
end

local function buildFlyOut(tbl1, arg1)
    local createElement = React.createElement
    local var1 = ExpressionFlyOutView
    local tbl2 = {
        isOpen = tbl1.isOpen,
        focusNavEnabled = tbl1.focusNavEnabled,
        onPressedOutside = tbl1.onPressedOutside,
        anchorContent = 0,
        content = 0,
        contentRef = 0
    }
    local entryButtonRef = if arg1 then arg1.entryButtonRef else nil
    tbl2.anchorContent = buildEntryButton(tbl1, entryButtonRef)
    tbl2.content = buildContent(tbl1, if arg1 then arg1.defaultFocusRef else nil)
    tbl2.contentRef = if arg1 then arg1.containerRef else nil
    return createElement(var1, tbl2)
end

return React.memo(function(tbl1) -- name: ExpressionTrayView
    if not tbl1.isVisible then
        return nil
    end

    local layoutMode = tbl1.layoutMode or "FlyOut"
    local variant = tbl1.variant or "entry"

    if variant == "overlay" and layoutMode ~= "Tray" then
        return nil
    elseif variant == "entry" and layoutMode == "Tray" then
        return buildEntryButton(tbl1, nil)
    elseif variant == "overlay" then
        return React.createElement(
            ExpressionSheetView,
            {
                isOpen = tbl1.isOpen,
                onPressedOutside = tbl1.onPressedOutside,
                content = buildContent(tbl1, nil)
            }
        )
    elseif tbl1.focusNavEnabled == true then
        return React.createElement(ExpressionTrayFocusRoot, {
            isOpen = tbl1.isOpen,
            render = function(arg1)
                return buildFlyOut(tbl1, arg1)
            end
        })
    end
    return buildFlyOut(tbl1, nil)
end)

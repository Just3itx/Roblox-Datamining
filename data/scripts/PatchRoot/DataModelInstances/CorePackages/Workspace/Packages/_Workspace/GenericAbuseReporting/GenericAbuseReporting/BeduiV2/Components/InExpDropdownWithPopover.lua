-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local FocusNavigationUtils = require(GenericAbuseReportingParent.FocusNavigationUtils)
local Foundation = require(GenericAbuseReportingParent.Foundation)
local InputHandlers = require(GenericAbuseReportingParent.InputHandlers)
local React = require(GenericAbuseReportingParent.React)
local _ReactFocusNavigation = require(GenericAbuseReportingParent.ReactFocusNavigation)

local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local FocusRoot = FocusNavigationUtils.FocusRoot
local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local Popover = Foundation.Popover
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide
local Radius = Foundation.Enums.Radius
local FoundationText = Foundation.Text
local View = Foundation.View

local SideModalDropdownButton = require(GenericAbuseReporting.Common.SideModalDropdownButton)

local side = {
    position = PopoverSide.Bottom,
    offset = 5
}

return React.memo(function(tbl2) -- name: InExpDropdownWithPopover
    local var1, var2 = React.useState(false)
    local var3 = React.useRef(nil)
    local var4, var5 = React.useState(0)

    local onOpenChange = tbl2.onOpenChange
    local var6 = React.useCallback(function(bool1: boolean)
        if onOpenChange then
            onOpenChange(bool1)
        end
        var2(bool1)
    end, { onOpenChange })

    local var7 = React.useMemo(function()
        if tbl2.value == nil then
            return nil
        end
        for _, item in tbl2.items do
            if item.id == tbl2.value then
                return item
            end
        end
        return nil
    end, { tbl2.items, tbl2.value })

    local onActivated = React.useCallback(function()
        var6(not var1)
    end, { var1, var6 })

    local onPressedOutside = React.useCallback(function()
        var6(false)
    end, { var6 })

    local eventHandlers = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(onPressedOutside)
            }
        }
    end, { onPressedOutside })

    local text = if var7 then var7.text else tbl2.placeholder or ""
    local items = tbl2.items
    local onItemChanged = tbl2.onItemChanged
    local value = tbl2.value
    local var12 = React.useMemo(function()
        local result = ({})
        for layoutOrder, item in items do
            local id = item.id
            local bool1 = id == value
            local str1 = `item-{tostring(id)}`
            local createElement = React.createElement
            local var12 = View

            local tbl3 = {
                LayoutOrder = layoutOrder,
                onActivated = function()
                    var6(false)
                    onItemChanged(id)
                end,
                selection = { Selectable = true },
                tag = {
                    ["row flex-between size-full-0 auto-y padding-small radius-medium"] = true,
                    ["bg-shift-200"] = bool1
                }
            }

            local tbl4 = {
                Text = React.createElement(
                    FoundationText,
                    {
                        Text = item.text,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextWrapped = true,
                        tag = "auto-xy",
                        LayoutOrder = 1
                    }
                ),
                Check = if bool1 then React.createElement(Icon, { name = IconName.CheckLarge, LayoutOrder = 2 }) or nil else nil
            }
            result[str1] = createElement(var12, tbl3, tbl4)
        end

        return result
    end, {
        items,
        value,
        onItemChanged,
        var6
    })
    return React.createElement(View, {
        tag = "size-full-0 auto-y padding-top-xxsmall",
        ref = var3,
        onAbsoluteSizeChanged = function(arg1)
            var5(arg1.AbsoluteSize.X)
        end,
        LayoutOrder = tbl2.LayoutOrder
    }, {
        Popover = React.createElement(Popover.Root, { isOpen = var1 }, {
            Trigger = React.createElement(SideModalDropdownButton, { onActivated = onActivated, text = text }),
            Anchor = React.createElement(Popover.Anchor, { anchorRef = var3 }),
            Menu = React.createElement(
                Popover.Content,
                {
                    align = PopoverAlign.End,
                    side = side,
                    hasArrow = false,
                    onPressedOutside = onPressedOutside,
                    radius = Radius.Medium
                },
                React.createElement(FocusRoot, {
                    surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.ModerationOverlay,
                    isFocusable = var1,
                    isAutoFocusRoot = var1,
                    isIsolated = var1,
                    eventHandlers = eventHandlers
                }, {
                    Menu = React.createElement(View, {
                        Size = UDim2.new(0, var4 - 2, 0, -2),
                        tag = "col align-x-center align-y-center gap-xsmall auto-y padding-xsmall stroke-default radius-medium"
                    }, var12)
                })
            )
        })
    })
end)

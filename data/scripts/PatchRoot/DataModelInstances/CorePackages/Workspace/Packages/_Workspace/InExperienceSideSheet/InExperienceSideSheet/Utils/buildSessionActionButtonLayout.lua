-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:31:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")
local InExperienceSideSheetParent = InExperienceSideSheet.Parent

local React = require(InExperienceSideSheetParent.React)

local View = require(InExperienceSideSheetParent.Foundation).View

local Enums = require(InExperienceSideSheet.Common.Enums)
local _Types = require(InExperienceSideSheet.Common.Types)
local ShortcutButton = require(InExperienceSideSheet.Components.ShortcutButton)
local FFlagSideSheetEmphasizeLeave = require(InExperienceSideSheet.Flags).FFlagSideSheetEmphasizeLeave

local ButtonWidth = Enums.ButtonWidth

local function createShortcutButton(arg1, layoutOrder: number, width)
    return React.createElement(ShortcutButton, {
        label = arg1.label,
        getShortcutIcon = arg1.getShortcutIcon,
        getOnActivated = arg1.getOnActivated,
        getIsEnabled = arg1.getIsEnabled,
        width = width,
        layoutOrder = layoutOrder,
        isEmphasized = arg1.isEmphasized,
        testId = if FFlagSideSheetEmphasizeLeave then arg1.testId else nil
    })
end

local function buildHalfWidthRowLayoutItem(tbl1, layoutOrder: number)
    if #tbl1 == 1 then
        local var1 = tbl1[1]
        return {
            key = var1.name,
            node = createShortcutButton(var1, layoutOrder, ButtonWidth.Full)
        }
    end

    local tbl2 = {}
    for value, value2 in tbl1 do
        tbl2[value2.name] = createShortcutButton(value2, value, ButtonWidth.Half)
    end

    return {
        key = "HalfWidthRow_" .. layoutOrder,
        node = React.createElement(View, { tag = "row gap-small size-full-0 auto-y", LayoutOrder = layoutOrder }, tbl2)
    }
end

local function buildSessionActionButtonLayout(tbl1)
    local sessionActionButtonLayout = {}
    local num1 = 0
    local tbl2 = {}

    local function flushHalfRow() -- Luacid: Inlined by compiler; 3 call sites recovered
        if #tbl2 == 0 then
            return
        end

        num1 += 1
        local halfWidthRowLayoutItem = buildHalfWidthRowLayoutItem(tbl2, num1)
        sessionActionButtonLayout[halfWidthRowLayoutItem.key] = halfWidthRowLayoutItem.node
        table.clear(tbl2)
    end

    for _, value in tbl1 do
        if (value.width or ButtonWidth.Full) == ButtonWidth.Half then
            table.insert(tbl2, value)
            if #tbl2 == 2 then
                flushHalfRow()
            end
        else
            flushHalfRow()
            num1 += 1
            sessionActionButtonLayout[value.name] = createShortcutButton(value, num1, ButtonWidth.Full)
        end
    end

    flushHalfRow()
    return sessionActionButtonLayout
end

return buildSessionActionButtonLayout

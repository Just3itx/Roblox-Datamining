-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:11:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useChipVariants = require(Foundation.Components.Chip.useChipVariants)

local ChipSize = require(Foundation.Enums.ChipSize)

local ChipVariant = require(Foundation.Enums.ChipVariant)
local ColorNamespace = require(Foundation.Enums.ColorNamespace)
local PaginationSize = require(Foundation.Enums.PaginationSize)

local PresentationContext = require(Foundation.Providers.Style.PresentationContext)
local useTokens = require(Foundation.Providers.Style.useTokens)

local withCommonProps = require(Foundation.Utility.withCommonProps)

local scriptParentParent = script.Parent.Parent
local paginationUtils = require(scriptParentParent.paginationUtils)

local function PageNumberText(tbl1)
    return React.createElement(Text, {
        Text = tostring(tbl1.page),
        textStyle = tbl1.textStyle,
        tag = tbl1.textTag,
        padding = tbl1.padding,
        LayoutOrder = 1,
        testId = `{tbl1.testId}--text`
    })
end

local value = {
    colorNamespace = ColorNamespace.Color,
    isIconSize = true
}
local tbl2 = {
    [PaginationSize.Small] = "size-0-600",
    [PaginationSize.Medium] = "size-0-800"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: PageNumberSlot
    local var1 = useTokens()

    local bool1 = not arg1.isChecked
    local var2 = paginationUtils.needsWidePageSlot(arg1.page)
    local var3 = if arg1.slotSize == PaginationSize.Small then ChipSize.Small else ChipSize.Medium
    local var4 = useChipVariants(var1, var3, ChipVariant.Utility, true, false, false)
    local var5 = useChipVariants(var1, var3, ChipVariant.Utility, false, false, false)
    local tag = `row align-x-center align-y-center auto-x radius-circle {tbl2[arg1.slotSize]}`

    local var6 = React.useCallback(function()
        arg1.onPageActivated(arg1.page)
    end, { arg1.onPageActivated, arg1.page })

    local selection = {
        Selectable = bool1 and arg1.Selectable ~= false,
        NextSelectionLeft = arg1.NextSelectionLeft,
        NextSelectionRight = arg1.NextSelectionRight,
        NextSelectionUp = arg1.NextSelectionUp,
        NextSelectionDown = arg1.NextSelectionDown
    }

    if not var2 then
        local createElement = React.createElement
        local var7 = View
        local var8 = withCommonProps
        local tbl4 = {
            LayoutOrder = arg1.LayoutOrder,
            testId = arg1.testId
        }
        local tbl5 = {
            backgroundStyle = {
                Color3 = var1.Color.Surface.Surface_0.Color3,
                Transparency = 1
            },
            cursor = if bool1 then paginationUtils.getSlotCursor(var1) else nil,
            onActivated = 0,
            ref = 0,
            selection = 0,
            tag = 0
        }

        if not bool1 then
            var6 = nil
        end

        tbl5.onActivated = var6
        tbl5.ref = ref
        tbl5.selection = not bool1 and { Selectable = false } or selection

        tbl5.tag = paginationUtils.getCircularSlotTag(arg1.slotSize)
        local var9 = var8(tbl4, tbl5)

        local tbl6 = {
            Text = React.createElement(PageNumberText, {
                page = arg1.page,
                textStyle = if arg1.isChecked then var4.text.contentStyle else var1.Color.Content.Default,
                textTag = paginationUtils.getPageLabelTextTag(arg1.slotSize),
                padding = nil,
                testId = arg1.testId
            })
        }
        return createElement(var7, var9, tbl6)
    end

    if not bool1 then
        return React.createElement(
            View,
            withCommonProps({
                LayoutOrder = arg1.LayoutOrder,
                testId = arg1.testId
            }, {
                backgroundStyle = var4.chip.backgroundStyle,
                padding = var4.chip.padding,
                ref = ref,
                selection = { Selectable = false },
                tag = tag
            }),
            {
                Text = React.createElement(PageNumberText, {
                    page = arg1.page,
                    textStyle = var4.text.contentStyle,
                    textTag = var4.text.tag,
                    padding = var4.text.padding,
                    testId = arg1.testId
                })
            }
        )
    end

    return React.createElement(
        View,
        withCommonProps({
            LayoutOrder = arg1.LayoutOrder,
            testId = arg1.testId
        }, {
            backgroundStyle = var5.chip.backgroundStyle,
            padding = var5.chip.padding,
            cursor = paginationUtils.getSlotCursor(var1),
            onActivated = var6,
            ref = ref,
            selection = selection,
            tag = tag
        }),
        {
            Label = React.createElement(PresentationContext.Provider, { value = value }, {
                Text = React.createElement(PageNumberText, {
                    page = arg1.page,
                    textStyle = var5.text.contentStyle,
                    textTag = var5.text.tag,
                    padding = var5.text.padding,
                    testId = arg1.testId
                })
            })
        }
    )
end))

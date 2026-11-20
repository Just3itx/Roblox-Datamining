-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:11:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BuilderIcons = require(FoundationParent.BuilderIcons)
local React = require(FoundationParent.React)

local ButtonVariant = require(Foundation.Enums.ButtonVariant)
local IconButton = require(Foundation.Components.IconButton)
local InputSize = require(Foundation.Enums.InputSize)

local PaginationDirection = require(Foundation.Enums.PaginationDirection)
local _Types = require(Foundation.Components.Types)

local PaginationSize = require(Foundation.Enums.PaginationSize)

local Icon = BuilderIcons.Icon

local tbl1 = {
    [PaginationDirection.First] = {
        icon = Icon.ChevronSmallLeftToLine,
        testIdSuffix = "first"
    },
    [PaginationDirection.Backward] = {
        icon = Icon.ChevronSmallLeft,
        testIdSuffix = "back"
    },
    [PaginationDirection.Forward] = {
        icon = Icon.ChevronSmallRight,
        testIdSuffix = "forward"
    },
    [PaginationDirection.Last] = {
        icon = Icon.ChevronSmallRightToLine,
        testIdSuffix = "last"
    }
}

local function getInputSize(small) -- Luacid: Inlined by compiler; 1 call site recovered
    return if small == PaginationSize.Small then InputSize.XSmall else InputSize.Small
end

return React.memo(React.forwardRef(function(arg1, ref) -- name: NavButton
    local var1 = tbl1[arg1.direction]
    local testId = `{arg1.baseTestId}--{var1.testIdSuffix}`

    local onActivated = React.useCallback(function()
        arg1.onDirectionActivated(arg1.direction)
    end, { arg1.onDirectionActivated, arg1.direction })

    return React.createElement(IconButton, {
        LayoutOrder = arg1.LayoutOrder,
        testId = testId,
        ref = ref,
        icon = var1.icon,
        size = getInputSize(arg1.slotSize),
        variant = ButtonVariant.Utility,
        isCircular = true,
        isDisabled = arg1.isDisabled,
        onActivated = onActivated,
        Selectable = arg1.Selectable,
        NextSelectionLeft = arg1.NextSelectionLeft,
        NextSelectionRight = arg1.NextSelectionRight,
        NextSelectionUp = arg1.NextSelectionUp,
        NextSelectionDown = arg1.NextSelectionDown
    })
end))

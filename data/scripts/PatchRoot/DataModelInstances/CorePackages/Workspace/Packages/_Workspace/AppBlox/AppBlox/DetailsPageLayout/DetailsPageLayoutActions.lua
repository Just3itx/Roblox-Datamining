-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent

local React = require(AppBloxParent.React)
local Foundation = require(AppBloxParent.Foundation)

local View = Foundation.View
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance

local DetailsPageLayoutContext = require(script.Parent.DetailsPageLayoutContext)

return React.memo(React.forwardRef(function(tbl1, ref) -- name: DetailsPageLayoutActions
    local var1 = React.useContext(DetailsPageLayoutContext)
    local setHasActions = var1.setHasActions
    local setActionBarHeight = var1.setActionBarHeight
    local testId = var1.testId

    assert(
        setHasActions and setActionBarHeight and testId,
        "DetailsPageLayout.Actions must be used within DetailsPageLayout.Root"
    )

    React.useEffect(function()
        setHasActions(true)
        return function()
            setHasActions(false)
            setActionBarHeight(0)
        end
    end, {})

    local createElement = React.createElement
    local var2 = View

    local tbl2 = {
        tag = "row size-full-0 auto-y bg-surface-0 stroke-muted stroke-standard position-bottom-left anchor-bottom-left align-y-center gap-small align-x-center padding-top-large padding-bottom-medium padding-x-large",
        onAbsoluteSizeChanged = function(arg1)
            setActionBarHeight(arg1.AbsoluteSize.Y)
        end,
        ZIndex = 2,
        testId = if testId then `{testId}--actions` else nil,
        onActivated = 0,
        selection = 0,
        stateLayer = 0,
        ref = 0
    }

    function tbl2.onActivated() end
    tbl2.selection = { Selectable = false }
    tbl2.stateLayer = {
        affordance = StateLayerAffordance.None
    }
    tbl2.ref = ref
    return createElement(var2, tbl2, tbl1.children)
end))

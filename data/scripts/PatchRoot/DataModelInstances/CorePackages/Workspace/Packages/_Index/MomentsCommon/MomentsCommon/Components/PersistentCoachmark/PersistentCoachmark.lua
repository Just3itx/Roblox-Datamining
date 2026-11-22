-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Foundation = require(scriptParentParentParentParent.Foundation)
local React = require(scriptParentParentParentParent.React)

local _createCoachmarkImpressionCache = require(scriptParentParentParent.Utils.createCoachmarkImpressionCache)
local usePersistentCoachmarkViewModel = require(scriptParent.usePersistentCoachmarkViewModel)

local EducationalTooltip = Foundation.EducationalTooltip

local function PersistentCoachmark(tbl1)
    local var1 = usePersistentCoachmarkViewModel({
        impressionCache = tbl1.impressionCache,
        maxImpressions = tbl1.maxImpressions,
        autoDismissSeconds = tbl1.autoDismissSeconds,
        isSessionHandled = tbl1.isSessionHandled,
        onSessionHandled = tbl1.onSessionHandled,
        onImpression = tbl1.onImpression,
        onDismissed = tbl1.onDismissed
    })

    return React.createElement(EducationalTooltip, {
        LayoutOrder = tbl1.layoutOrder,
        isOpen = var1.isOpen and not tbl1.hidden,
        onClose = var1.onClose,
        side = tbl1.side or Foundation.Enums.PopoverSide.Bottom,
        align = tbl1.align or Foundation.Enums.PopoverAlign.End,
        title = tbl1.title,
        text = tbl1.text
    }, tbl1.children)
end

return PersistentCoachmark

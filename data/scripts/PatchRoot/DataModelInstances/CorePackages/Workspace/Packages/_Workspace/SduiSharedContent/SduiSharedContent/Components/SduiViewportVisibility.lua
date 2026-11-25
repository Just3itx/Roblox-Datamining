-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:01:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local ViewportVisibilityImpressionsDetector = require(SduiSharedContentParent.Impressions).ViewportVisibilityImpressionsDetector

local View = Foundation.View

return React.memo(function(tbl1) -- name: SduiViewportVisibility
    local targetRef = React.useRef(nil)
    local bool1 = tbl1.onView ~= nil

    local threshold = math.clamp(tbl1.visibilityThreshold or 0.5, 0.01, 1)

    local content = React.createElement(View, {
        tag = tbl1.tag or "size-full-0 auto-y",
        LayoutOrder = tbl1.layoutOrder,
        Visible = tbl1.visible,
        ref = if bool1 then targetRef else nil
    }, {
        Content = tbl1.contentComponent
    })

    if not bool1 then
        return content
    end

    return React.createElement(React.Fragment, nil, {
        Content = content,
        Detector = React.createElement(
            ViewportVisibilityImpressionsDetector,
            {
                targetRef = targetRef,
                onImpression = tbl1.onView,
                threshold = threshold
            }
        )
    })
end)

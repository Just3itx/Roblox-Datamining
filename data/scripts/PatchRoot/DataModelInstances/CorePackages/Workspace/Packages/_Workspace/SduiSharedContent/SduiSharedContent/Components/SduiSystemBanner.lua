-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local ViewportVisibilityImpressionsDetector = require(SduiSharedContentParent.Impressions).ViewportVisibilityImpressionsDetector

local SystemBanner = Foundation.SystemBanner

local FFlagAppChatConversationTrustedFriendUpsellBanner = require(SduiSharedContentParent.SharedFlags).FFlagAppChatConversationTrustedFriendUpsellBanner

return React.memo(function(tbl1) -- name: SduiSystemBanner
    local var1, var2

    if FFlagAppChatConversationTrustedFriendUpsellBanner then
        var1 = React.useRef(nil)
        if tbl1.onView == nil then
            var2 = false
        else
            var2 = true
        end
    else
        var2 = nil
        var1 = nil
    end

    local banner = React.createElement(SystemBanner, {
        severity = tbl1.severity,
        variant = tbl1.variant,
        title = tbl1.title,
        description = tbl1.description,
        actions = tbl1.actions,
        onClose = tbl1.onClose,
        AnchorPoint = tbl1.anchorPoint,
        LayoutOrder = tbl1.layoutOrder,
        Position = tbl1.position,
        Visible = tbl1.visible,
        ZIndex = tbl1.zIndex,
        testId = tbl1.testId,
        ref = if var2 then var1 else nil
    })

    if not var2 then
        return banner
    end

    return React.createElement(React.Fragment, nil, {
        Banner = banner,
        OnViewDetector = React.createElement(ViewportVisibilityImpressionsDetector, { targetRef = var1, onImpression = tbl1.onView })
    })
end)

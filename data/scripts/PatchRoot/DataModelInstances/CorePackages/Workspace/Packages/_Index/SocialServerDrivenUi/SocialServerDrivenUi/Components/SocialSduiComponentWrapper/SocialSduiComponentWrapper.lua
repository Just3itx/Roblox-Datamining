-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialServerDrivenUiParent = script:FindFirstAncestor("SocialServerDrivenUi").Parent

local React = require(SocialServerDrivenUiParent.React)
local _AppCommonLib = require(SocialServerDrivenUiParent.AppCommonLib)
local Foundation = require(SocialServerDrivenUiParent.Foundation)
local getSduiComponentWrapper = require(SocialServerDrivenUiParent.SduiCoreSystem).getSduiComponentWrapper

local View = Foundation.View

return React.memo(function(tbl1) -- name: SocialSduiComponentWrapper
    local sduiComponentWrapper = getSduiComponentWrapper(tbl1.sduiComponentConfig)

    return React.createElement(
        View,
        {
            tag = "size-full-0 auto-y",
            LayoutOrder = tbl1.layoutOrder,
            onAbsoluteSizeChanged = tbl1.onFrameResized
        },
        {
            SocialSduiComponentWrapper = React.createElement(sduiComponentWrapper, {
                debugName = tbl1.debugName,
                componentConfig = tbl1.sduiComponentConfig,
                sduiContext = tbl1.sduiContext,
                extraLocalProps = {
                    index = tbl1.layoutOrder,
                    pageSideMargin = tbl1.pageSideMargin,
                    verticalScrollingFrameRef = tbl1.verticalScrollingFrameRef,
                    scrollViewPositionChangedSignal = tbl1.scrollViewPositionChangedSignal,
                    testId = tbl1.testId
                },
                localAnalyticsData = tbl1.analyticsContext
            })
        }
    )
end)

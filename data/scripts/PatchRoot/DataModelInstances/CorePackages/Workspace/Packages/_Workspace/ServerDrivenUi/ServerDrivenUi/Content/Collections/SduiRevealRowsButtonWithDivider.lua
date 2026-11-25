-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local React = require(ServerDrivenUiParent.React)
local Foundation = require(ServerDrivenUiParent.Foundation)

local getSduiComponentWrapper = require(ServerDrivenUiParent.SduiCoreSystem).getSduiComponentWrapper

return React.memo(function(tbl1) -- name: SduiRevealRowsButtonWithDivider
    local cta = React.createElement(getSduiComponentWrapper(tbl1.ctaComponent), {
        componentConfig = tbl1.ctaComponent,
        sduiContext = tbl1.sduiContext,
        debugName = "SduiRevealRowsButtonWithDivider.CtaComponent",
        extraLocalProps = {
            onActivated = tbl1.onActivated
        }
    })

    return React.createElement(
        Foundation.View,
        {
            tag = "row align-y-center gap-xsmall size-full-0 auto-y",
            LayoutOrder = tbl1.layoutOrder,
            ZIndex = tbl1.zIndex
        },
        {
            LeadingLine = React.createElement(
                Foundation.View,
                { tag = "grow", LayoutOrder = 1 },
                {
                    Divider = React.createElement(Foundation.Divider)
                }
            ),
            ButtonOutline = React.createElement(Foundation.View, { tag = "auto-xy stroke-default radius-circle", LayoutOrder = 2 }, { Cta = cta }),
            TrailingLine = React.createElement(
                Foundation.View,
                { tag = "grow", LayoutOrder = 3 },
                {
                    Divider = React.createElement(Foundation.Divider)
                }
            )
        }
    )
end)

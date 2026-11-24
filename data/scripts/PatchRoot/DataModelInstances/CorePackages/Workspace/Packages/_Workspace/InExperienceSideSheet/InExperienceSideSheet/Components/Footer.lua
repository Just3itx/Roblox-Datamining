-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")
local InExperienceSideSheetParent = InExperienceSideSheet.Parent

local React = require(InExperienceSideSheetParent.React)

local Foundation = require(InExperienceSideSheetParent.Foundation)
local Divider = Foundation.Divider
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local SessionActionButtons = require(InExperienceSideSheet.Components.SessionActionButtons)

return React.memo(function(tbl1) -- name: Footer
    local var1 = useTokens()

    return React.createElement(
        View,
        {
            tag = "col gap-xlarge size-full-0 auto-y padding-x-xlarge padding-bottom-xlarge",
            LayoutOrder = tbl1.layoutOrder
        },
        {
            FooterDivider = React.createElement(
                View,
                {
                    Size = UDim2.new(1, 0, 0, var1.Stroke.Standard),
                    testId = "side-sheet-footer-divider",
                    LayoutOrder = 1
                },
                {
                    DividerBleed = React.createElement(View, {
                        Position = UDim2.fromOffset(-var1.Padding.XLarge, 0),
                        Size = UDim2.new(1, var1.Padding.XLarge * 2, 1, 0),
                        testId = "side-sheet-footer-divider-bleed"
                    }, {
                        Divider = React.createElement(Divider)
                    })
                }
            ),
            SessionActionButtons = React.createElement(SessionActionButtons, { layoutOrder = 2 })
        }
    )
end)

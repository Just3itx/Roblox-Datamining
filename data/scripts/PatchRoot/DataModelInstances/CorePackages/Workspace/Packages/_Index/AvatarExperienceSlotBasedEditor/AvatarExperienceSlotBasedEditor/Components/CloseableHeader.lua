-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditorParent = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor").Parent

local React = require(AvatarExperienceSlotBasedEditorParent.React)
local Foundation = require(AvatarExperienceSlotBasedEditorParent.Foundation)
local useTokens = Foundation.Hooks.useTokens

return (React.forwardRef(function(tbl1, ref)
    local var1 = useTokens()

    return React.createElement(Foundation.View, {
        tag = "size-full row flex-between",
        Size = tbl1.Size,
        ZIndex = tbl1.ZIndex,
        LayoutOrder = tbl1.LayoutOrder,
        NextSelectionUp = tbl1.NextSelectionUp,
        NextSelectionDown = tbl1.NextSelectionDown,
        backgroundStyle = var1.Color.Surface.Surface_0,
        ref = ref,
        padding = tbl1.padding
            and {
                left = UDim.new(0, tbl1.padding.left or 0),
                right = UDim.new(0, tbl1.padding.right or 0),
                top = UDim.new(0, tbl1.padding.top or 0),
                bottom = UDim.new(0, tbl1.padding.bottom or 0)
            }
            or nil
    }, {
        Title = React.createElement(
            Foundation.Text,
            {
                Text = tbl1.text or "",
                tag = "auto-xy text-align-x-left text-heading-small",
                LayoutOrder = 1
            }
        ),
        CloseButton = React.createElement(Foundation.View, {
            tag = "auto-xy",
            stateLayer = {
                affordance = Foundation.Enums.StateLayerAffordance.None
            },
            onActivated = tbl1.onClose,
            LayoutOrder = 2
        }, {
            ButtonImage = React.createElement(
                Foundation.Image,
                {
                    Image = "icons/navigation/close",
                    imageStyle = var1.Color.Content.Emphasis,
                    tag = "size-600-600"
                }
            )
        })
    })
end))

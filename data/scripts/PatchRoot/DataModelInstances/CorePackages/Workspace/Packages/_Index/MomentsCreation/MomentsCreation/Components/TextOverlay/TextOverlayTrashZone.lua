-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local BuilderIcons = require(MomentsCreationParent.BuilderIcons)
local Foundation = require(MomentsCreationParent.Foundation)
local React = require(MomentsCreationParent.React)

local View = Foundation.View
local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens

local FFlagMomentsTextOverlayDragToDeleteRefinement = require(MomentsCreation.Flags.FFlagMomentsTextOverlayDragToDeleteRefinement)

local reallyBlack = Color3.fromHex("121215")

local style = {
    Color3 = Color3.new(1, 1, 1),
    Transparency = 0.2
}

return React.forwardRef(function(tbl2, ref) -- name: TextOverlayTrashZone
    if not FFlagMomentsTextOverlayDragToDeleteRefinement then
        return React.createElement(View, {
            Active = false,
            ref = ref,
            tag = "position-bottom-center anchor-bottom-center auto-xy padding-large",
            testId = "moments-text-overlay-trash-zone",
            Visible = tbl2.visible == nil or tbl2.visible,
            ZIndex = tbl2.ZIndex or 20
        }, {
            ButtonScale = React.createElement(View, {
                Active = false,
                backgroundStyle = { Color3 = reallyBlack, Transparency = 0.35 },
                scale = tbl2.highlightScale or 1,
                Size = UDim2.fromOffset(40, 40),
                stateLayer = {
                    affordance = Foundation.Enums.StateLayerAffordance.None
                },
                tag = "row align-x-center align-y-center radius-circle",
                testId = "moments-text-overlay-trash"
            }, {
                Icon = React.createElement(Icon, { name = BuilderIcons.Icon.TrashCan, size = Foundation.Enums.IconSize.Small, style = style })
            })
        })
    end

    local var1 = useTokens()
    local createElement = React.createElement
    local var2 = View
    local tbl3 = {
        Active = false,
        ref = ref,
        tag = "position-bottom-center anchor-bottom-center auto-xy padding-large",
        testId = "moments-text-overlay-trash-zone",
        Visible = tbl2.visible == nil or tbl2.visible,
        ZIndex = tbl2.ZIndex or 20
    }
    local tbl4 = {
        ButtonScale = React.createElement(
            View,
            {
                Active = false,
                scale = tbl2.highlightScale or 1,
                tag = "col align-x-center gap-small auto-xy"
            },
            {
                Label = if tbl2.label then React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    tag = "auto-xy text-title-small",
                    Text = tbl2.label,
                    textStyle = var1.Color.ActionEmphasis.Foreground
                }) else nil,
                Circle = React.createElement(View, {
                    Active = false,
                    LayoutOrder = 2,
                    ref = tbl2.circleRef,
                    Size = UDim2.fromOffset(40, 40),
                    stateLayer = {
                        affordance = Foundation.Enums.StateLayerAffordance.None
                    },
                    tag = "row align-x-center align-y-center radius-circle bg-over-media-0",
                    testId = "moments-text-overlay-trash"
                }, {
                    Icon = React.createElement(Icon, {
                        name = BuilderIcons.Icon.TrashCan,
                        size = Foundation.Enums.IconSize.Small,
                        style = var1.Color.ActionEmphasis.Foreground
                    })
                })
            }
        )
    }
    return createElement(var2, tbl3, tbl4)
end)

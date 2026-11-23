-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:21:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarSwitcherParent = script:FindFirstAncestor("AvatarSwitcher").Parent

local React = require(AvatarSwitcherParent.React)
local Foundation = require(AvatarSwitcherParent.Foundation)
local FoundationCloudAssets = require(AvatarSwitcherParent.FoundationCloudAssets)
local useLocalization = require(AvatarSwitcherParent.Localization).Hooks.useLocalization

local pictogramsCollaborators = FoundationCloudAssets.Assets["pictograms/collaborators"]

function EmptyState(tbl1)
    local var1 = useLocalization(
        {
            noAvatars = "Feature.AvatarSwitcher.Message.NoAvatars",
            addAvatars = "Feature.AvatarSwitcher.Message.AddAvatars"
        }
    )

    return React.createElement(Foundation.View, { tag = "size-full" }, {
        Header = tbl1.headerSlot,
        Content = React.createElement(
            Foundation.View,
            { tag = "auto-xy position-center-center anchor-center-center col align-x-center" },
            {
                Image = React.createElement(Foundation.Image, {
                    Image = pictogramsCollaborators.assetId,
                    Size = UDim2.fromOffset(pictogramsCollaborators.size.X / 3, pictogramsCollaborators.size.Y / 3),
                    LayoutOrder = 1
                }),
                Text = React.createElement(
                    Foundation.Text,
                    {
                        tag = "auto-xy text-title-large padding-bottom-small",
                        Text = var1.noAvatars,
                        LayoutOrder = 2
                    }
                ),
                SubText = React.createElement(Foundation.Text, { tag = "auto-xy text-body-medium", Text = var1.addAvatars, LayoutOrder = 3 })
            }
        )
    })
end

return EmptyState

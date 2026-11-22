-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local _MomentsTypes = require(MomentsParent.MomentsTypes)
local React = require(MomentsParent.React)

local FFlagMomentsUseSharedReactions = require(Moments.Flags.FFlagMomentsUseSharedReactions)

local Sheet = Foundation.Sheet
local FoundationText = Foundation.Text
local View = Foundation.View

local LocalizationService = game:GetService("LocalizationService")

local Localization = require(MomentsParent.Localization)
local useLocalization = Localization.Hooks.useLocalization
local abbreviateCount = Localization.abbreviateCount
local Reaction = if FFlagMomentsUseSharedReactions then require(MomentsParent.Reactions.Reaction) else MomentsCommon.Components.Reaction
local ReactionSize = MomentsCommon.Enums.ReactionSize

local useConfiguration = require(Moments.Hooks.useConfiguration)

local tbl1 = { title = "Feature.Moments.Label.Reactions" }

local function ReactionsSheet(tbl2)
    local var1 = useLocalization(tbl1)
    local var2 = useConfiguration("android_tv_enabled", false)

    local var3 = React.useMemo(function()
        local result = ({})

        for layoutOrder, reactionCount in ipairs(tbl2.reactionCounts) do
            if reactionCount.count <= 0 then
                continue
            end

            local reaction = reactionCount.reaction
            local createElement = React.createElement
            local var3 = View

            local tbl3 = {
                Icon = React.createElement(Reaction, { reactionType = reactionCount.reaction, size = ReactionSize.XSmall, layoutOrder = 1 }),
                Count = React.createElement(FoundationText, {
                    Text = abbreviateCount(reactionCount.count, LocalizationService.RobloxLocaleId),
                    LayoutOrder = 2,
                    tag = "auto-xy text-body-medium content-emphasis"
                })
            }
            result[reaction] = createElement(var3, { tag = "row align-y-center gap-xsmall auto-xy padding-xsmall", LayoutOrder = layoutOrder }, tbl3)
        end

        return result
    end, { tbl2.reactionCounts })

    return React.createElement(
        Sheet.Root,
        {
            isOpen = true,
            onClose = tbl2.onClose,
            preferCenterSheet = true,
            size = Foundation.Enums.DialogSize.Large
        },
        {
            Header = React.createElement(Sheet.Header, nil, {
                Title = React.createElement(FoundationText, { Text = var1.title, tag = "auto-xy text-heading-small content-emphasis" })
            }),
            Content = React.createElement(Sheet.Content, var2 and { Selectable = false } or nil, {
                ReactionsContainer = React.createElement(View, { tag = "row wrap align-y-center gap-small size-full-0 auto-y padding-bottom-large" }, var3)
            })
        }
    )
end

return ReactionsSheet

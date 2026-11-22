-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Reactions = script:FindFirstAncestor("Reactions")
local ReactionsParent = Reactions.Parent

local Foundation = require(ReactionsParent.Foundation)
local React = require(ReactionsParent.React)

local Reaction = require(Reactions.Components.Reaction)
local _ReactionType = require(Reactions.Enums.ReactionType)
local abbreviateReactionCount = require(Reactions.Utils.abbreviateReactionCount)
local getTopReactions = require(Reactions.Utils.getTopReactions)

local Image = Foundation.Image
local FoundationText = Foundation.Text
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens
local getRbxThumb = Foundation.Utility.getRbxThumb
local ThumbnailSize = Foundation.Enums.ThumbnailSize
local ThumbnailType = Foundation.Enums.ThumbnailType

local function ReactionChip(tbl1)
    local var1 = useTokens()
    local testId = tbl1.testId or "reaction-chip"

    local var2 = React.useMemo(function()
        return getTopReactions(tbl1.reactionCounts, 3)
    end, { tbl1.reactionCounts })

    local var3 = React.useMemo(function()
        return {
            radius = UDim.new(0, var1.Radius.Circle),
            offset = var1.Size.Size_150,
            borderWidth = var1.Stroke.Thicker
        }
    end, { var1 })

    if var2.totalCount <= 0 then
        return nil
    end

    local uDim2 = UDim2.fromOffset(var1.Size.Size_400, var1.Size.Size_400)
    local bool1 = not (tbl1.userIds == nil) and #tbl1.userIds > 0
    local tbl2 = {}

    for layoutOrder, reactionType in var2.reactions do
        local createElement = React.createElement
        local var4 = Reaction
        local tbl3 = {
            reactionType = reactionType,
            Size = uDim2,
            LayoutOrder = layoutOrder,
            testId = `{testId}--reaction`
        }
        tbl2[reactionType] = createElement(var4, tbl3)
    end

    if bool1 then
        local userIds = tbl1.userIds
        local userIdsLen = #userIds

        for i = 1, math.min(2, userIdsLen) do
            local str1 = `Avatar{i}`
            tbl2[str1] = React.createElement(Image, {
                Image = getRbxThumb(ThumbnailType.AvatarHeadShot, userIds[i], ThumbnailSize.Small),
                tag = "size-400-400 radius-circle bg-shift-300",
                LayoutOrder = i + 3,
                testId = `{testId}--avatar`
            })
        end
    elseif var2.totalCount > 1 then
        local var4 = tbl1.localizeCount or abbreviateReactionCount
        tbl2.Count = React.createElement(FoundationText, {
            Text = var4(var2.totalCount),
            tag = "auto-xy text-label-medium content-emphasis",
            LayoutOrder = 4,
            testId = `{testId}--count`
        })
    end

    local createElement = React.createElement
    local var4 = View
    local tbl3 = {
        tag = "size-0-800 auto-x padding-xxsmall radius-circle",
        backgroundStyle = tbl1.borderStyle or var1.Color.Surface.Surface_0,
        LayoutOrder = tbl1.layoutOrder
    }
    local tbl4 = { Chip = 0 }
    local createElement2 = React.createElement
    local var5 = View
    local tbl5 = {
        tag = "row align-y-center gap-xsmall size-0-full auto-x padding-x-small radius-circle bg-surface-300",
        onActivated = tbl1.onActivated,
        cursor = 0,
        testId = 0
    }

    if not tbl1.onActivated then
        var3 = nil
    end

    tbl5.cursor = var3
    tbl5.testId = testId
    tbl4.Chip = createElement2(var5, tbl5, tbl2)
    return createElement(var4, tbl3, tbl4)
end

return ReactionChip

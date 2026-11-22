-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T17:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCards = script:FindFirstAncestor("SocialCards")
local SocialCardsParent = SocialCards.Parent

local RoactUtils = require(SocialCardsParent.RoactUtils)

local FFlagEnableCallCard = require(SocialCards.Flags.FFlagEnableCallCard)
local createLazyComponent = RoactUtils.Components.createLazyComponent

local CardComponent = {
    scheduled_group_up = createLazyComponent(function()
        return require(SocialCards.Components).ScheduledSquadCard
    end),
    group_up = createLazyComponent(function()
        return require(SocialCards.Components).SquadCard.SquadCard
    end)
}

if FFlagEnableCallCard then
    CardComponent.call = createLazyComponent(function()
        return require(SocialCards.Components.CallCard)
    end)
end

return { CardComponent = CardComponent }

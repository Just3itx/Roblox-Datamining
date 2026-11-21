-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCard = script:FindFirstAncestor("GameJoinCard")
local GameJoinCardParent = GameJoinCard.Parent

local React = require(GameJoinCardParent.React)

local MobileGameJoinCard = require(GameJoinCard.Components.MobileGameJoinCard.MobileGameJoinCard)
local useInExperienceGameJoinCardViewModel = require(script.Parent.useInExperienceGameJoinCardViewModel)
local _Types = require(script.Parent.Types)

local function InExperienceGameJoinCard(arg1)
    local var1 = useInExperienceGameJoinCardViewModel(arg1)
    return React.createElement(MobileGameJoinCard, var1)
end

return InExperienceGameJoinCard

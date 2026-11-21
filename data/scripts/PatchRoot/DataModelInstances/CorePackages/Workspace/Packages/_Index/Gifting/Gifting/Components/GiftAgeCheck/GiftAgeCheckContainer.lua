-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GiftingParent = script:FindFirstAncestor("Gifting").Parent
local React = require(GiftingParent.React)

local GiftAgeCheckView = require(script.Parent.GiftAgeCheckView)
local useGiftAgeCheckViewModel = require(script.Parent.useGiftAgeCheckViewModel)

local function GiftAgeCheckContainer(arg1)
    local var1 = useGiftAgeCheckViewModel(arg1)
    return React.createElement(GiftAgeCheckView, var1)
end

return GiftAgeCheckContainer

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local _React = require(MomentsParent.React)

local useEdpVideoEligibilityViewModel = require(script.Parent.useEdpVideoEligibilityViewModel)

local function EdpVideoEligibilityContainer(arg1)
    local var1 = useEdpVideoEligibilityViewModel({ momentId = arg1.momentId, universeId = arg1.universeId })

    if var1.status == "Loading" then
        return arg1.loadingContent
    elseif var1.status == "Eligible" then
        return arg1.content
    end

    return nil
end

return EdpVideoEligibilityContainer

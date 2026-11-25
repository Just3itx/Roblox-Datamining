-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialUpsell = script:FindFirstAncestor("SocialUpsell")
local SocialUpsellParent = SocialUpsell.Parent

local React = require(SocialUpsellParent.React)

local GetAgeVerifiedChangedSignal = require(SocialUpsell.Signals.GetAgeVerifiedChangedSignal)

return function(func1: ((...any) -> (...any))?)
    React.useEffect(function()
        local ageVerifiedChangedSignal = GetAgeVerifiedChangedSignal()

        if func1 then
            ageVerifiedChangedSignal:connect(func1)
        end
        return function() end
    end, { func1 })
    return nil
end

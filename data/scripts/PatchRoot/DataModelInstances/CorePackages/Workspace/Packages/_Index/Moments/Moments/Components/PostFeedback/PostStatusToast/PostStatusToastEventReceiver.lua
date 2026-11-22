-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)

local sendrPostStatusToast = require(script.Parent.sendrPostStatusToast)

local function PostStatusToastEventReceiver()
    React.useEffect(function()
        return sendrPostStatusToast.listen(function(arg1)
            if not sendrPostStatusToast.isFailure(arg1) then
                sendrPostStatusToast.dismiss(arg1)
            end
        end)
    end, {})
    return nil
end

return PostStatusToastEventReceiver

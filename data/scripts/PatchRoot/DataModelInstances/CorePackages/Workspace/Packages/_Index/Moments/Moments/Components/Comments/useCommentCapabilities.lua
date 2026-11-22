-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local MomentsCommon = require(MomentsParent.MomentsCommon)
local SharedFlags = require(MomentsParent.SharedFlags)
local SignalsReact = require(MomentsParent.SignalsReact)

local GetMomentsCapabilities = MomentsCommon.Stores.GetMomentsCapabilities

local FFlagMomentsComments = SharedFlags.FFlagMomentsComments
local FFlagMomentsCommentsIxpEnabled = SharedFlags.FFlagMomentsCommentsIxpEnabled

local var1 = table.freeze({ canRead = true, canWrite = true, canReact = true })

return if FFlagMomentsComments or FFlagMomentsCommentsIxpEnabled then function() -- name: useGuacCommentCapabilities
    local momentsCapabilities = GetMomentsCapabilities(false)
    return {
        canRead = SignalsReact.useSignalState(momentsCapabilities.getCanReadComments),
        canWrite = SignalsReact.useSignalState(momentsCapabilities.getCanWriteComments),
        canReact = SignalsReact.useSignalState(momentsCapabilities.getCanReactToComments)
    }
end else function() -- name: useAllowedCommentCapabilities
    return var1
end

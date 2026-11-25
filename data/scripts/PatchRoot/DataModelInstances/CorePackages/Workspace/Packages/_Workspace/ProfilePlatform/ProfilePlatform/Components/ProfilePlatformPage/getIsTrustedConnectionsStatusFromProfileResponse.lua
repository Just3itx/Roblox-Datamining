-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local viewerRelationshipUtils = require(script.Parent.viewerRelationshipUtils)

local function getIsTrustedConnectionsStatusFromProfileResponse(arg1)
    local viewerRelationshipFromProfileResponse = viewerRelationshipUtils.getViewerRelationshipFromProfileResponse(arg1)
    if viewerRelationshipFromProfileResponse then
        return viewerRelationshipUtils.isViewerTrustedFriendsFromViewerRelationship(viewerRelationshipFromProfileResponse)
    end
    return false
end

return getIsTrustedConnectionsStatusFromProfileResponse

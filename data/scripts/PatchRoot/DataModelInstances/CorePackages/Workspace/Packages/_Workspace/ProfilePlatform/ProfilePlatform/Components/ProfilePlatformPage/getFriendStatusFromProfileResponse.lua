-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local viewerRelationshipUtils = require(script.Parent.viewerRelationshipUtils)

local function getFriendStatusFromProfileResponse(arg1)
    local viewerRelationshipFromProfileResponse = viewerRelationshipUtils.getViewerRelationshipFromProfileResponse(arg1)
    local contextualInformationFromProfileResponse = viewerRelationshipUtils.getContextualInformationFromProfileResponse(arg1)
    return viewerRelationshipUtils.mapViewerRelationshipAndContextToAnalyticsFriendStatus(
        viewerRelationshipFromProfileResponse,
        contextualInformationFromProfileResponse
    )
end

return getFriendStatusFromProfileResponse

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:31:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupsParent = script:FindFirstAncestor("Groups").Parent

local SduiSharedUtilities = require(GroupsParent.SduiSharedUtilities)
local _getGroupOverviewPaneConfig = require(script.Parent.getGroupOverviewPaneConfig)

local function fetchGroupOverviewPane(arg1, loadTimer, bool1: boolean?)
    local groupOverviewPage = require(GroupsParent.ServiceContractsProto).apppageplatform.groups.group_overview_page

    return SduiSharedUtilities.getSduiApiStore().fetchIfNeeded({
        responseType = SduiSharedUtilities.SduiResponseType.Protobuf,
        url = arg1.url,
        surfaceKey = arg1.surfaceKey,
        configKey = arg1.configKey,
        loadTimer = loadTimer,
        apiProto = groupOverviewPage.GroupOverviewPageResponse,
        postConfig = {
            contentType = SduiSharedUtilities.SduiApiStorePostConfigContentType.Proto,
            protoMessage = groupOverviewPage.GroupOverviewPageRequest,
            body = {
                group_id = arg1.groupId,
                client_capabilities = SduiSharedUtilities.SduiCapabilities.buildClientCapabilities(),
                cached_roblox_component_to_template_id = SduiSharedUtilities.getSduiTemplateStore().getCachedRobloxComponentToTemplateId(arg1.surfaceKey)
            }
        },
        enableTemplateCache = true,
        allowNoConfigsBuilt = true
    }, bool1)
end

return fetchGroupOverviewPane

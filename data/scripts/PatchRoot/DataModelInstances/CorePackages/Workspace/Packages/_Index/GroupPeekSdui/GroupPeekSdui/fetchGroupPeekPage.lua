-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:49:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupPeekSdui = script:FindFirstAncestor("GroupPeekSdui")
local GroupPeekSduiParent = GroupPeekSdui.Parent

local SduiSharedUtilities = require(GroupPeekSduiParent.SduiSharedUtilities)
local SduiResponseType = SduiSharedUtilities.SduiResponseType
local getSduiApiStore = SduiSharedUtilities.getSduiApiStore
local getSduiTemplateStore = SduiSharedUtilities.getSduiTemplateStore
local SduiLoadTimer = SduiSharedUtilities.SduiLoadTimer
local SduiApiStorePostConfigContentType = SduiSharedUtilities.SduiApiStorePostConfigContentType
local SduiCapabilities = SduiSharedUtilities.SduiCapabilities

local GroupPeekSduiConstants = require(GroupPeekSdui.GroupPeekSduiConstants)
local getGroupPeekPageUrl = require(GroupPeekSdui.getGroupPeekPageUrl)

local function fetchGroupPeekPage(groupId: string, bool1: boolean?)
    local url = getGroupPeekPageUrl(groupId)
    local configKey = GroupPeekSduiConstants.getConfigKey(groupId)
    local appPage = GroupPeekSduiConstants.AppPage
    local loadTimer = SduiLoadTimer.createLoadTimer(appPage)

    local groupPeekPage = require(GroupPeekSduiParent.ServiceContractsProto).apppageplatform.groups.group_peek_page

    local clientCapabilities = SduiCapabilities.buildClientCapabilities()

    local cachedRobloxComponentToTemplateId = getSduiTemplateStore().getCachedRobloxComponentToTemplateId(appPage)

    return getSduiApiStore().fetchIfNeeded({
        responseType = SduiResponseType.ProtobufJson,
        url = url,
        surfaceKey = appPage,
        configKey = configKey,
        loadTimer = loadTimer,
        apiProto = groupPeekPage.GroupPeekPageResponse,
        postConfig = {
            contentType = SduiApiStorePostConfigContentType.Proto,
            protoMessage = groupPeekPage.GroupPeekPageRequest,
            body = {
                group_id = groupId,
                client_capabilities = clientCapabilities,
                cached_roblox_component_to_template_id = cachedRobloxComponentToTemplateId
            }
        },
        enableTemplateCache = true,
        staleTimeSec = 30
    }, bool1)
end

return fetchGroupPeekPage

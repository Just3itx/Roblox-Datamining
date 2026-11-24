-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:31:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupsParent = script:FindFirstAncestor("Groups").Parent

local SduiSharedUtilities = require(GroupsParent.SduiSharedUtilities)
local _getGroupSduiPageConfig = require(script.Parent.getGroupSduiPageConfig)

local var1 = table.freeze({ GroupSidebarSection = { "group_sidebar_section_page", "GroupSidebarSectionPage" } })

local function fetchGroupSduiPage(arg1, loadTimer, bool1: boolean?, staleTimeSec: number?)
    local serviceContractsProto = require(GroupsParent.ServiceContractsProto)
    local var2, var3 = table.unpack(var1[arg1.surfaceKey])
    local group = serviceContractsProto.apppageplatform.groups[var2]
    local var4 = group[`{var3}Request`]
    local var5 = var4.new({
        group_id = arg1.groupId,
        client_capabilities = SduiSharedUtilities.SduiCapabilities.buildClientCapabilities(),
        cached_roblox_component_to_template_id = SduiSharedUtilities.getSduiTemplateStore().getCachedRobloxComponentToTemplateId(arg1.surfaceKey)
    })

    return SduiSharedUtilities.getSduiApiStore().fetchIfNeeded({
        responseType = SduiSharedUtilities.SduiResponseType.Protobuf,
        url = arg1.url,
        surfaceKey = arg1.surfaceKey,
        configKey = arg1.configKey,
        loadTimer = loadTimer,
        apiProto = group[`{var3}Response`],
        postConfig = {
            contentType = SduiSharedUtilities.SduiApiStorePostConfigContentType.Json,
            body = var4.jsonEncode(var5)
        },
        enableTemplateCache = true,
        staleTimeSec = staleTimeSec
    }, bool1)
end

return fetchGroupSduiPage

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function buildSettingsPageRequest(arg1, tbl1)
    local tbl2 = {}

    if tbl1 then
        tbl2.session_id = tbl1.sessionId
        tbl2.client_capabilities = tbl1.clientCapabilities

        if tbl1.cachedRobloxComponentToTemplateId then
            tbl2.cached_roblox_component_to_template_id = tbl1.cachedRobloxComponentToTemplateId
        end
    end

    return arg1.SettingsPageRequest.new(tbl2):jsonEncode()
end

return buildSettingsPageRequest

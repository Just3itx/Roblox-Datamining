-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:21:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContentProvider = game:GetService("ContentProvider")

local AcpProtocol = require(script.Parent.Parent.Acp.AcpProtocol)

local str1 = game:DefineFastString("MyStatsExperienceStatsBaseUrl", "")

local function buildRobloxlabsAcpUrl(num1: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    return `https://apis.sitetest{num1}.robloxlabs.com{AcpProtocol.ACP_PATH}`
end

local function parseSitetestRobloxlabsNumber(str2: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = string.match(str2, "sitetest(%d+)%.robloxlabs%.com")
    if var1 == nil then
        return nil
    end
    return tonumber(var1)
end

local function resolveCreatorAgentAcp()
    local url = str1
    if typeof(url) == "string" and url ~= "" then
        return {
            url = url,
            gateway = "robloxlabs-v1",
            sitetestNumber = parseSitetestRobloxlabsNumber(url)
        }
    end

    local success, result = pcall(function(): string
        return ContentProvider.BaseUrl
    end)
    if success and typeof(result) == "string" then
        local sitetestNumber = parseSitetestRobloxlabsNumber(result)

        if sitetestNumber ~= nil then
            return {
                url = buildRobloxlabsAcpUrl(sitetestNumber),
                gateway = "robloxlabs-v1",
                sitetestNumber = sitetestNumber
            }
        end
    end

    return {
        url = AcpProtocol.acpUrl(),
        gateway = "robloxlabs-v1",
        sitetestNumber = nil
    }
end

return {
    resolveCreatorAgentAcp = resolveCreatorAgentAcp,
    resolveCreatorAgentAcpUrl = function()
        return resolveCreatorAgentAcp().url
    end,
    parseSitetestRobloxlabsNumber = parseSitetestRobloxlabsNumber,
    buildRobloxlabsAcpUrl = buildRobloxlabsAcpUrl
}

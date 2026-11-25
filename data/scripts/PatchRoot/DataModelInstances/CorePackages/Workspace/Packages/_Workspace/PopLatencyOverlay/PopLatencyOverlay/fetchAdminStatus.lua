-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function fetchAdminStatus(arg1, arg2, httpService, arg3): boolean
    local var1 = string.match(arg3, "^https?://[^.]+%.([^/]+)")
    if var1 == nil then
        return false
    end

    local var2 = httpService:JSONDecode(
        (arg2:PostAsyncFullUrl(
            string.format("https://apis.%s/profile-platform-api/v1/profiles/get", var1),
            httpService:JSONEncode({
                profileType = "User",
                profileId = tostring(arg1),
                components = {{ component = "UserProfileHeader" }},
                includeComponentOrdering = false
            }),
            Enum.ThrottlingPriority.Default,
            Enum.HttpContentType.ApplicationJson,
            Enum.HttpRequestType.Players
        ))
    )
    local userProfileHeader = if type(var2) == "table" and type(var2.components) == "table" then var2.components.UserProfileHeader else nil
    return type(userProfileHeader) == "table" and userProfileHeader.isRobloxAdmin == true
end

return fetchAdminStatus

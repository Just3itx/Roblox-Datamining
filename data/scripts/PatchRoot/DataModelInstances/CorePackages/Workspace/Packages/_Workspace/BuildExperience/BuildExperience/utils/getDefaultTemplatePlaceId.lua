-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContentProvider = game:GetService("ContentProvider")

local bool1 = game:DefineFastFlag("BuildExperienceConfigurableProductionTemplatePlaceId", false)

local str1 = game:DefineFastString("BuildExperienceProductionTemplatePlaceId", "95206881")

local tbl1 = {
    sitetest3 = 70389767,
    sitetest1 = 75308808508742,
    production = bool1 and tonumber(str1) or 95206881
}

local function getDefaultTemplatePlaceId()
    local success, result = pcall(function(): string
        return ContentProvider.BaseUrl
    end)
    local var1 = if not success or typeof(result) ~= "string" then "" else result

    if string.find(var1, "sitetest3", 1, true) then
        return tbl1.sitetest3
    end

    if string.find(var1, "sitetest1", 1, true) then
        return tbl1.sitetest1
    end

    return tbl1.production
end

return getDefaultTemplatePlaceId

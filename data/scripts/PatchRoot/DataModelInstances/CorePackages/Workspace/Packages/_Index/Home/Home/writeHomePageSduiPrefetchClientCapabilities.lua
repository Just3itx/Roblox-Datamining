-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local AppStorageService = game:GetService("AppStorageService")

local function writeHomePageSduiPrefetchClientCapabilities(arg1)
    local str1 = HttpService:JSONEncode({ clientCapabilities = arg1:jsonEncode() })

    local success, result = pcall(function(): string
        return AppStorageService:GetItem("HomePageSduiCapabilities")
    end)
    if success and result == str1 then
        return
    end

    pcall(function()
        AppStorageService:SetItem("HomePageSduiCapabilities", str1)
        AppStorageService:Flush()
    end)
end

return writeHomePageSduiPrefetchClientCapabilities

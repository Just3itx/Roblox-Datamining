-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:04:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local MemStorageService = game:GetService("MemStorageService")
local NotificationService = game:GetService("NotificationService")
local BuildExperiencePlaytestLaunch = script:FindFirstAncestor("BuildExperiencePlaytestLaunch")
local FFlagBuildExperienceLibrary = require(BuildExperiencePlaytestLaunch.Parent.SharedFlags).FFlagBuildExperienceLibrary

local function normalizeSelectedTheme(selectedTheme) -- Luacid: Inlined by compiler; 2 call sites recovered
    if type(selectedTheme) == "string" then
        local str1 = string.lower(selectedTheme)
        if str1 == "light" or str1 == "dark" then
            return str1
        end
    end
    return nil
end

local module = {}
module.__index = module

function module.new()
    return (setmetatable({
        cachedResult = nil,
        cachedSelectedTheme = nil,
        cachedChatSessionId = nil,
        cachedChatPlaceId = nil,
        cachedTeamTestPlaceId = nil
    }, module))
end

function module:set(chatSessionId: string?, num1: number?, bool1: boolean?)
    local input = { hasBuildMode = true }
    if bool1 then
        input.teamTestPlaceId = num1
    end
    if FFlagBuildExperienceLibrary then
        self.cachedSelectedTheme = normalizeSelectedTheme(NotificationService.SelectedTheme) or self.cachedSelectedTheme
        input.selectedTheme = self.cachedSelectedTheme
        input.chatSessionId = chatSessionId
        input.chatPlaceId = num1
    end
    self.cachedResult = nil
    MemStorageService:SetItem("BuildExperienceLaunchData", HttpService:JSONEncode(input))
end

function module:clear()
    self.cachedResult = nil
    MemStorageService:SetItem("BuildExperienceLaunchData", "")
end

function module:hasBuildMode()
    if self.cachedResult ~= nil then
        return self.cachedResult
    end

    if FFlagBuildExperienceLibrary then
        self.cachedSelectedTheme = nil
        self.cachedChatSessionId = nil
        self.cachedChatPlaceId = nil
    end
    self.cachedTeamTestPlaceId = nil
    local item = MemStorageService:GetItem("BuildExperienceLaunchData")
    if item == "" then
        self.cachedResult = false
        return false
    end

    local success, result = pcall(HttpService.JSONDecode, HttpService, item)
    if not success or type(result) ~= "table" then
        self.cachedResult = false
        return false
    end

    MemStorageService:SetItem("BuildExperienceLaunchData", "")
    self.cachedResult = result.hasBuildMode == true
    if self.cachedResult and type(result.teamTestPlaceId) == "number" then
        self.cachedTeamTestPlaceId = result.teamTestPlaceId
    end
    if FFlagBuildExperienceLibrary and self.cachedResult then
        self.cachedSelectedTheme = normalizeSelectedTheme(result.selectedTheme)

        if type(result.chatSessionId) == "string" and result.chatSessionId ~= "" and type(result.chatPlaceId) == "number" then
            self.cachedChatSessionId = result.chatSessionId
            self.cachedChatPlaceId = result.chatPlaceId
        end
    end
    return self.cachedResult
end

function module:applyViewerTheme()
    self:hasBuildMode()
    if self.cachedSelectedTheme ~= nil then
        NotificationService.SelectedTheme = self.cachedSelectedTheme
    end
end

function module:getChatSessionId(cachedChatPlaceId: number)
    self:hasBuildMode()
    return if self.cachedChatPlaceId == cachedChatPlaceId then self.cachedChatSessionId else nil
end

function module:getTeamTestPlaceId()
    self:hasBuildMode()
    return self.cachedTeamTestPlaceId
end

return module

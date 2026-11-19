-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:51:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local function getCurrentUser(): string -- Luacid: Inlined by compiler; 1 call site recovered
    if not (Players.LocalPlayer and Players.LocalPlayer.UserId > 0) then
        return "0"
    end

    return tostring(Players.LocalPlayer.UserId)
end

local function getUserKey(userId): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return "u_" .. tostring(userId or "0")
end

local function getValuesForAllUsers(key: string): {[any]: any} | {default: string}
    local default = AppStorageService:GetItem(key)
    local success, result = pcall(function()
        return HttpService:JSONDecode(default)
    end)
    return if success and type(result) == "table" then result else { default = default }
end

local function setValuesForAllUsers(key: string, input) -- Luacid: Inlined by compiler; 1 call site recovered
    local str1 = HttpService:JSONEncode(input)
    AppStorageService:SetItem(key, str1)
end

local module = {}
module.__index = module

function module.new(arg1)
    arg1 = arg1 or getCurrentUser()

    local tbl1 = {
        userId = tostring(arg1)
    }
    setmetatable(tbl1, module)
    return tbl1
end

function module:GetItem(key)
    local valuesForAllUsers = getValuesForAllUsers(key)
    local valuesForAllUser = valuesForAllUsers[getUserKey(self.userId)]
    if valuesForAllUser == nil then
        valuesForAllUser = valuesForAllUsers.default
    end
    return valuesForAllUser
end

function module:SetItem(key, arg1)
    local valuesForAllUsers = getValuesForAllUsers(key)
    valuesForAllUsers[getUserKey(self.userId)] = arg1
    setValuesForAllUsers(key, valuesForAllUsers)
end

function module.Flush(_)
    AppStorageService:Flush()
end

module.getItem = module.GetItem
module.setItem = module.SetItem
module.flush = module.Flush

return module

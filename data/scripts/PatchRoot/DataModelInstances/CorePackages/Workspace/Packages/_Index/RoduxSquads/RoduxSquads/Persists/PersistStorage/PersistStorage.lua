-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MemStorageService = game:GetService("MemStorageService")
local HttpService = game:GetService("HttpService")

local module = {}
module.__index = module

function module.new(memStorageKey)
    return (setmetatable({ memStorageKey = memStorageKey }, module))
end

function module.getItem(arg1)
    local success, result = pcall(function()
        local item = MemStorageService:GetItem(arg1.memStorageKey)
        if item and item ~= "" then
            return HttpService:JSONDecode(item)
        end
        return nil
    end)
    return if success then result else nil
end

function module.setItem(arg1, input): boolean
    local success, _result = pcall(function()
        MemStorageService:SetItem(arg1.memStorageKey, if not input or input == "" then "" else HttpService:JSONEncode(input))
    end)
    return success
end

function module:bindAndFire(callback): MemStorageConnection
    return (MemStorageService:BindAndFire(self.memStorageKey, function(input)
        local var1 = if input and input ~= "" then HttpService:JSONDecode(input) else nil

        if callback then
            callback(var1)
        end
    end))
end

return module

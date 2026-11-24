-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ScriptProfilerService = game:GetService("ScriptProfilerService")
local Players = game:GetService("Players")

local module = {}
module.__index = module

function module.new(callback: ((...any) -> (...any))?)
    local self = (setmetatable({}, module))

    self._isProfiling = false
    self._isClient = false
    self._player = Players.LocalPlayer

    self._connection = if callback then ScriptProfilerService.OnNewData:Connect(function(player: Player, jsonString: string)
        local bool1 = player ~= nil

        if callback then
            callback(bool1, jsonString)
        end
    end) else nil

    return self
end

function module:ClientStart(num1: number?)
    if self._isProfiling then
        return
    end

    ScriptProfilerService:ClientStart(self._player, num1 or 1000)

    self._isProfiling = true
    self._isClient = true
end

function module:ClientStop()
    if not (self._isProfiling and self._isClient) then
        return
    end

    ScriptProfilerService:ClientStop(self._player)
    ScriptProfilerService:ClientRequestData(self._player)

    self._isProfiling = false
    self._isClient = false
end

function module:ServerStart(num1: number?)
    if self._isProfiling then
        return
    end

    ScriptProfilerService:ServerStart(num1 or 1000)

    self._isProfiling = true
    self._isClient = false
end

function module:ServerStop()
    if not self._isProfiling or self._isClient then
        return
    end

    ScriptProfilerService:ServerStop()
    ScriptProfilerService:ServerRequestData()

    self._isProfiling = false
end

function module:IsProfiling()
    return self._isProfiling
end

function module:Disconnect()
    if self._connection then
        self._connection:Disconnect()
        self._connection = nil
    end
end

return module

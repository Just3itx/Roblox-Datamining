-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Roact = require(scriptParentParentParent.Roact)

local tbl1 = {}
tbl1.__index = tbl1
function tbl1.new(callback)
    local result = {}

    setmetatable(result, { __index = tbl1 })

    result.callback = callback
    result.connected = true
    result.isMock = 231
    return result
end

function tbl1:Fire(arg1)
    if self.connected then
        self.callback(arg1)
    end
end

function tbl1:Disconnect()
    self.connected = false
end

local tbl2 = {}
tbl2.__index = tbl2
function tbl2.new()
    local result = {}

    setmetatable(result, { __index = tbl2 })

    result.connections = {}
    return result
end

function tbl2:Connect(arg1)
    local var1 = tbl1.new(arg1)
    table.insert(self.connections, var1)
    return var1
end

function tbl2:Fire(arg1)
    for _, connection in self.connections do
        connection:Fire(arg1)
    end
end

local module = {}
module.__index = module
function module.new(ultimatelySuccessfulContentIds, ultimatelyTimedOutContentIds, ultimatelyFailedContentIds)
    local result = {}

    setmetatable(result, { __index = module })

    result.mockContentProviderProceedWithLoad = false
    result.contentResolved = false
    result.assetFetchStatuses = {}
    result.signals = {}
    result.preloadAsyncCalled = false
    result.isMock = true
    result.ultimatelySuccessfulContentIds = ultimatelySuccessfulContentIds or {}
    result.ultimatelyTimedOutContentIds = ultimatelyTimedOutContentIds or {}
    result.ultimatelyFailedContentIds = ultimatelyFailedContentIds or {}
    return result
end

function module:mockReload(arg1, arg2)
    self.mockContentProviderProceedWithLoad = false
    self:_staggeredProgress(nil, arg1, arg2 or Enum.AssetFetchStatus.Success)
end

function module:proceedWithLoad()
    self.mockContentProviderProceedWithLoad = true
    Roact.act(function()
        task.wait(0.1)
    end)
end

function module:_setAssetFetchStatus(arg1, arg2)
    self.assetFetchStatuses[arg1] = arg2
    if self.signals[arg1] then
        self.signals[arg1]:Fire(arg2)
    end
end

function module:_staggeredProgress(callback, arg1, arg2)
    self.contentResolved = false

    task.spawn(function()
        while true do
            if self.mockContentProviderProceedWithLoad then
                if self.contentResolved then
                    self:_setAssetFetchStatus(arg1, arg2)
                    if callback then
                        callback(arg1, arg2)
                    end
                    self.mockContentProviderProceedWithLoad = false
                    return
                end

                self:_setAssetFetchStatus(arg1, Enum.AssetFetchStatus.Loading)
                if callback then
                    callback(arg1, Enum.AssetFetchStatus.Loading)
                end
                self.contentResolved = true
                self.mockContentProviderProceedWithLoad = false
            end

            task.wait()
        end
    end)
end

function module:_makeMockSignal()
    return (tbl2.new())
end

function module:GetAssetFetchStatusChangedSignal(arg1)
    if self.signals[arg1] == nil then
        self.signals[arg1] = self:_makeMockSignal()
    end
    return self.signals[arg1]
end

function module:GetAssetFetchStatus(arg1)
    return if self.assetFetchStatuses[arg1] == nil then Enum.AssetFetchStatus.None else self.assetFetchStatuses[arg1]
end

function module:PreloadAsync(arg1, callback)
    self.preloadAsyncCalled = true
    for _, value in ipairs(arg1) do
        if self.ultimatelySuccessfulContentIds[value] then
            self:_staggeredProgress(callback, value, Enum.AssetFetchStatus.Success)
        elseif self.ultimatelyTimedOutContentIds[value] then
            self:_staggeredProgress(callback, value, Enum.AssetFetchStatus.TimedOut)
        elseif self.ultimatelyFailedContentIds[value] then
            self:_staggeredProgress(callback, value, Enum.AssetFetchStatus.Failure)
        else
            task.delay(0, function()
                self:_setAssetFetchStatus(value, Enum.AssetFetchStatus.Success)
                if callback then
                    callback(value, Enum.AssetFetchStatus.Success)
                end
            end)
        end
    end
end

return module

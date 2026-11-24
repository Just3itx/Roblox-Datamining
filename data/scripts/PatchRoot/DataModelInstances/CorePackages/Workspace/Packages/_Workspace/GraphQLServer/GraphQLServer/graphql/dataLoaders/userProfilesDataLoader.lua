-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:51:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQLServerParent = script:FindFirstAncestor("GraphQLServer").Parent
local DataLoader = require(GraphQLServerParent.DataLoader).DataLoader
local Cryo = require(GraphQLServerParent.Cryo)
local FFlagUserProfilePlatformProfile = require(GraphQLServerParent.SharedFlags).FFlagUserProfilePlatformProfile

local fetchProfilesByIds = require(script.Parent.Parent.connectors.UserProfileConnector).fetchProfilesByIds

local module = {}
module.__index = module

local num1 = game:DefineFastInt("UserProfilesDataLoaderClearTime_v1", 15)
local getFFlagRemoveDataLoaderTimer = require(GraphQLServerParent.SharedFlags).getFFlagRemoveDataLoaderTimer

function module.new()
    local tbl1 = {
        loader = nil,
        lastTime = 0,
        fieldsSet = {},
        loadersByFields = {},
        dataLoaderOptions = { batchSize = 50, batchDelay = 0 }
    }

    setmetatable(tbl1, module)
    return tbl1
end

function convertToSet(arg1)
    local result = ({})
    for _, value in arg1 do
        result[value] = true
    end
    return result
end

function module:getFields()
    local fields = {}
    for k, _ in self.fieldsSet do
        table.insert(fields, k)
    end
    return fields
end

function module:makeDataLoader(arg1, tbl1, tbl2)
    self.fieldsSet = Cryo.Dictionary.join(self.fieldsSet, convertToSet(tbl1))
    local tbl3 = tbl2 or self.dataLoaderOptions
    return DataLoader.new(function(arg2)
        return fetchProfilesByIds(arg2, if FFlagUserProfilePlatformProfile then tbl1 else self:getFields(), arg1)
    end, {
        cache = true,
        maxBatchSize = tbl3.batchSize,
        batchScheduleFn = function(arg2)
            task.delay(tbl3.batchDelay, arg2)
        end
    })
end

function module:getLoader(arg1, tbl1, tbl2)
    if not FFlagUserProfilePlatformProfile then
        self.fieldsSet = Cryo.Dictionary.join(self.fieldsSet, convertToSet(tbl1))
        local lastTime = os.clock()
        local bool1

        if getFFlagRemoveDataLoaderTimer() then
            bool1 = false
        else
            local var1 = lastTime - self.lastTime
            bool1 = num1 < var1
        end

        if not self.loader or bool1 then
            self.lastTime = lastTime
            self.loader = self:makeDataLoader(arg1, tbl1, tbl2)
        end
        return self.loader
    end

    local var1 = table.clone(tbl1)
    table.sort(var1)
    local str1 = table.concat(var1, ",")
    local lastTime = os.clock()
    local loadersByField = self.loadersByFields[str1]
    local var2

    if not loadersByField then
        var2 = self:makeDataLoader(arg1, var1, tbl2)
        self.loadersByFields[str1] = { loader = var2, lastTime = lastTime }
        return var2
    end

    if getFFlagRemoveDataLoaderTimer() or not (lastTime - loadersByField.lastTime > num1) then
        return loadersByField.loader
    end

    var2 = self:makeDataLoader(arg1, var1, tbl2)
    self.loadersByFields[str1] = { loader = var2, lastTime = lastTime }
    return var2
end

return module

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:01:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQLServerParent = script:FindFirstAncestor("GraphQLServer").Parent
local Promise = require(GraphQLServerParent.Promise)
local Error = require(GraphQLServerParent.LuauPolyfill).Error

local stringify = require(GraphQLServerParent.GraphQL).stringify

local module = {}
module.__index = module

function module.new(body)
    local tbl1 = { body = body }

    setmetatable(tbl1, module)
    return tbl1
end

function module.text(arg1)
    return Promise.new(function(callback, callback2)
        local success, result = pcall(function()
            if arg1.body.errors then
                for k, error in arg1.body.errors do
                    if type(error) ~= "table" or error.name ~= "GraphQLError" then
                        continue
                    end

                    local errors = arg1.body.errors
                    local tbl1 = {
                        message = error.message,
                        locations = error.locations,
                        extensions = error.extensions,
                        path = error.path
                    }
                    errors[k] = tbl1
                end
            end

            return stringify(arg1.body)
        end)
        if success then
            callback(result)
            return
        end
        callback2(Error.new(result))
    end)
end

return module

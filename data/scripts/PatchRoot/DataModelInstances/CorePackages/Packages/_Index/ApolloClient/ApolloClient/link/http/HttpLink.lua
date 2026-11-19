-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:30:34Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local tbl1 = {}
local ApolloLink = require(script.Parent.Parent.core).ApolloLink

local _selectHttpOptionsAndBody = require(script.Parent.selectHttpOptionsAndBody)

local createHttpLink = require(script.Parent.createHttpLink).createHttpLink

local HttpLink = setmetatable({}, { __index = ApolloLink })
HttpLink.__index = HttpLink

function HttpLink.new(options)
    options = options == nil and {} or options

    local self = setmetatable(ApolloLink.new(createHttpLink(options).request), HttpLink)
    self.options = options
    return self
end
tbl1.HttpLink = HttpLink

return tbl1

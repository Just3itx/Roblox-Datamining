-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local Cryo = require(scriptParent.Cryo)

local tbl1 = {}
tbl1.__index = tbl1

function tbl1.new(arg1, arg2, delimiter)
    return (setmetatable({ ids = tbl1.makeArray(arg2), delimiter = delimiter }, arg1))
end

function tbl1.setIds(arg1, arg2)
    arg1.ids = tbl1.makeArray(arg2)
end

function tbl1.makeArray(arg1): {[any]: any} | {any}
    return if type(arg1) == "table" then arg1 else { arg1 }
end

function tbl1.__tostring(arg1): string
    return table.concat(arg1.ids, arg1.delimiter)
end

local module = {}
module.__index = module

function module.new(str1: string, additionalData)
    local tbl2 = {
        baseUrl = str1:gsub("/*$", ""),
        args = {},
        pathElements = {},
        configurableIds = nil,
        namedIds = {},
        idsDelimiter = ",",
        options = { queryArgs = nil, postBody = nil, headers = nil },
        useExpandedForm = {},
        statusIds = nil,
        additionalData = additionalData or {}
    }

    setmetatable(tbl2, module)

    return tbl2
end

function module:path(str1: string)
    str1 = str1:gsub("^/", ""):gsub("/$", "")
    table.insert(self.pathElements, str1)
    return self
end

function module:id(arg1, arg2)
    if not arg2 and #self.pathElements < 1 then
        warn("Cannot name id or ids because there is no leading path segment and no name is provided")
    end
    local var1 = arg2 or self.pathElements[#self.pathElements]
    self.namedIds[var1] = arg1

    self.configurableIds = tbl1:new(arg1, self.idsDelimiter)
    table.insert(self.pathElements, self.configurableIds)
    return self
end

function module:queryArgWithIds(arg1, arg2)
    local var1 = Cryo.List.join(arg2, self.namedIds[arg1] or {})
    self.namedIds[arg1] = var1
    self.configurableIds = tbl1:new(var1, self.idsDelimiter)
    self.args = Cryo.Dictionary.join(self.args, { [arg1] = self.configurableIds })

    return self
end

function module:expandedQueryArgsWithIds(arg1, arg2)
    self.useExpandedForm[arg1] = true
    self:queryArgWithIds(arg1, arg2)
    return self
end

function module:queryArgs(arg1)
    self.args = Cryo.Dictionary.join(self.args, arg1)
    self.options.queryArgs = Cryo.Dictionary.join(arg1, self.options.queryArgs or {})
    return self
end

function module:body(postBody)
    self.options.postBody = postBody
    return self
end

function module:headers(headers2)
    self.options.headers = headers2
    return self
end

function module.makeKeyMapper(arg1)
    return function(arg2)
        return arg1:getStatusIds() and arg1:makeStatusUrl(arg2) or arg1:makeNamedIdsUrl(arg2)
    end
end

function module:_normalize(arg1)
    return arg1:gsub("/+", "/")
end

function module:makeUri()
    local str1 = ""
    for _, pathElement in ipairs(self.pathElements) do
        str1 ..= "/" .. tostring(pathElement)
    end
    return self:_normalize(str1)
end

local function concatArguments(str1: string, str2: string, arg1, bool1: boolean?)
    if bool1 then
        for _, value in pairs(arg1.ids) do
            str1 = concatArguments(str1, str2, value)
        end

        return str1
    end

    local str3 = tostring(str2) .. "=" .. tostring(arg1)
    return if str1:len() > 1 then str1 .. "&" .. str3 else str3
end

function module:makeQueryArgs(arg1, bool1: boolean?)
    self:_plugInConfigurableIds(arg1)
    local str1 = ""
    for k, arg in pairs(self.args) do
        if bool1 and self.namedIds[k] or not bool1 then
            str1 = concatArguments(str1, k, arg, self.useExpandedForm[k])
        end
    end
    return if str1:len() > 1 then "?" .. str1 else ""
end

function module:makeUrl(arg1, bool1: boolean?)
    self:_plugInConfigurableIds(arg1)
    return self.baseUrl .. self:makeUri() .. self:makeQueryArgs(arg1, bool1)
end

function module:makeStatusUrl(arg1)
    local var1 = self.baseUrl .. self:makeUri()
    if not arg1 then
        return var1
    end
    local var2 = type(arg1) == "table" and arg1 or { arg1 }
    local str1 = ""
    for k, value in pairs(var2) do
        if k > 1 then
            str1 = str1 .. "&" .. value or value
        else
            str1 = value
        end
    end
    return var1 .. "?" .. str1
end

function module.makeNamedIdsUrl(arg1, arg2)
    return arg1:makeUrl(arg2, true)
end

function module:makeOptions()
    return self.options
end

function module:_plugInConfigurableIds(arg1)
    if arg1 ~= nil and self.configurableIds then
        self.configurableIds:setIds(arg1)
    end
end

function module:getIds()
    return if self.configurableIds and self.configurableIds.ids then self.configurableIds.ids elseif self.statusIds then self.statusIds else {}
end

function module:getNamedIds()
    return self.namedIds
end

function module:setStatusIds(arg1)
    if self.configurableIds then
        warn("Cannot set statusIds because ids already provided in URl")
    else
        self.statusIds = Cryo.List.join(self.statusIds or {}, arg1)
    end

    return self
end

function module:getStatusIds()
    return if self.configurableIds then nil else self.statusIds
end

function module:getAdditionalData()
    return self.additionalData or {}
end

return module

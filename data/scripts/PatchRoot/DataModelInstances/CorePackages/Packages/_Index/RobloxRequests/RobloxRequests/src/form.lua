-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local lib = scriptParentParent.lib
local _src = scriptParentParent.src

local HttpService = game:GetService("HttpService")

local mimetypes = require(lib.mimetypes)
local b64 = require(lib.b64)

local function randomString(num1: number): string
    local str1 = ""

    for _ = 1, num1 do
        str1 ..= string.char(math.random(97, 122))
    end

    return str1
end

local File = {}
File.__index = File
function File.new(...)
    local self = setmetatable({}, File)

    self.__IsFile = true

    self.name = "unknown"
    self.content = ""
    self.content_type = nil

    local tbl2 = { ... }
    if #tbl2 == 1 then
        self.content = tbl2[1]
    elseif #tbl2 >= 2 then
        self.name = tbl2[1]
        self.content = tbl2[2]
        self.content_type = tbl2[3]
    end

    if not self.content_type then
        local var1 = self.name:split(".")
        local var2 = var1[#var1]

        self.content_type = mimetypes[var2:lower()] or "text/plain"
    end

    if type(self.content) ~= "string" then
        error(("[http] Invalid file content for file %s"):format(self.name))
    end

    return self
end

function File:__tostring(): string
    return ("File('%s', '%s')"):format(self.name, self.content_type)
end

local FormData = {}
FormData.__index = FormData
function FormData.new(arg1)
    local self = setmetatable({}, FormData)
    self.__FormData = true

    self.boundary = "--FormBoundary-" .. randomString(28)
    self.content_type = "application/x-www-form-urlencoded"

    self.fields = {}

    for k, value in pairs(arg1 or {}) do
        self:AddField(k, value)
    end

    return self
end

function FormData:AddField(arg1, arg2)
    if arg2.__IsFile then
        self.content_type = "multipart/form-data; boundary=\"" .. self.boundary .. "\""
    end

    table.insert(self.fields, { Name = arg1, Value = arg2 })
end

function FormData:build()
    local str1 = ""

    if self.content_type ~= "application/x-www-form-urlencoded" then
        for _, field in pairs(self.fields) do
            local var1 = str1 .. "--" .. self.boundary .. "\r\n"

            local fieldValue = field.Value

            local var2 = var1 .. ("Content-Disposition: form-data; name=\"%s\""):format(field.Name)

            if field.Value.__IsFile then
                fieldValue = field.Value.content

                var2 = (var2 .. ("; filename=\"%s\""):format(field.Value.name)) .. "\r\nContent-Type: " .. field.Value.content_type

                if field.Value.content_type:sub(1, 5) ~= "text/" then
                    fieldValue = b64.encode(fieldValue)
                    var2 ..= "\r\nContent-Transfer-Encoding: base64"
                end
            end

            str1 = var2 .. "\r\n\r\n" .. fieldValue .. "\r\n"
        end
        return str1 .. "--" .. self.boundary .. "--"
    end

    for _, field in ipairs(self.fields) do
        if field.Value.__IsFile then
            error("[http] URL encoded forms cannot contain any files")
        end

        if field.Name:find("=") or field.Name:find("&") then
            error("[http] Form field names must not contain '=' or '&'")
        end

        if type(field.Value) == "table" then
            for _, value in ipairs(field.Value) do
                if #str1 > 0 then
                    str1 ..= "&"
                end

                str1 ..= field.Name .. "=" .. HttpService:UrlEncode(value)
            end
        else
            if #str1 > 0 then
                str1 ..= "&"
            end

            str1 ..= field.Name .. "=" .. HttpService:UrlEncode(field.Value)
        end
    end

    return str1
end

return { FormData = FormData, File = File }

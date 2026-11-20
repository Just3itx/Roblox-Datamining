-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local lib = scriptParentParent.lib
local src = scriptParentParent.src

local json = require(src.json)
local url = require(lib.url)

local function maybe_number(arg1) -- Luacid: unused: defined but never referenced
    return tonumber(arg1) or arg1
end

local function trim(arg1)
    arg1 = arg1 or ""

    while arg1:sub(1, 1) == " " do
        arg1 = arg1:sub(2)
    end

    while arg1:sub(-1, -1) == " " do
        arg1 = arg1:sub(1, -2)
    end

    return arg1
end

local tbl1 = {}
tbl1.__index = tbl1
function tbl1.new(name, value, arg3)
    local self = setmetatable({}, tbl1)

    arg3 = arg3 or {}

    self.name = name
    self.value = value

    self.domain = arg3.domain or ""
    self.path = arg3.path or ""

    return self
end

function tbl1.fromSet(arg1)
    local tbl2 = {}

    local var1 = arg1:split(";")

    local var2 = var1[1]:split("=")
    local var3 = trim(var2[1])
    local var4 = trim(var2[2])

    for i = 2, #var1 do
        local var5 = var1[i]:split("=")
        tbl2[trim(var5[1]):lower()] = trim(var5[2])
    end

    return tbl1.new(var3, var4, tbl2)
end

function tbl1:matches(arg1)
    if not self.domain then
        return true
    end

    local var1 = url.parse(arg1)

    if self.domain:sub(1, 1) == "." then
        if var1.host:sub(-#self.domain, -1) ~= self.domain and var1.host ~= self.domain:sub(2) then
            return false
        end
    elseif var1.host ~= self.domain then
        return false
    end

    return not self.path or not var1.path:sub(1, #self.path) ~= self.path or false
end

local module = {}
module.__index = module
function module.new()
    local self = setmetatable({}, module)

    self.__cookiejar = true

    self.cookies = {}

    return self
end

function module:insert(arg1, arg2, arg3)
    self.cookies[arg1] = tbl1.new(arg1, arg2, arg3)

    return self
end

function module:SetCookie(arg1)
    local set = tbl1.fromSet(arg1)

    self.cookies[set.name] = set
end

function module:delete(arg1)
    self.cookies[arg1] = nil
end

function module:string(_): string
    local str1 = ""

    for _, value in pairs(self.cookies) do
        str1 = (str1 and str1 .. "; ") .. ("%s=%s"):format(value.name, value.value)
    end

    return str1
end

function module.__tostring(arg1)
    return json.enc(arg1.domains)
end

return module
